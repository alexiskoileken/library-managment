codeunit 50100 "Library Management"
{
    procedure CheckApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
    begin
        if not WorkflowMgt.CanExecuteWorkflow(RecRef, GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef)) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure GetWorkflowCode(WorkflowCode: code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name), '=', ' '));
    end;


    [IntegrationEvent(false, false)]
    procedure OnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
    end;

    // Add events to the library

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.Open(Database::"book Lending");
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), Database::"book Lending",
          GetWorkflowEventDesc(WorkflowSendForApprovalEventDescTxt, RecRef), 0, false);
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), DATABASE::"book Lending",
          GetWorkflowEventDesc(WorkflowCancelForApprovalEventDescTxt, RecRef), 0, false);
    end;
    // subscribe

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Library Management", 'OnSendWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Library Management", 'OnCancelWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), RecRef);
    end;

    procedure GetWorkflowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text
    begin
        exit(StrSubstNo(WorkflowEventDesc, RecRef.Name));
    end;

    // handle the document;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BookLending: Record "book Lending";
    begin
        case RecRef.Number of
            Database::"book Lending":
                begin
                    RecRef.SetTable(BookLending);
                    BookLending.Validate(Status, BookLending.Status::Open);
                    BookLending.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var

    begin
        case RecRef.Number of
            Database::"book Lending":
                begin
                    RecRef.SetTable(BookLending);
                    BookLending.Validate(Status, BookLending.Status::Pending);
                    BookLending.Modify(true);
                    Variant := BookLending;
                    IsHandled := true;
                    BookLendingLn.reset();
                    Booklendingln.setrange(Status, Booklendingln.status::Available);
                    if BookLendingLn.FindSet() then begin
                        repeat
                            BookLendingLn.status := Booklendingln.status::Booked;
                            BookLendingLn.Modify(true)
                        until BookLendingLn.Next() = 0;
                    end;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        BookLending: Record "book Lending";
    begin
        case RecRef.Number of
            DataBase::"book Lending":
                begin
                    RecRef.SetTable(BookLending);
                    ApprovalEntryArgument."Document No." := BookLending."Lending No.";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var

    begin
        case RecRef.Number of
            DataBase::"book Lending":
                begin
                    RecRef.SetTable(BookLending);
                    BookLending.Validate(Status, BookLending.Status::Approved);
                    BookLending.Modify(true);
                    BookLendingLn.reset();
                    Books.reset();
                    Booklendingln.setrange(Status, Booklendingln.status::Booked);
                    Books.setrange(Status, Books.status::Available);
                    if BookLendingLn.FindSet() then begin
                        repeat
                            BookLendingLn.status := Booklendingln.status::Approved;
                            books.status := books.status::booked;
                            BookLendingLn.Modify(true);
                            books.Modify(true);
                        until BookLendingLn.Next() = 0;
                    end;
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;

    begin
        case ApprovalEntry."Table ID" of
            DataBase::"book Lending":
                begin
                    if BookLending.Get(ApprovalEntry."Document No.") then begin
                        BookLending.Validate(Status, BookLending.Status::Rejected);
                        BookLending.Modify(true);
                        BookLendingLn.reset();
                        books.reset();
                        BookLendingLn.SetRange(Status, BookLendingLn.Status::Approved);
                        books.SetRange(Status, books.Status::Booked);
                        if BookLendingLn.findset() then begin
                            repeat
                                BookLendingLn.status := Booklendingln.status::Available;
                                books.status := books.status::Available;
                                BookLendingLn.Modify(true);
                                books.Modify(true);
                            until BookLendingLn.Next() = 0;

                        end
                    end;
                end;
        end;
    end;

    var

        WorkflowMgt: Codeunit "Workflow Management";

        RUNWORKFLOWONSENDFORAPPROVALCODE: Label 'RUNWORKFLOWONSEND%1FORAPPROVAL';
        RUNWORKFLOWONCANCELFORAPPROVALCODE: Label 'RUNWORKFLOWONCANCEL%1FORAPPROVAL';
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        WorkflowSendForApprovalEventDescTxt: Label 'Approval of %1 is requested.';
        WorkflowCancelForApprovalEventDescTxt: Label 'Approval of %1 is canceled.';
        BookLendingLn: Record "Book Lending Line";
        BookLending: Record "book Lending";
        books: record book;



}
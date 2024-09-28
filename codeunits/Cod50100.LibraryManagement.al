/// <summary>
/// Codeunit Library Management (ID 50100).
/// </summary>
codeunit 50100 "Library Management"
{

    /// <summary>
    /// CheckApprovalsWorkflowEnabled.
    /// </summary>
    /// <param name="Var RecRef">RecordRef.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CheckApprovalsWorkflowEnabled(Var RecRef: RecordRef): Boolean
    begin
        if not WorkflowMgt.CanExecuteWorkflow(RecRef, GetSendWorkflowCode(RUNWORKFLOWONSENDAPPROVALCODE, RecRef)) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    /// <summary>
    /// GetWorkflowCode.
    /// </summary>
    /// <param name="WorkflowCode">code[128].</param>
    /// <param name="RecRef">RecordRef.</param>
    /// <returns>Return value of type Code[128].</returns>

    // Check if the setup is establish in the frontend 
    procedure GetSendWorkflowCode(WorkflowCode: code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name), '=', ' '));
    end;

    /// <summary>
    /// GetCancelWorkflowCode.
    /// </summary>
    /// <param name="WorkflowCode">code[128].</param>
    /// <param name="RecRef">RecordRef.</param>
    /// <returns>Return value of type Code[128].</returns>
    procedure GetCancelWorkflowCode(WorkflowCode: code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(StrSubstNo(WorkflowCode, RecRef.Name));
    end;

    /// <summary>
    /// OnSendForApproval.
    /// </summary>
    /// <param name="RecRef">RecordRef.</param>
    [IntegrationEvent(false, false)]
    procedure OnSendForApproval(RecRef: RecordRef)
    begin
    end;

    /// <summary>
    /// OnCancelForApproval.
    /// </summary>
    /// <param name="RecRef">RecordRef.</param>
    [IntegrationEvent(false, false)]
    procedure OnCancelForApproval(RecRef: RecordRef)
    begin
    end;

    //Adding the event to the library

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        RecRef: RecordRef;
    begin
        WorkflowEventHandling.AddEventToLibrary(GetSendWorkflowCode(RUNWORKFLOWONSENDAPPROVALCODE, RecRef), DATABASE::"Book Lending",
                GetApprovalDescriptionText(SendForApprovalEventDescTxt, RecRef), 0, false);
        WorkflowEventHandling.AddEventToLibrary(GetCancelWorkflowCode(RUNWORKFLOWONCANCELAPPROVALCODE, RecRef), DATABASE::"Book Lending",
           GetApprovalDescriptionText(CancelForApprovalEventDescTxt, RecRef), 0, false);

    end;

    local procedure GetApprovalDescriptionText(DescriptionTxt: text[250]; RecRef: RecordRef): text[250]
    var
    begin
        exit(StrSubstNo(DescriptionTxt, Recref));
    end;

    // subscribing to the publish events


    /// <summary>
    /// RunWorkflowOnSendForApproval.
    /// </summary>
    /// <param name="RecRef">RecordRef.</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Library Management", 'OnSendForApproval', '', false, false)]
    procedure RunWorkflowOnSendForApproval(RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(GetSendWorkflowCode(RUNWORKFLOWONSENDAPPROVALCODE, RecRef), Database::"Book Lending");
    end;

    /// <summary>
    /// RunWorkflowOnCancelForApproval.
    /// </summary>
    /// <param name="RecRef">RecordRef.</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Library Management", 'OnSendForApproval', '', false, false)]
    procedure RunWorkflowOnCancelForApproval(RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(GetCancelWorkflowCode(RUNWORKFLOWONCANCELAPPROVALCODE, RecRef), Database::"Book Lending");
    end;
    // modifying the document state

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; Handled: Boolean)
    Var
        Book: Record Book;
        BookLending: Record "Book Lending";
    begin
        case RecRef.number of
            Database::"Book Lending":
                begin
                    RecRef.SetTable(BookLending);
                    BookLending.Validate(Status, BookLending.status::Open);
                    book.Reset();
                    Book.SetRange(Status, book.Status::Available);
                    book.Status := book.status::Available;
                    BookLending.Modify(true);
                    book.Modify(true);
                    Handled := true;
                end;

        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var

        BookLending: Record "Book Lending";
    begin
        case
            RecRef.Number of
            Database::"Book Lending":
                begin
                    RecRef.SetTable(BookLending);
                    BookLending.Validate(Status, BookLending.Status::Pending);
                    BookLending.Modify(true);

                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BookLending: Record "Book Lending";
        BookLendingLn: record "Book Lending Line";

    begin
        case RecRef.Number of
            DataBase::"Book Lending":
                begin
                    RecRef.SetTable(BookLending);
                    BookLending.Validate(Status, BookLending.Status::Approved);
                    BookLending.Modify(true);
                    BookLendingLn.Reset();
                    BookLendingLn.SetRange(Status, BookLendingLn.Status::Available);
                    if BookLendingLn.FindSet() then begin
                        repeat
                            BookLendingLn.Status := BookLendingLn.Status::Approved;
                            BookLendingLn.Modify(true);
                        until BookLendingLn.Next() = 0;
                        Handled := true;
                    end;
                end;
        end;
    end;

    var
        WorkflowMgt: Codeunit "Workflow Management";
        NoWorkflowEnabledErr:
                Label 'No approval workflow for this record type is enabled.';
        RUNWORKFLOWONSENDAPPROVALCODE:
                label 'RunWorkflowOnSend%1ForApprovalCode';
        RUNWORKFLOWONCANCELAPPROVALCODE:
                label 'RunWorkflowOnSend%1ForApprovalCode';
        SendForApprovalEventDescTxt:
                Label 'Approval of a %1 is requested.';
        CancelForApprovalEventDescTxt:
                Label 'Approval of a %1 is Canceled.';
}

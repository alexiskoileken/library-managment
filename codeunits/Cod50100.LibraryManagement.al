
/// <summary>
/// Codeunit Library Management (ID 50100).
/// </summary>
codeunit 50100 "Library Management"
{
    /// <summary>
    /// CheckApprovalsWorkflowEnabled.
    /// </summary>
    /// <param name="RecRef">VAR RecordRef.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CheckApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
    var
        myInt: Integer;
    begin
        if not WorkflowMgt.CanExecuteWorkflow(RecRef, RunWorkflowOnSendForApprovalCode(RUNWORKFLOWONSENDAPPROVALCODE, RecRef)) then
            Error(NoWorkflowEnabledErr);
        exit(true);

    end;

    /// <summary>
    /// RunWorkflowOnSendForApprovalCode.
    /// </summary>
    /// <param name="ApprovalCode">Code[128].</param>
    /// <param name="RecRef">RecordRef.</param>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnSendForApprovalCode(ApprovalCode: Code[128]; RecRef: RecordRef): Code[128]
    var
        myInt: Integer;
    begin
        exit(DelChr(StrSubstNo(ApprovalCode, RecRef.Name), '=', ' '))
    end;

    /// <summary>
    /// RunWorkflowOnCancelForApprovalCode.
    /// </summary>
    /// <param name="ApprovalCode">Code[128].</param>
    /// <param name="RecRef">RecordRef.</param>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnCancelForApprovalCode(ApprovalCode: Code[128]; RecRef: RecordRef): Code[128]
    var
        myInt: Integer;
    begin
        exit(StrSubstNo(ApprovalCode, RecRef.Name));
    end;

    /// <summary>
    /// OnSendForApproval.
    /// </summary>
    /// <param name="Recref">VAR RecordRef.</param>
    [IntegrationEvent(false, false)]
    procedure OnSendForApproval(var Recref: RecordRef)
    begin
    end;

    /// <summary>
    /// OnCancelForApproval.
    /// </summary>
    /// <param name="Recref">VAR RecordRef.</param>
    [IntegrationEvent(false, false)]
    procedure OnCancelForApproval(var Recref: RecordRef)
    begin
    end;

    // add events to the library 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        Recref: RecordRef;
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendForApprovalCode(RUNWORKFLOWONSENDAPPROVALCODE, RecRef), Database::"Book Lending",
        ApprovalEventDescTxt(SendForApprovalEventDescTxt, Recref), 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendForApprovalCode(RUNWORKFLOWONCANCELAPPROVALCODE, RecRef), Database::"Book Lending",
       ApprovalEventDescTxt(CancelForApprovalEventDescTxt, Recref), 0, false);
    end;

    /// <summary>
    /// ApprovalEventDescTxt.
    /// </summary>
    /// <param name="DescriptionTxt">text[250].</param>
    /// <param name="RecRef">RecordRef.</param>
    /// <returns>Return value of type text [250].</returns>
    procedure ApprovalEventDescTxt(DescriptionTxt: text[250]; RecRef: RecordRef): text[250]
    var
        myInt: Integer;
    begin
        exit(StrSubstNo(DescriptionTxt, RecRef))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Library Management", 'OnSendForApproval', '', false, false)]
    local procedure RunWorkflowOnSendWorkflowForApproval(RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(RunWorkflowOnSendForApprovalCode(RUNWORKFLOWONSENDAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Library Management", 'OnCancelForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelWorkflowForApproval(RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(RunWorkflowOnCancelForApprovalCode(RUNWORKFLOWONCANCELAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BookLending: Record "Book Lending";
    begin
        case RecRef.Number of
            Database::"Book Lending":
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
        BookLending: Record "Book Lending";
    begin
        case RecRef.Number of
            Database::"Book Lending":
                begin
                    RecRef.SetTable(BookLending);
                    BookLending.Validate(Status, BookLending.Status::Pending);
                    BookLending.Modify(true);
                    Variant := BookLending;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        BookLending: Record "Book Lending";
    begin
        case RecRef.Number of
            DataBase::"Book Lending":
                begin
                    RecRef.SetTable(BookLending);
                    ApprovalEntryArgument."Document No." := BookLending."Lending No.";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BookLending: Record "Book Lending";
    begin
        case RecRef.Number of
            DataBase::"Book Lending":
                begin
                    RecRef.SetTable(BookLending);
                    BookLending.Validate(Status, BookLending.Status::Approved);
                    BookLending.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        BookLending: Record "Book Lending";
        v: Codeunit "Record Restriction Mgt.";
    begin
        case ApprovalEntry."Table ID" of
            DataBase::"Book Lending":
                begin
                    if BookLending.Get(ApprovalEntry."Document No.") then begin
                        BookLending.Validate(Status, BookLending.Status::Rejected);
                        BookLending.Modify(true);
                    end;
                end;
        end;
    end;



    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
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

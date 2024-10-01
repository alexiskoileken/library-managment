/// <summary>
/// Page Book Lending (ID 50108).
/// </summary>
page 50108 "Book Lending"
{
    ApplicationArea = All;
    Caption = 'Book Lending';
    PageType = Card;
    SourceTable = "Book Lending";
    RefreshOnActivate = true;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Lending No."; Rec."Lending No.")
                {
                    ToolTip = 'Specifies the value of the Lending No. field.', Comment = '%';
                }
                field(Desctription; Rec.Desctription)
                {
                    ToolTip = 'Specifies the value of the Desctription field.', Comment = '%';
                }
                field("Status "; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
            group(PatronDetails)
            {
                Caption = 'Patron Details';
                field("Patron ID"; Rec."Patron ID")
                {
                    ToolTip = 'Specifies the value of the Patron ID field.', Comment = '%';
                }
                field("Patron Name"; Rec."Patron Name")
                {
                    ToolTip = 'Specifies the value of the Patron Name field.', Comment = '%';
                }
                field("Patron Email"; Rec."Patron Email")
                {
                    ToolTip = 'Specifies the value of the Patron Email field.', Comment = '%';
                }
                field("Patron Phone No."; Rec."Patron Phone No.")
                {
                    ToolTip = 'Specifies the value of the Patron Phone No. field.', Comment = '%';
                }
            }
            group(System)
            {
                Caption = 'System';
                field("Lending Date-Time"; Rec."Lending Date-Time")
                {
                    ToolTip = 'Specifies the value of the Lending Date-time field.', Comment = '%';
                }
                field("Issued By"; Rec."Issued By")
                {
                    ToolTip = 'Specifies the value of the Lended by field.', Comment = '%';
                }
            }
            part(BookLendingLine; "Book Lending Line")
            {
                ApplicationArea = all;
                SubPageLink = "Lending ID" = field("Lending No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Approval Requests")
            {
                caption = 'Approval Requests';
                action(SendApprovalRequest)
                {
                    Caption = 'Submit';
                    ApplicationArea = basic, suite;
                    Image = SendApprovalRequest;
                    Tooltip = 'Request approval for the book to borrow.';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = Not OpenApprovalEntriesExistCurrUser;
                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                        LibraryMgt: Codeunit "Library Management";
                    begin
                        RecRef.GetTable(Rec);
                        if LibraryMgt.CheckApprovalsWorkflowEnabled(RecRef) then
                            LibraryMgt.OnSendWorkflowForApproval(RecRef);
                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Re-Open';
                    ApplicationArea = basic, suite;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = CanCancelApprovalForRecord;

                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                        LibraryMgt: Codeunit "Library Management";
                    begin
                        RecRef.GetTable(rec);
                        LibraryMgt.OnCancelWorkflowForApproval(RecRef);
                    end;
                }
            }
        }
        area(Creation)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Promoted = true;
                    PromotedCategory = New;
                    Visible = OpenApprovalEntriesExistCurrUser;
                    trigger OnAction()

                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()

                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;

                    PromotedCategory = New;


                    trigger OnAction()
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View approval requests.';
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
        }

    }

    trigger OnAfterGetCurrRecord()
    begin
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        HasApprovalEntries := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId);
    end;


    var
        OpenApprovalEntriesExistCurrUser, OpenApprovalEntriesExist, CanCancelApprovalForRecord
        , HasApprovalEntries : Boolean;
        books: Record Book;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

}


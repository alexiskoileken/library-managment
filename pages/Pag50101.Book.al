/// <summary>
/// Page Book (ID 50101).
/// </summary>
page 50101 Book
{
    ApplicationArea = All;
    Caption = 'Book';
    PageType = Card;
    SourceTable = Book;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Book Id"; Rec."Book Id")
                {
                    ToolTip = 'Specifies the value of the Book Id field.', Comment = '%';
                }
                field("Title "; Rec."Title ")
                {
                    ToolTip = 'Specifies the value of the Title field.', Comment = '%';
                }
                field(ISBN; Rec.ISBN)
                {
                    ToolTip = 'Specifies the value of the ISBN field.', Comment = '%';
                }
                field(Genre; Rec.Genre)
                {
                    ToolTip = 'Specifies the value of the Genre field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Created At"; Rec."Created At")
                {
                    ToolTip = 'specifies the value of the Created At field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'specifies the value of the Created By field.', Comment = '%';
                }
            }
            part(Authors; "Book Authors")
            {
                ApplicationArea = All;
                SubPageLink = "Book No." = field("Book Id");
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

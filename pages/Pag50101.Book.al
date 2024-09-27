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
}

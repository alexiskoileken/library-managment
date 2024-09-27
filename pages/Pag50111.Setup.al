/// <summary>
/// Page Setup (ID 50111).
/// </summary>
page 50111 Setup
{
    ApplicationArea = All;
    Caption = 'Setup';
    PageType = List;
    SourceTable = "Library Setup";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Patron ID"; Rec."Patron ID")
                {
                    ToolTip = 'Specifies the value of the Patron No field.', Comment = '%';
                }
                field(BookLending; Rec.BookLending)
                {
                    ToolTip = 'Specifies the value of the Book lending field.', Comment = '%';
                }
                field(BooksId; Rec.BooksId)
                {
                    ToolTip = 'Specifies the value of the BooksId field.', Comment = '%';
                }
            }
        }
    }
}

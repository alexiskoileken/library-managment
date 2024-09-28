/// <summary>
/// Page Book Lending Line (ID 50110).
/// </summary>
page 50110 "Book Lending Line"
{
    ApplicationArea = All;
    Caption = 'Book Lending Line';
    PageType = ListPart;
    SourceTable = "Book Lending Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Book No."; Rec."Book No.")
                {
                    ToolTip = 'Specifies the value of the Book No. field.', Comment = '%';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.', Comment = '%';
                }
                field(ISNB; Rec.ISNB)
                {
                    ToolTip = 'Specifies the value of the ISNB field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {

                }

            }
        }
    }
}

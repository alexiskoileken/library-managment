/// <summary>
/// Page Book lendings (ID 50109).
/// </summary>
page 50109 "Book lendings"
{
    ApplicationArea = All;
    Caption = 'Book lendings';
    PageType = List;
    SourceTable = "Book Lending";
    CardPageId = "Book Lending";
    DeleteAllowed = false;
<<<<<<< HEAD
    UsageCategory = Lists;
=======
>>>>>>> origin/main


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lending No."; Rec."Lending No.")
                {
                    ToolTip = 'Specifies the value of the Lending No. field.', Comment = '%';
                }
                field(Desctription; Rec.Desctription)
                {
                    ToolTip = 'Specifies the value of the Desctription field.', Comment = '%';
                }
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
                field("Status "; Rec.Status)
                {

                }
            }
        }
    }

}

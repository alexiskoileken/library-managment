/// <summary>
/// Page Patron Statistics (ID 50117).
/// </summary>
page 50117 "Patron Statistics"
{
    ApplicationArea = All;
    Caption = 'Patron Statistics';
    PageType = CardPart;
    SourceTable = Patron;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            field("Patron ID"; Rec."Patron ID")
            {
                ToolTip = 'Specifies the value of the Patron ID field.', Comment = '%';
            }
            field("First Name"; Rec."First Name")
            {
                ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
            }
            field(Status; Rec.Status)
            {
                ToolTip = 'Specifies the value of the Status field.', Comment = '%';
            }
        }
    }
}

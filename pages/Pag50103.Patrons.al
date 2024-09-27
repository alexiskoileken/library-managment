/// <summary>
/// Page Patrons (ID 50103).
/// </summary>
page 50103 Patrons
{
    ApplicationArea = All;
    Caption = 'Patrons';
    PageType = List;
    SourceTable = Patron;
    UsageCategory = Lists;
    CardPageId = Patron;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Patron ID"; Rec."Patron ID")
                {
                    ToolTip = 'Specifies the value of the Patron ID field.', Comment = '%';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Second Name"; Rec."Second Name")
                {
                    ToolTip = 'Specifies the value of the Second Name field.', Comment = '%';
                }
                field("Phone No"; Rec."Phone No")
                {
                    ToolTip = 'Specifies the value of the Phone No field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.', Comment = '%';
                }
            }
        }
    }
}

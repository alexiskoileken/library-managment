/// <summary>
/// Page Patron (ID 50102).
/// </summary>
page 50102 Patron
{
    ApplicationArea = All;
    Caption = 'Patron';
    PageType = Card;
    SourceTable = Patron;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                field("Modified By"; Rec."Modified By")
                {
                    ToolTip = 'Specifies the value of the Modified By field.', Comment = '%';
                }
                field("modified date-time"; Rec."modified date-time")
                {
                    ToolTip = 'Specifies the value of the modified date-time field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {

                }
            }
        }
    }

}

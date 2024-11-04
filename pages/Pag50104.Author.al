/// <summary>
/// Page Author (ID 50104).
/// </summary>
page 50104 Author
{
    ApplicationArea = All;
    Caption = 'Author';
    PageType = List;
    SourceTable = Author;
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Author ID"; Rec."Author ID")
                {
                    ToolTip = 'Specifies the value of the Author ID field.', Comment = '%';
                }
                field("First Name "; Rec."First Name ")
                {
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Second Name"; Rec."Second Name")
                {
                    ToolTip = 'Specifies the value of the Second Name field.', Comment = '%';
                }
                field("Email "; Rec."Email ")
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.', Comment = '%';
                }
            }

        }
        area(FactBoxes)
        {
            part(mypart; "Vendor Picture")
            {
                ApplicationArea = all;
            }
            systempart(notes; Notes)
            {
                ApplicationArea = basic, suite;
            }
            systempart(link; Links)
            {
                ApplicationArea = basic, suite;
            }

        }
    }
}

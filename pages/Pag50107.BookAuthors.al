/// <summary>
/// Page Book Authors (ID 50107).
/// </summary>
page 50107 "Book Authors"
{
    ApplicationArea = All;
    Caption = 'Book Authors';
    PageType = ListPart;
    SourceTable = "Book Authors  ";

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
    }
}

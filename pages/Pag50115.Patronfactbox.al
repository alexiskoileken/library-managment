/// <summary>
/// Page Patron factbox (ID 50115).
/// </summary>
page 50115 "Patron factbox"
{
    ApplicationArea = All;
    Caption = 'Patron Details';
    PageType = CardPart;
    SourceTable = "Book Lending";
    RefreshOnActivate = true;


    layout
    {
        area(Content)
        {
            field("Patron ID"; Rec."Patron ID")
            {
                ToolTip = 'Specifies the value of the patron id.', Comment = '%';
                trigger OnDrillDown()
                var
                    myInt: Integer;
                begin
                    ShowPartronDetails();
                end;
            }
            cuegroup(control001)
            {
                ShowCaption = false;
                field("Number of books"; Rec."Number of books")
                {
                    ToolTip = 'Specifies the value of the Number of books field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                    begin
                        ShowBooks();
                    end;
                }
            }
            cuegroup(control01)
            {
                ShowCaption = false;
                field("Ongoing customer sales"; Rec."Ongoing customer sales")
                {
                    DrillDownPageId = "Customer Card";
                }
            }
        }
    }
    local procedure ShowPartronDetails()
    var
        myInt: Integer;
    begin
        Page.Run(Page::Patron);
    end;

    local procedure ShowBooks()
    var
        myInt: Integer;
    begin
        Page.Run(Page::"Book Lending");
    end;
}

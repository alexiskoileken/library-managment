/// <summary>
/// Page Library Activities (ID 50114).
/// </summary>
page 50114 "Library Activities"
{
    ApplicationArea = All;
    Caption = 'Library Activities';
    PageType = CardPart;
    SourceTable = "Books Lending cues";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup("Library Activities")
            {
                Caption = 'Library Activities';
                CuegroupLayout = wide;

                field("Total books"; Rec."Total books")
                {
                    ToolTip = 'Specifies the value of the Total books field.', Comment = '%';
                    DrillDownPageId = Books;
                    Editable = false;
                    ApplicationArea = basic, suite;
                }
                field(patron; Rec.patron)
                {
                    ToolTip = 'Specifies the value of the patron field.', Comment = '%';
                    DrillDownPageId = Patron;
                    Editable = false;
                    ApplicationArea = basic, suite;
                }
                field(booklending; Rec.booklending)
                {
                    ToolTip = 'Specifies the value of the Approved Transactions field.', Comment = '%';
                    DrillDownPageId = "Book lendings";
                    Editable = false;
                    ApplicationArea = basic, suite;

                }
                field("available books"; Rec."available books")
                {
                    ToolTip = 'Specifies the value of the Available books field.', Comment = '%';
                    DrillDownPageId = Books;
                    Editable = false;
                    ApplicationArea = basic, suite;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}

/// <summary>
/// Page Patron Picture (ID 50116).
/// </summary>
page 50116 "Patron Picture"
{
    ApplicationArea = All;
    Caption = 'Patron Picture';
    PageType = CardPart;
    SourceTable = Patron;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;
                field(Picture; Rec.Picture)
                {
                    ToolTip = 'Specifies patron picture field';
                }

            }

        }


    }
    actions
    {
        area(Processing)
        {
            action(import)
            {
                Caption = 'import';
                Image = Import;
                ApplicationArea = all;
                trigger OnAction()
                var
                    CustomMgt: Codeunit "Custom Management";
                begin
                    CustomMgt.ImportItemPicture(Rec);
                end;

            }
            action(Delete)
            {
                Caption = 'Delete';
                Image = Delete;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Rec.TestField(Picture);
                    Clear(Rec.Picture);
                    Rec.Modify(true)
                end;
            }
            action(Export)
            {
                Caption = 'Export';
                Image = Export;
                ApplicationArea = all;
                trigger OnAction()
                var
                    myInt: Integer;
                begin

                end;
            }
        }
    }

}

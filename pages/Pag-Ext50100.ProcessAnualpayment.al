/// <summary>
/// PageExtension Process Anual payment  (ID 50100) extends Record Customer List.
/// </summary>
pageextension 50100 "Process Anual payment " extends "Customer List"
{
    layout
    {
        modify("Phone No.")
        {
            Visible = false;
        }
    }
    actions
    {
        addlast(processing)
        {

            action(AnualPayment)
            {
                ApplicationArea = all;
                Caption = 'Process Anual payment';
                RunObject = report "Process Anual transactions";
                Promoted = true;
                PromotedCategory = Process;
                Image = Calculate;

            }
        }
    }
}

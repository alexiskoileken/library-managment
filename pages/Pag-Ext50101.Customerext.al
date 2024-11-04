/// <summary>
/// PageExtension CustomerMod (ID 50101) extends Record Customer List.
/// </summary>
pageextension 50101 CustomerMod extends "Customer Card"
{
    layout
    {
        modify("Phone No.")
        {
            Visible = false;
        }
    }
}

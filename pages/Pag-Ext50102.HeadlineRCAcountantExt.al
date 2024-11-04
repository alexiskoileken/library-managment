/// <summary>
/// PageExtension Headline RC AcountantExt (ID 50102) extends Record Headline RC Accountant.
/// </summary>
pageextension 50102 "Headline RC AcountantExt" extends "Headline RC Accountant"
{
    layout
    {
        modify(Control1)
        {
            Visible = false;
        }
        addafter(Control1)
        {
            field(Message; Message)
            {
                ApplicationArea = basic, suite;
                trigger OnDrillDown()
                var
                    OnDrillDown: label 'https://www.instagram.com/alexis_devr/?next=%2F&hl=en', Locked = true;
                begin
                    Hyperlink(OnDrillDown);
                end;
            }
        }
    }
    var
        Message: label '<qualifier>Greetings</qualifier><payload>Hello <emphasize>Alex</emphasize></payload>';
}

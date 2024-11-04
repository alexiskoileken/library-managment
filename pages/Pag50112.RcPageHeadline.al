/// <summary>
/// Page Rc Page Headline (ID 50112).
/// </summary>
page 50112 "Rc Page Headline"
{
    ApplicationArea = All;
    Caption = 'Rc Page Headline';
    PageType = HeadlinePart;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(control1)
            {
                Visible = IsGreetingTextVisible;
                ShowCaption = false;
                field(GreetingsText; RCheadline.GetGreetingText())
                {
                    ApplicationArea = basic, suite;
                    Editable = false;
                }
                field(LoggedOnUsers; StrSubstNo(LoggedOnUsers, GetNoOfActiveUser()))
                {
                    ApplicationArea = basic, suite;
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                    begin
                        Page.Run(Page::"Concurrent Session List");
                    end;
                }
            }
            field(Headline2; Message1)
            {
                trigger OnDrillDown()
                var
                    Ondrilldown: Label 'https://go.microsoft.com/fwlink/?linkid=867580', locked = true;
                begin
                    Hyperlink(Ondrilldown);
                end;
            }

        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        RCheadline.HeadlineOnOpenPage(Page::"Rc Page Headline");
        IsGreetingTextVisible := RCheadline.IsUserGreetingVisible();
    end;

    local procedure GetNoOfActiveUser(): Integer
    var
        ActiveSession: Record "Active Session";
    begin
        ActiveSession.Reset();
        ActiveSession.SetRange("Client Type", ActiveSession."Client Type"::"Web Client");
        exit(ActiveSession.Count());
    end;

    var
        RCheadline: Codeunit "RC Headlines Page Common";
        [InDataSet]
        IsGreetingTextVisible: Boolean;
        SiteLbl: Label '<qualifier>The site</qualifier> <payload>visit my page<emphasize>MDBC</emphasize></payload>';
        LoggedOnUsers: label '<qualifier>Users</qualifier><payload>The number of logged on users<emphasize> %1 </emphasize></payload>';
        Message1: label '<qualifier>Insight from last month</qualifier><payload>This is biggest sale <emphasize> this month</emphasize></payload>';

}

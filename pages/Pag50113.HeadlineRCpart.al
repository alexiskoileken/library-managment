page 50113 "Headline RC part"
{
    ApplicationArea = All;
    Caption = 'Headline RC part';
    PageType = HeadlinePart;

    layout
    {
        area(Content)
        {
            group("&greetings")
            {
                ShowCaption = false;
                Visible = IsGreeting;
                field(greetings; RCHeadline.GetGreetingText())
                {
                    ApplicationArea = basic, suite;
                    Editable = false;
                }
                field(loggeOnUsers; StrSubstNo(NoOfLoggedUsers, GetNoOfUsers()))
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
        }
    }
    trigger OnOpenPage()
    var

    begin
        RCHeadline.HeadlineOnOpenPage(Page::"Headline RC part");
        IsGreeting := RCHeadline.IsUserGreetingVisible();
    end;

    local procedure GetNoOfUsers(): Integer
    var
        ActiveSession: Record "Active Session";
    begin
        ActiveSession.Reset();
        ActiveSession.SetRange("Client Type", ActiveSession."Client Type"::"Web Client");
        exit(ActiveSession.Count());
    end;

    var
        RCHeadline: Codeunit "RC Headlines Page Common";
        [InDataSet]
        IsGreeting: Boolean;
        NoOfLoggedUsers: Label '<qualifier>No of Users</qualifier><payload>The number of Users<emphasize> %1</emphasize></payload>';

}

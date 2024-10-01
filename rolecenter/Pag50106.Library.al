/// <summary>
/// Page Library (ID 50106).
/// </summary>
page 50106 Library
{
    ApplicationArea = All;
    Caption = 'Library';
    PageType = RoleCenter;
    layout
    {
        area(RoleCenter)
        {
            part(Headline; "Rc Page Headline")
            {
                ApplicationArea = basic, suite;
            }
            part(Control99; "Finance Performance")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control1902304208; "Accountant Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = Suite;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control123; "Team Member Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control1907692008; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control103; "Trailing Sales Orders Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control106; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control9; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control100; "Cash Flow Forecast Chart")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control108; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
            }
            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control122; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
                ObsoleteState = Pending;
                ObsoleteReason = 'Replaced by PowerBIEmbeddedReportPart';
                Visible = false;
                ObsoleteTag = '21.0';
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }


        }
    }

    actions
    {
        area(Sections)
        {
            group("&Books")
            {
                action(Book)
                {
                    ApplicationArea = All;
                    RunObject = page Books;
                    ToolTip = 'Specifies books in Library';
                }
                action(Authors)
                {
                    ApplicationArea = all;
                    RunObject = page Author;
                    ToolTip = 'Specifies book Authors ';
                }
            }
            group(Patron)
            {
                action(parton)
                {
                    RunObject = page Patrons;
                }
            }
            group("&Book Lending")
            {
                Caption = 'Book lending';
                action(Booklending)
                {
                    RunObject = page "Book lendings";
                }
            }
        }
        area(Creation)
        {
            action("&Book")
            {
                Caption = 'book';
                RunObject = page Books;
            }
            action("&Author")
            {
                Caption = 'Author';
                RunObject = page Author;
            }
            action("&patron")
            {
                Caption = 'patron';
                RunObject = page Patrons;

            }
            action("&Booklending")
            {
                RunObject = page "Book lendings";
                Caption = 'Book lendings';
            }
            action(employee)
            {
                RunObject = page "Employee List";
                Caption = 'employee';
            }

        }
        area(Embedding)
        {
            action(Setup)
            {
                ApplicationArea = All;
                RunObject = page Setup;
                ToolTip = 'Specifies the system setups and settings';
            }
        }
        area(Reporting)
        {
            action(BooksReports)
            {
                Caption = 'Books reports';
                ApplicationArea = all;
                RunObject = report "Books report";
            }
        }

    }
}


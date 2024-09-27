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


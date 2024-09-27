/// <summary>
/// Report Books report (ID 50100).
/// </summary>
report 50100 "Books report"
{
    ApplicationArea = All;
    Caption = 'Books report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Books.rdl';
    dataset
    {
        dataitem(Book; Book)
        {
            RequestFilterFields = "Book Id", Status;
            column(logo; companyinf.Picture)
            {
            }
            column(email; Companyinf."E-Mail")
            {
            }
            column(phoneNumber; Companyinf."Phone No.")
            {
            }
            column(Adrress; Companyinf.Address)
            {
            }
            column(Location; Companyinf."Location Code")
            {
            }
            column(CompanyName; Companyinf.Name)
            {
            }
            column(BookId; "Book Id")
            {
            }
            column(Title; "Title ")
            {
            }
            column(ISBN; ISBN)
            {
            }
            column(Status; Status)
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        Companyinf.Get();
        Companyinf.CalcFields(Picture);
    end;

    var
        Companyinf: Record "Company Information";
}

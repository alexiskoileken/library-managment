/// <summary>
/// Table Patron Factbox (ID 50109).
/// </summary>
table 50109 "Patron Factbox"
{
    Caption = 'Patron Factbox';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "patron id"; Code[20])
        {
            Caption = 'patron id';

        }
        field(2; "Number of books"; Integer)
        {
            Caption = 'Number of books';
        }
        field(3; "Returned Number of books"; Integer)
        {
            Caption = 'Returned Number of books';
        }
        field(4; Penalty; Decimal)
        {
            Caption = 'Penalty';
        }
    }
    keys
    {
        key(PK; "patron id")
        {
            Clustered = true;
        }
    }

}

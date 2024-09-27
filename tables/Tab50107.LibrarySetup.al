/// <summary>
/// Table Library Setup (ID 50107).
/// </summary>
table 50107 "Library Setup"
{
    Caption = 'Library Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Setup No."; Integer)
        {
            Caption = 'Setup No.';
        }
        field(2; "Patron ID"; Code[50])
        {
            Caption = 'Patron No';
            TableRelation = "No. Series";
        }
        field(3; BookLending; Code[50])
        {
            Caption = 'Book Lending';
            TableRelation = "No. Series";
        }
        field(4; BooksId; Code[20])
        {
            Caption = 'books id';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Setup No.")
        {
            Clustered = true;
        }
    }


}

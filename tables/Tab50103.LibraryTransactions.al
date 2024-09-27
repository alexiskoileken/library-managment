/// <summary>
/// Table Library Transactions  (ID 50103).
/// </summary>
table 50103 "Library Transactions "
{
    Caption = 'Library Transactions ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Transaction ID"; Code[20])
        {
            Caption = 'Transaction ID';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Patron ID"; Code[20])
        {
            Caption = 'Patron ID';
        }
        field(4; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(5; "Transaction Date"; DateTime)
        {
            Caption = 'Transaction Date';
        }
        field(6; "Transaction Type "; Option)
        {
            Caption = 'Transaction Type ';
            OptionMembers = Return,Borrow,Fine;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Transaction ID")
        {
            Clustered = true;
        }
    }
}

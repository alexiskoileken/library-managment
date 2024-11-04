/// <summary>
/// Table Books Lending cues (ID 50108).
/// </summary>
table 50108 "Books Lending cues"
{
    Caption = 'Books Lending cues';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "primary key"; Integer)
        {
            Caption = 'primary key';
            Editable = false;
            AutoIncrement = true;
        }
        field(2; "Total books"; Integer)
        {
            Caption = 'Total books';
            FieldClass = FlowField;
            CalcFormula = count(Book);
        }
        field(5; "available books"; Integer)
        {
            Caption = 'Available books';
            FieldClass = FlowField;
            CalcFormula = count(Book where(Status = const(Available)));
        }
        field(3; patron; Integer)
        {
            Caption = 'patron';
            FieldClass = FlowField;
            CalcFormula = count(Patron);
        }
        field(4; booklending; Integer)
        {
            Caption = 'Approved Transactions';
            FieldClass = FlowField;
            CalcFormula = count("Book Lending" where(Status = const(Approved)));
        }

    }
    keys
    {
        key(PK; "primary key")
        {
            Clustered = true;
        }
    }
}

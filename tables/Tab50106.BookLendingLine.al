/// <summary>
/// Table Book Lending Line (ID 50106).
/// </summary>
table 50106 "Book Lending Line"
{
    Caption = 'Book Lending Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Book No."; Code[20])
        {
            Caption = 'Book No.';
            TableRelation = Book where(Status = const(Available));
            trigger OnValidate()
            var
                Books: Record Book;
                UpdateTime: Record "Book Lending";
            begin
                Books.Reset();
                if Books.Get("Book No.") then begin
                    Title := Books."Title ";
                    ISNB := Books.ISBN;
                    Books.Modify()
                end;
            end;
        }
        field(2; Title; text[50])
        {
            Caption = 'Title';
            Editable = false;
        }
        field(3; ISNB; text[50])
        {
            Caption = 'ISNB';
            Editable = false;
        }
        field(4; "Lending ID"; code[20])
        {
            Caption = 'Lending ID';
            Editable = false;
        }
        field(5; Status; option)
        {
            OptionMembers = Available,Booked,Approved,"Out of Order";
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Book No.", "Lending ID")
        {
            Clustered = true;
        }
    }
}

/// <summary>
/// Table Author (ID 50102).
/// </summary>
table 50102 Author
{
    Caption = 'Author';
    DataClassification = ToBeClassified;
    LookupPageId = Author;

    fields
    {
        field(1; "Author ID"; Code[20])
        {
            Caption = 'Author ID';
        }
        field(2; "First Name "; Text[50])
        {
            Caption = 'First Name ';
        }
        field(3; "Second Name"; Text[50])
        {
            Caption = 'Second Name';
        }
        field(4; "Email "; Text[50])
        {
            Caption = 'Email ';
        }
        field(5; "Phone Number"; Text[50])
        {
            Caption = 'Phone Number';
        }
    }
    keys
    {
        key(PK; "Author ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Author ID", "First Name ", "Second Name", "Email ")
        {

        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin

    end;
}

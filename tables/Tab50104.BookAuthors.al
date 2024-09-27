/// <summary>
/// Table Book Authors   (ID 50104).
/// </summary>
table 50104 "Book Authors  "
{
    Caption = 'Book Authors  ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Author ID"; Code[20])
        {
            Caption = 'Author ID';
            TableRelation = Author;
            trigger OnValidate()
            var
                Authors: Record Author;
            begin
                Authors.Reset();
                if Authors.Get("Author ID") then begin
                    "First Name " := Authors."First Name ";
                    "Second Name" := Authors."Second Name";
                    "Email " := Authors."Email ";
                    "Phone Number" := Authors."Phone Number";
                end;

            end;

        }
        field(2; "First Name "; Text[50])
        {
            Caption = 'First Name ';
            Editable = false;

        }
        field(3; "Second Name"; Text[50])
        {
            Caption = 'Second Name';
            Editable = false;
        }
        field(4; "Email "; Text[50])
        {
            Caption = 'Email ';
            Editable = false;
        }
        field(5; "Phone Number"; Text[50])
        {
            Caption = 'Phone Number';
            Editable = false;
        }
        field(6; "Book No."; Code[20])
        {
            Caption = 'Book Id';
            Editable = false;

        }
    }
    keys
    {
        key(PK; "Author id", "Book No.")
        {
            Clustered = true;
        }
    }

}

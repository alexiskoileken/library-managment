/// <summary>
/// Table Patron (ID 50101).
/// </summary>
table 50101 Patron
{
    Caption = 'Patron';
    DataClassification = ToBeClassified;
    LookupPageId = Patron;

    fields
    {
        field(1; "Patron ID"; Code[20])
        {
            Caption = 'Patron ID';
            Editable = false;

        }
        field(2; "First Name"; Text[50])
        {
            Caption = 'First Name';
        }
        field(3; "Second Name"; Text[50])
        {
            Caption = 'Second Name';
        }
        field(4; "Phone No"; Code[20])
        {
            Caption = 'Phone No';
        }
        field(5; Email; Text[50])
        {
            Caption = 'Email';
        }
        field(6; "Date Of Birth"; Date)
        {
            Caption = 'Date Of Birth';
        }
        field(7; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(8; "modified date-time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            OptionMembers = NoBook,Hasbook;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Patron ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Patron ID", "First Name", "Second Name", Email)
        {

        }
    }
    trigger OnModify()
    var
    begin
        "Modified By" := UserId;
        "modified date-time" := CurrentDateTime;
    end;

    trigger OnInsert()
    var
        LibrarySetup: Record "Library Setup";
        NoseriesMgt: Codeunit NoSeriesManagement;
    begin
        LibrarySetup.Get();
        NoseriesMgt.InitSeries(LibrarySetup."Patron ID", LibrarySetup."Patron ID", WorkDate(), "Patron ID", LibrarySetup."Patron ID");

    end;
}

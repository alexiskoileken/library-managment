/// <summary>
/// Table Book (ID 50100).
/// </summary>
table 50100 Book
{
    Caption = 'Book';
    DataClassification = ToBeClassified;
    LookupPageId = Books;

    fields
    {
        field(1; "Book Id"; Code[20])
        {
            Caption = 'Book Id';
            Editable = false;
        }
        field(2; "Title "; Text[50])
        {
            Caption = 'Title ';
        }
        field(3; ISBN; Code[20])
        {
            Caption = 'ISBN';
        }
        field(4; Genre; Code[20])
        {
            Caption = 'Genre';
        }
        field(5; Status; Option)
        {
            OptionMembers = Available,Booked;
            Editable = false;
        }
        field(6; "Created At"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Book Id")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Book Id", "Title ", Genre)
        {

        }
    }
    trigger OnInsert()
    var
        Librarysetup: Record "Library Setup";
        NoMgt: Codeunit NoSeriesManagement;
    begin
        "Created At" := WorkDate();
        "Created By" := UserId;
        Librarysetup.Get();
        if "Book Id" = '' then begin
            NoMgt.InitSeries(Librarysetup.BooksId, Librarysetup.BooksId, WorkDate(), "Book Id", Librarysetup.BooksId);
        end;
    end;
}

/// <summary>
/// Table Book Lending (ID 50105).
/// </summary>
table 50105 "Book Lending"
{
    Caption = 'Book Lending';
    DataClassification = ToBeClassified;
    LookupPageId = "Book lendings";

    fields
    {
        field(1; "Lending No."; Code[20])
        {
            Caption = 'Lending No.';
            Editable = false;

        }
        field(2; Desctription; Text[100])
        {
            Caption = 'Desctription';
        }
        field(3; "Patron ID"; Code[20])
        {
            Caption = 'Patron ID';
            TableRelation = Patron where(Status = const(NoBook));
            NotBlank = true;
            trigger OnValidate()


            begin
                if Lending.Get("Patron ID") then begin
                    "Patron Name" := Lending."First Name" + '  ' + Lending."Second Name";
                    "Patron Email" := Lending.Email;
                    "Patron Phone No." := Lending."Phone No";
                end;
            end;
        }
        field(4; "Patron Name"; Text[100])
        {
            Caption = 'Patron Name';
            Editable = false;
        }
        field(5; "Patron Email"; Text[50])
        {
            Caption = 'Patron Email';
            Editable = false;
        }
        field(6; "Patron Phone No."; Text[50])
        {
            Caption = 'Patron Phone No.';
            Editable = false;
        }
        field(7; Status; enum "Book Lending Approval")
        {
            Caption = 'Status ';
            Editable = false;

        }
        field(8; "Lending Date-Time"; DateTime)
        {
            Caption = 'Lending Date-time';
            Editable = false;

        }
        field(9; "Issued By"; Code[50])
        {
            Caption = 'Lended by ';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Lending No.", "Patron ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        LibrarySetup: Record "Library Setup";
        NoseriesMgt: Codeunit NoSeriesManagement;
    begin
        "Lending Date-Time" := CurrentDateTime;
        "Issued By" := UserId;
        LibrarySetup.Get();
        if "Lending No." = '' then begin
            NoseriesMgt.InitSeries(LibrarySetup.BookLending, LibrarySetup.BookLending, WorkDate(), "Lending No.", LibrarySetup.BookLending);
        end;
    end;

    var
        BookLendingStatus: Record "Book Lending";
        Lending: Record Patron;
}

/// <summary>
/// Codeunit Custom Management (ID 50101).
/// </summary>
codeunit 50101 "Custom Management"
{
    /// <summary>
    /// PatronHasBook.
    /// </summary>
    procedure PatronHasBook()
    var
        Patron: Record Patron;
        BookLendingLn: Record "Book Lending Line";
        BookLending: Record "Book Lending";
    begin
        if BookLending.FindSet() then begin
            repeat
                BookLendingLn.SetRange("Lending ID", BookLending."Lending No.");
                BookLending.SetRange(Status, BookLending.Status::Approved);
                if BookLendingLn.FindFirst() then begin
                    if Patron.Get(BookLending."Patron ID") then begin
                        Patron.Status := Patron.Status::Hasbook;
                        Patron.Modify(true)
                    end;
                end;
            until BookLending.Next() = 0
        end;
    end;

    /// <summary>
    /// ImportItemPicture.
    /// </summary>
    /// <param name="Patron">Record Patron.</param>
    procedure ImportItemPicture(Patron: Record Patron)
    var
        PicInstream: InStream;
        FromFileName: Text;
        OvverideImageMsg: Label 'The Existing Picture will be replaced.Continue?';
    begin
        if Patron.Picture.HasValue then begin
            if not Confirm(OvverideImageMsg) then
                exit;
        end;
        if File.UploadIntoStream('Import', '', 'All files(*.*)|*.*', FromFileName, PicInstream) then begin
            Patron.Picture.ImportStream(PicInstream, FromFileName);
            Patron.Modify(true)
        end;
    end;

}

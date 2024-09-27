/// <summary>
/// Page Book (ID 50100).
/// </summary>
page 50100 Books
{
    ApplicationArea = All;
    Caption = 'Book';
    PageType = List;
    SourceTable = Book;
    UsageCategory = Lists;
    CardPageId = Book;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Book Id"; Rec."Book Id")
                {
                    ToolTip = 'Specifies the value of the Book Id field.', Comment = '%';
                }
                field("Title "; Rec."Title ")
                {
                    ToolTip = 'Specifies the value of the Title field.', Comment = '%';
                }
                field(ISBN; Rec.ISBN)
                {
                    ToolTip = 'Specifies the value of the ISBN field.', Comment = '%';
                }
                field(Genre; Rec.Genre)
                {
                    ToolTip = 'Specifies the value of the Genre field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}

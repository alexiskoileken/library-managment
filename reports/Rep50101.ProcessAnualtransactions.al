/// <summary>
/// Report Process Anual transactions (ID 50101).
/// </summary>
report 50101 "Process Anual transactions"
{
    ApplicationArea = All;
    Caption = 'Process Anual transactions';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Customer filtering';
            column(No_; "No.")
            {

            }

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Option)
                {
                    field(ExpenseGLAcc; ExpenseGLAcc)
                    {
                        Caption = 'Expense G/L Account';
                        ApplicationArea = Basic, Suite;
                        TableRelation = "G/L Account" where("Direct Posting" = const(true));
                    }
                    field(FessIncomeGlacc; FessIncomeGlacc)
                    {
                        Caption = 'Fees income  G/L Account';
                        ApplicationArea = Basic, Suite;
                        TableRelation = "G/L Account" where("Direct Posting" = const(true));
                    }
                    field(TaxGLAcc; TaxGLAcc)
                    {
                        Caption = 'Tax G/L Account';
                        ApplicationArea = Basic, Suite;
                        TableRelation = "G/L Account" where("Direct Posting" = const(true));
                    }
                    field(PaymentGLAcc; PaymentGLAcc)
                    {
                        Caption = 'Payment G/L Account';
                        ApplicationArea = Basic, Suite;
                        TableRelation = "G/L Account" where("Direct Posting" = const(true));
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        ExpenseGLAcc: Code[20];
        FessIncomeGlacc: code[20];
        TaxGLAcc: code[20];
        PaymentGLAcc: Code[20];

}

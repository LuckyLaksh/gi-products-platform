// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description Concrete implementation of AbstractLibraryService
 * Demonstrates how to extend an abstract class and implement abstract methods
 * 
 * This class provides book loan service functionality
 * Demonstrates: Abstract Class Implementation, Template Method Pattern
 */
public class BookLoanService extends AbstractLibraryService {
    
    // ========== ADDITIONAL FIELDS ==========
    
    private LoanableBook book;
    private String borrowerId;
    private Date loanDate;
    private String result;
    
    // ========== CONSTRUCTOR ==========
    
    public BookLoanService(LoanableBook book, String borrowerId, Date loanDate) {
        super('Book Loan Service'); // Call parent constructor
        this.book = book;
        this.borrowerId = borrowerId;
        this.loanDate = loanDate;
    }
    
    // ========== IMPLEMENT ABSTRACT METHODS ==========
    // Must implement all abstract methods from parent class
    
    /**
     * @description Implement abstract validate() method
     * @return Boolean indicating validation success
     */
    public override Boolean validate() {
        if (this.book == null) {
            this.result = 'Error: Book is null';
            return false;
        }
        
        if (String.isBlank(this.borrowerId)) {
            this.result = 'Error: Borrower ID is required';
            return false;
        }
        
        if (this.book.isOnLoan()) {
            this.result = 'Error: Book is already on loan';
            return false;
        }
        
        if (!this.book.getIsAvailable()) {
            this.result = 'Error: Book is not available';
            return false;
        }
        
        return true;
    }
    
    /**
     * @description Implement abstract execute() method
     */
    public override void execute() {
        Boolean success = this.book.loan(this.borrowerId, this.loanDate);
        if (success) {
            this.result = 'Book loaned successfully to ' + this.borrowerId;
        } else {
            this.result = 'Failed to loan book';
        }
    }
    
    /**
     * @description Implement abstract getServiceResult() method
     * @return Service result as string
     */
    public override String getServiceResult() {
        return this.result;
    }
    
    // ========== ADDITIONAL METHODS ==========
    
    /**
     * @description Get the book being loaned
     * @return LoanableBook instance
     */
    public LoanableBook getBook() {
        return this.book;
    }
}
// AI Generated Code by Deloitte + Cursor (END)


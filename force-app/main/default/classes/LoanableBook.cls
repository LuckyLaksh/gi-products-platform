// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description Demonstrates INTERFACE IMPLEMENTATION and MULTIPLE INHERITANCE
 * This class extends Book AND implements ILoanable and IPrintable interfaces
 * 
 * Key concepts:
 * - A class can extend ONE parent class (single inheritance)
 * - A class can implement MULTIPLE interfaces (multiple inheritance via interfaces)
 * - Must provide implementation for all interface methods
 * 
 * Demonstrates: Interface Implementation, Multiple Inheritance, Polymorphism
 */
public class LoanableBook extends Book implements ILoanable, IPrintable {
    
    // ========== ADDITIONAL FIELDS FOR LOAN FUNCTIONALITY ==========
    
    private String currentBorrowerId;
    private Date loanStartDate;
    private Date loanEndDate;
    private Integer loanPeriodDays; // Default loan period
    private Boolean onLoan;
    
    // ========== CONSTRUCTORS ==========
    
    public LoanableBook() {
        super();
        this.onLoan = false;
        this.loanPeriodDays = 14; // Default 2 weeks
    }
    
    public LoanableBook(String title, String author, Integer publicationYear, 
                       Integer numberOfPages, String isbn) {
        super(title, author, publicationYear, numberOfPages, isbn);
        this.onLoan = false;
        this.loanPeriodDays = 14;
    }
    
    // ========== GETTERS AND SETTERS ==========
    
    public Integer getLoanPeriodDays() {
        return this.loanPeriodDays;
    }
    
    public void setLoanPeriodDays(Integer loanPeriodDays) {
        if (loanPeriodDays != null && loanPeriodDays > 0) {
            this.loanPeriodDays = loanPeriodDays;
        }
    }
    
    // ========== INTERFACE IMPLEMENTATION: ILoanable ==========
    // Must implement ALL methods from ILoanable interface
    
    /**
     * @description Implement loan method from ILoanable interface
     * @param borrowerId ID of the borrower
     * @param loanDate Date of loan
     * @return Boolean indicating success
     */
    public Boolean loan(String borrowerId, Date loanDate) {
        if (String.isBlank(borrowerId)) {
            throw new IllegalArgumentException('Borrower ID cannot be blank');
        }
        
        if (this.onLoan) {
            System.debug('Book is already on loan to: ' + this.currentBorrowerId);
            return false;
        }
        
        if (!this.getIsAvailable()) {
            System.debug('Book is not available for loan');
            return false;
        }
        
        this.currentBorrowerId = borrowerId;
        this.loanStartDate = loanDate != null ? loanDate : Date.today();
        this.loanEndDate = this.loanStartDate.addDays(this.loanPeriodDays);
        this.onLoan = true;
        this.setIsAvailable(false);
        
        System.debug('Book loaned successfully to: ' + borrowerId);
        return true;
    }
    
    /**
     * @description Implement returnLoan method from ILoanable interface
     * @param returnDate Date of return
     * @return Boolean indicating success
     */
    public Boolean returnLoan(Date returnDate) {
        if (!this.onLoan) {
            System.debug('Book is not currently on loan');
            return false;
        }
        
        Date actualReturnDate = returnDate != null ? returnDate : Date.today();
        this.onLoan = false;
        this.setIsAvailable(true);
        this.currentBorrowerId = null;
        this.loanStartDate = null;
        this.loanEndDate = null;
        
        System.debug('Book returned successfully on: ' + actualReturnDate);
        return true;
    }
    
    /**
     * @description Implement isOnLoan method from ILoanable interface
     * @return Boolean indicating loan status
     */
    public Boolean isOnLoan() {
        return this.onLoan;
    }
    
    /**
     * @description Implement getCurrentBorrower method from ILoanable interface
     * @return Borrower ID or null
     */
    public String getCurrentBorrower() {
        return this.currentBorrowerId;
    }
    
    /**
     * @description Implement getLoanStartDate method from ILoanable interface
     * @return Loan start date or null
     */
    public Date getLoanStartDate() {
        return this.loanStartDate;
    }
    
    /**
     * @description Implement calculateFine method from ILoanable interface
     * @param dailyFineRate Daily fine rate
     * @return Calculated fine amount
     */
    public Decimal calculateFine(Decimal dailyFineRate) {
        if (!this.onLoan || this.loanEndDate == null) {
            return 0;
        }
        
        Date today = Date.today();
        if (today <= this.loanEndDate) {
            return 0; // Not overdue
        }
        
        Integer daysOverdue = this.loanEndDate.daysBetween(today);
        if (dailyFineRate == null || dailyFineRate < 0) {
            dailyFineRate = 0.50; // Default fine rate
        }
        
        return daysOverdue * dailyFineRate;
    }
    
    // ========== INTERFACE IMPLEMENTATION: IPrintable ==========
    // Must implement ALL methods from IPrintable interface
    
    /**
     * @description Implement toPrintFormat method from IPrintable interface
     * @return Formatted string for printing
     */
    public String toPrintFormat() {
        String info = '=== BOOK INFORMATION ===\n';
        info += 'Title: ' + this.getTitle() + '\n';
        info += 'Author: ' + this.getAuthor() + '\n';
        info += 'ISBN: ' + this.getIsbn() + '\n';
        info += 'Pages: ' + this.getNumberOfPages() + '\n';
        info += 'Status: ' + (this.onLoan ? 'On Loan' : 'Available') + '\n';
        if (this.onLoan) {
            info += 'Borrower: ' + this.currentBorrowerId + '\n';
            info += 'Due Date: ' + this.loanEndDate + '\n';
        }
        return info;
    }
    
    /**
     * @description Implement getPrintMetadata method from IPrintable interface
     * @return Map containing print metadata
     */
    public Map<String, Object> getPrintMetadata() {
        Map<String, Object> metadata = new Map<String, Object>();
        metadata.put('type', 'Book');
        metadata.put('title', this.getTitle());
        metadata.put('author', this.getAuthor());
        metadata.put('isbn', this.getIsbn());
        metadata.put('onLoan', this.onLoan);
        metadata.put('printDate', DateTime.now());
        return metadata;
    }
    
    // ========== ADDITIONAL METHODS ==========
    
    /**
     * @description Check if book is overdue
     * @return Boolean indicating if overdue
     */
    public Boolean isOverdue() {
        if (!this.onLoan || this.loanEndDate == null) {
            return false;
        }
        return Date.today() > this.loanEndDate;
    }
    
    /**
     * @description Get days until due date (negative if overdue)
     * @return Number of days
     */
    public Integer getDaysUntilDue() {
        if (!this.onLoan || this.loanEndDate == null) {
            return null;
        }
        return Date.today().daysBetween(this.loanEndDate);
    }
    
    /**
     * @description Override toString to include loan information
     * @return String representation
     */
    public override String toString() {
        String baseInfo = super.getItemInfo();
        if (this.onLoan) {
            baseInfo += ', On Loan: Yes, Borrower: ' + this.currentBorrowerId + 
                       ', Due Date: ' + this.loanEndDate;
        } else {
            baseInfo += ', On Loan: No';
        }
        return baseInfo;
    }
}
// AI Generated Code by Deloitte + Cursor (END)


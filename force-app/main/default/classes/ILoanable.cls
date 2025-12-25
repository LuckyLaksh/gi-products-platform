// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description INTERFACE - Demonstrates ABSTRACTION and POLYMORPHISM
 * Interface: Defines a contract that implementing classes must follow
 * All methods in an interface are implicitly public and abstract
 * 
 * This interface defines what it means to be "loanable" in our library system
 * Any class implementing this interface must provide implementations for all methods
 * 
 * Demonstrates: Abstraction, Interface, Contract-based programming
 */
public interface ILoanable {
    
    // ========== INTERFACE METHODS: Contract Definition ==========
    // All methods in interface are implicitly public and abstract
    // No method body - only signature
    
    /**
     * @description Method to loan the item
     * @param borrowerId ID of the borrower
     * @param loanDate Date of loan
     * @return Boolean indicating success
     */
    Boolean loan(String borrowerId, Date loanDate);
    
    /**
     * @description Method to return the loaned item
     * @param returnDate Date of return
     * @return Boolean indicating success
     */
    Boolean returnLoan(Date returnDate);
    
    /**
     * @description Check if item is currently on loan
     * @return Boolean indicating loan status
     */
    Boolean isOnLoan();
    
    /**
     * @description Get the current borrower ID
     * @return Borrower ID or null if not on loan
     */
    String getCurrentBorrower();
    
    /**
     * @description Get the loan start date
     * @return Loan start date or null if not on loan
     */
    Date getLoanStartDate();
    
    /**
     * @description Calculate fine if item is overdue
     * @param dailyFineRate Daily fine rate
     * @return Calculated fine amount
     */
    Decimal calculateFine(Decimal dailyFineRate);
}
// AI Generated Code by Deloitte + Cursor (END)


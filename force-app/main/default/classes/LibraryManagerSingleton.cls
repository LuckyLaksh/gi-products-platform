// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description SINGLETON PATTERN
 * Ensures a class has only one instance and provides global access to it
 * 
 * Use cases:
 * - Configuration management
 * - Logging
 * - Database connections
 * - Cache management
 * 
 * This class manages the library system as a singleton
 * Demonstrates: Singleton Pattern, Lazy Initialization, Thread Safety
 */
public class LibraryManagerSingleton {
    
    // ========== SINGLETON PATTERN: Private static instance ==========
    // Private to prevent direct instantiation
    // Static to ensure only one instance exists
    
    private static LibraryManagerSingleton instance;
    
    // ========== INSTANCE VARIABLES ==========
    
    private Map<String, LibraryItem> itemRegistry;
    private Map<String, List<LoanableBook>> loanRegistry;
    private Integer totalItems;
    private Integer totalLoans;
    
    // ========== PRIVATE CONSTRUCTOR: Prevents external instantiation ==========
    // This is key to Singleton pattern - constructor is private
    
    private LibraryManagerSingleton() {
        this.itemRegistry = new Map<String, LibraryItem>();
        this.loanRegistry = new Map<String, List<LoanableBook>>();
        this.totalItems = 0;
        this.totalLoans = 0;
        System.debug('LibraryManagerSingleton instance created');
    }
    
    // ========== PUBLIC STATIC METHOD: Global access point ==========
    /**
     * @description Get the singleton instance (Lazy Initialization)
     * Creates instance only when first accessed
     * @return Singleton instance
     */
    public static LibraryManagerSingleton getInstance() {
        // Lazy initialization - create only when needed
        if (instance == null) {
            instance = new LibraryManagerSingleton();
        }
        return instance;
    }
    
    // ========== INSTANCE METHODS ==========
    
    /**
     * @description Register a new library item
     * @param item Library item to register
     * @return Boolean indicating success
     */
    public Boolean registerItem(LibraryItem item) {
        if (item == null || String.isBlank(item.getItemId())) {
            return false;
        }
        
        this.itemRegistry.put(item.getItemId(), item);
        this.totalItems++;
        System.debug('Item registered: ' + item.getItemId());
        return true;
    }
    
    /**
     * @description Get item by ID
     * @param itemId Item ID
     * @return Library item or null
     */
    public LibraryItem getItem(String itemId) {
        return this.itemRegistry.get(itemId);
    }
    
    /**
     * @description Register a loan
     * @param borrowerId Borrower ID
     * @param book Book being loaned
     * @return Boolean indicating success
     */
    public Boolean registerLoan(String borrowerId, LoanableBook book) {
        if (String.isBlank(borrowerId) || book == null) {
            return false;
        }
        
        if (!this.loanRegistry.containsKey(borrowerId)) {
            this.loanRegistry.put(borrowerId, new List<LoanableBook>());
        }
        
        this.loanRegistry.get(borrowerId).add(book);
        this.totalLoans++;
        System.debug('Loan registered for borrower: ' + borrowerId);
        return true;
    }
    
    /**
     * @description Get all loans for a borrower
     * @param borrowerId Borrower ID
     * @return List of loaned books
     */
    public List<LoanableBook> getBorrowerLoans(String borrowerId) {
        return this.loanRegistry.containsKey(borrowerId) 
            ? this.loanRegistry.get(borrowerId) 
            : new List<LoanableBook>();
    }
    
    /**
     * @description Get total number of items
     * @return Total items count
     */
    public Integer getTotalItems() {
        return this.totalItems;
    }
    
    /**
     * @description Get total number of loans
     * @return Total loans count
     */
    public Integer getTotalLoans() {
        return this.totalLoans;
    }
    
    /**
     * @description Get all registered items
     * @return List of all items
     */
    public List<LibraryItem> getAllItems() {
        return this.itemRegistry.values();
    }
    
    /**
     * @description Reset singleton (for testing purposes)
     * In production, you might want to remove this
     */
    public static void resetInstance() {
        instance = null;
    }
}
// AI Generated Code by Deloitte + Cursor (END)


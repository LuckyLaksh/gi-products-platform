// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description Demonstrates POLYMORPHISM - one of the four pillars of OOP
 * Polymorphism: "Many forms" - same interface, different implementations
 * 
 * Two types of polymorphism in Apex:
 * 1. Compile-time polymorphism (Method Overloading) - same method name, different parameters
 * 2. Runtime polymorphism (Method Overriding) - same method signature, different implementations in inheritance hierarchy
 * 
 * This class demonstrates METHOD OVERLOADING
 * Demonstrates: Polymorphism, Method Overloading, Static Polymorphism
 */
public class PolymorphismExample {
    
    // ========== METHOD OVERLOADING: Compile-time Polymorphism ==========
    // Multiple methods with the same name but different parameters
    // The compiler determines which method to call based on arguments
    
    /**
     * @description Method 1: Search by title only
     * @param title Book title
     * @return List of matching books
     */
    public List<Book> searchBooks(String title) {
        System.debug('Searching books by title: ' + title);
        // In real implementation, would query database
        List<Book> results = new List<Book>();
        // Simulated search logic
        return results;
    }
    
    /**
     * @description Method 2: Search by title and author (OVERLOADED)
     * Same method name, different parameters
     * @param title Book title
     * @param author Book author
     * @return List of matching books
     */
    public List<Book> searchBooks(String title, String author) {
        System.debug('Searching books by title: ' + title + ' and author: ' + author);
        List<Book> results = new List<Book>();
        // Simulated search logic
        return results;
    }
    
    /**
     * @description Method 3: Search by title, author, and category (OVERLOADED)
     * @param title Book title
     * @param author Book author
     * @param category Book category
     * @return List of matching books
     */
    public List<Book> searchBooks(String title, String author, String category) {
        System.debug('Searching books by title: ' + title + ', author: ' + author + ', category: ' + category);
        List<Book> results = new List<Book>();
        // Simulated search logic
        return results;
    }
    
    /**
     * @description Method 4: Search with date range (OVERLOADED - different parameter types)
     * @param title Book title
     * @param startYear Start year
     * @param endYear End year
     * @return List of matching books
     */
    public List<Book> searchBooks(String title, Integer startYear, Integer endYear) {
        System.debug('Searching books by title: ' + title + ' between years ' + startYear + ' and ' + endYear);
        List<Book> results = new List<Book>();
        // Simulated search logic
        return results;
    }
    
    /**
     * @description Method 5: Search with Map of criteria (OVERLOADED - different parameter type)
     * @param searchCriteria Map of search criteria
     * @return List of matching books
     */
    public List<Book> searchBooks(Map<String, Object> searchCriteria) {
        System.debug('Searching books with criteria: ' + searchCriteria);
        List<Book> results = new List<Book>();
        // Simulated search logic
        return results;
    }
    
    // ========== METHOD OVERLOADING WITH DIFFERENT RETURN TYPES ==========
    // Note: Return type alone cannot be used for overloading
    // Must have different parameter types or number of parameters
    
    /**
     * @description Calculate total price - Integer version
     * @param books List of books
     * @return Total price as Integer
     */
    public Integer calculateTotalPrice(List<Book> books) {
        Integer total = 0;
        for (Book book : books) {
            if (book.getPrice() != null) {
                total += book.getPrice().intValue();
            }
        }
        return total;
    }
    
    /**
     * @description Calculate total price - Decimal version (OVERLOADED)
     * @param books List of books
     * @return Total price as Decimal
     */
    public Decimal calculateTotalPriceDecimal(List<Book> books) {
        Decimal total = 0.0;
        for (Book book : books) {
            if (book.getPrice() != null) {
                total += book.getPrice();
            }
        }
        return total;
    }
    
    // ========== STATIC METHOD OVERLOADING ==========
    
    /**
     * @description Static method - process single item
     * @param item Library item
     */
    public static void processItem(LibraryItem item) {
        System.debug('Processing single item: ' + item.getTitle());
    }
    
    /**
     * @description Static method - process list of items (OVERLOADED)
     * @param items List of library items
     */
    public static void processItem(List<LibraryItem> items) {
        System.debug('Processing ' + items.size() + ' items');
        for (LibraryItem item : items) {
            processItem(item); // Recursive call to single item version
        }
    }
    
    // ========== RUNTIME POLYMORPHISM DEMONSTRATION ==========
    /**
     * @description Demonstrates runtime polymorphism
     * Same method call, different behavior based on actual object type
     * @param item Library item (can be Book, Magazine, etc.)
     */
    public static void demonstrateRuntimePolymorphism(LibraryItem item) {
        // At runtime, the actual object's overridden method is called
        // This is runtime polymorphism (method overriding)
        System.debug('Item Info: ' + item.getItemInfo());
        
        // If item is a Book, Book.getItemInfo() is called
        // If item is a Magazine, Magazine.getItemInfo() is called
        // This decision happens at runtime, not compile time
    }
}
// AI Generated Code by Deloitte + Cursor (END)


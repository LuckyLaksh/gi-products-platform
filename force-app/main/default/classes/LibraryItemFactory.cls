// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description FACTORY PATTERN
 * Creates objects without specifying the exact class of object that will be created
 * 
 * Benefits:
 * - Encapsulates object creation logic
 * - Provides flexibility to add new types
 * - Centralizes creation logic
 * - Follows Open/Closed Principle
 * 
 * This factory creates different types of library items
 * Demonstrates: Factory Pattern, Object Creation, Polymorphism
 */
public class LibraryItemFactory {
    
    // ========== FACTORY METHOD: Create objects based on type ==========
    
    /**
     * @description Factory method to create library items
     * @param itemType Type of item ('Book', 'Magazine', 'LoanableBook')
     * @param title Item title
     * @param author Item author
     * @param publicationYear Publication year
     * @return LibraryItem instance (polymorphic)
     */
    public static LibraryItem createItem(String itemType, String title, 
                                        String author, Integer publicationYear) {
        if (String.isBlank(itemType)) {
            throw new IllegalArgumentException('Item type cannot be blank');
        }
        
        // Factory pattern: Create object based on type
        if (itemType.equalsIgnoreCase('Book')) {
            return new Book(title, author, publicationYear, 0, null);
        } else if (itemType.equalsIgnoreCase('Magazine')) {
            return new Magazine(title, author, publicationYear, 0, null, Date.today());
        } else if (itemType.equalsIgnoreCase('LoanableBook')) {
            return new LoanableBook(title, author, publicationYear, 0, null);
        } else {
            throw new IllegalArgumentException('Unknown item type: ' + itemType);
        }
    }
    
    /**
     * @description Factory method with full parameters for Book
     * @param title Book title
     * @param author Book author
     * @param publicationYear Publication year
     * @param price Book price
     * @param category Book category
     * @param numberOfPages Number of pages
     * @param isbn ISBN number
     * @param publisher Publisher name
     * @param edition Edition
     * @param language Language
     * @return Book instance
     */
    public static Book createBook(String title, String author, Integer publicationYear,
                                 Decimal price, String category, Integer numberOfPages,
                                 String isbn, String publisher, String edition, String language) {
        return new Book(title, author, publicationYear, price, category,
                       numberOfPages, isbn, publisher, edition, language);
    }
    
    /**
     * @description Factory method for LoanableBook
     * @param title Book title
     * @param author Book author
     * @param publicationYear Publication year
     * @param numberOfPages Number of pages
     * @param isbn ISBN number
     * @param loanPeriodDays Loan period in days
     * @return LoanableBook instance
     */
    public static LoanableBook createLoanableBook(String title, String author, 
                                                  Integer publicationYear,
                                                  Integer numberOfPages, String isbn,
                                                  Integer loanPeriodDays) {
        LoanableBook book = new LoanableBook(title, author, publicationYear,
                                            numberOfPages, isbn);
        if (loanPeriodDays != null) {
            book.setLoanPeriodDays(loanPeriodDays);
        }
        return book;
    }
    
    /**
     * @description Factory method to create item from Map of parameters
     * Demonstrates flexible factory pattern
     * @param itemData Map containing item data
     * @return LibraryItem instance
     */
    public static LibraryItem createItemFromMap(Map<String, Object> itemData) {
        if (itemData == null || !itemData.containsKey('type')) {
            throw new IllegalArgumentException('Item data must contain type');
        }
        
        String itemType = (String) itemData.get('type');
        String title = (String) itemData.get('title');
        String author = (String) itemData.get('author');
        Integer publicationYear = (Integer) itemData.get('publicationYear');
        
        LibraryItem item = createItem(itemType, title, author, publicationYear);
        
        // Set additional properties if provided
        if (itemData.containsKey('price')) {
            item.setPrice((Decimal) itemData.get('price'));
        }
        if (itemData.containsKey('category')) {
            item.setCategory((String) itemData.get('category'));
        }
        
        return item;
    }
    
    /**
     * @description Create multiple items from list of data
     * Demonstrates batch creation
     * @param itemsData List of item data maps
     * @return List of created items
     */
    public static List<LibraryItem> createItemsFromList(List<Map<String, Object>> itemsData) {
        List<LibraryItem> items = new List<LibraryItem>();
        
        for (Map<String, Object> itemData : itemsData) {
            try {
                LibraryItem item = createItemFromMap(itemData);
                items.add(item);
            } catch (Exception e) {
                System.debug('Error creating item: ' + e.getMessage());
                // Continue with next item
            }
        }
        
        return items;
    }
}
// AI Generated Code by Deloitte + Cursor (END)


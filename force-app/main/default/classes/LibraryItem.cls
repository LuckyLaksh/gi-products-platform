/**
 * @description Base class demonstrating ENCAPSULATION - one of the four pillars of OOP
 * Encapsulation: Bundling data (fields) and methods that operate on that data within a single unit (class)
 * Private fields with public getters/setters control access to internal state
 * 
 * This class serves as the base for all library items (books, magazines, etc.)
 * Demonstrates: Encapsulation, Data Hiding, Access Modifiers
 */
public class LibraryItem {
    
    // ========== ENCAPSULATION: Private fields (Data Hiding) ==========
    // Private fields prevent direct access from outside the class
    // This protects the internal state and ensures data integrity
    
    private String itemId;
    private String title;
    private String author;
    private Integer publicationYear;
    private Boolean isAvailable;
    private Decimal price;
    private String category;
    
    // ========== STATIC VARIABLE: Class-level variable ==========
    // Shared across all instances of the class
    private static Integer totalItems = 0;
    
    // ========== CONSTRUCTOR: Object Initialization ==========
    /**
     * @description Default constructor - demonstrates constructor overloading
     */
    public LibraryItem() {
        this.itemId = generateId();
        this.isAvailable = true;
        totalItems++; // Increment class-level counter
        System.debug('LibraryItem created. Total items: ' + totalItems);
    }
    
    /**
     * @description Parameterized constructor - demonstrates constructor overloading
     * @param title The title of the item
     * @param author The author of the item
     * @param publicationYear The year of publication
     */
    public LibraryItem(String title, String author, Integer publicationYear) {
        this(); // Call default constructor
        this.title = title;
        this.author = author;
        this.publicationYear = publicationYear;
    }
    
    /**
     * @description Full parameterized constructor
     * @param title The title of the item
     * @param author The author of the item
     * @param publicationYear The year of publication
     * @param price The price of the item
     * @param category The category of the item
     */
    public LibraryItem(String title, String author, Integer publicationYear, 
                      Decimal price, String category) {
        this(title, author, publicationYear); // Constructor chaining
        this.price = price;
        this.category = category;
    }
    
    // ========== GETTERS AND SETTERS: Controlled Access ==========
    // Public methods to access private fields (Encapsulation principle)
    
    public String getItemId() {
        return this.itemId;
    }
    
    public String getTitle() {
        return this.title;
    }
    
    public void setTitle(String title) {
        // Validation in setter (Encapsulation benefit)
        if (String.isNotBlank(title)) {
            this.title = title;
        } else {
            throw new IllegalArgumentException('Title cannot be blank');
        }
    }
    
    public String getAuthor() {
        return this.author;
    }
    
    public void setAuthor(String author) {
        if (String.isNotBlank(author)) {
            this.author = author;
        } else {
            throw new IllegalArgumentException('Author cannot be blank');
        }
    }
    
    public Integer getPublicationYear() {
        return this.publicationYear;
    }
    
    public void setPublicationYear(Integer publicationYear) {
        // Validation: year should be reasonable
        Integer currentYear = Date.today().year();
        if (publicationYear > 0 && publicationYear <= currentYear) {
            this.publicationYear = publicationYear;
        } else {
            throw new IllegalArgumentException('Invalid publication year');
        }
    }
    
    public Boolean getIsAvailable() {
        return this.isAvailable;
    }
    
    public void setIsAvailable(Boolean isAvailable) {
        this.isAvailable = isAvailable;
    }
    
    public Decimal getPrice() {
        return this.price;
    }
    
    public void setPrice(Decimal price) {
        if (price != null && price >= 0) {
            this.price = price;
        } else {
            throw new IllegalArgumentException('Price must be non-negative');
        }
    }
    
    public String getCategory() {
        return this.category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    // ========== STATIC METHOD: Class-level method ==========
    /**
     * @description Static method - can be called without creating an instance
     * @return Total number of library items created
     */
    public static Integer getTotalItems() {
        return totalItems;
    }
    
    // ========== PRIVATE HELPER METHOD: Internal Implementation ==========
    /**
     * @description Private method - only accessible within this class
     * Demonstrates data hiding and encapsulation
     * @return Generated unique ID
     */
    private String generateId() {
        return 'LIB-' + String.valueOf(DateTime.now().getTime()) + '-' + 
               String.valueOf(Math.random() * 10000).substring(0, 4);
    }
    
    // ========== PUBLIC METHODS: Behavior/Functionality ==========
    
    /**
     * @description Method to check out the item
     * Demonstrates business logic encapsulation
     * @return Boolean indicating success
     */
    public Boolean checkout() {
        if (this.isAvailable) {
            this.isAvailable = false;
            System.debug('Item ' + this.title + ' checked out successfully');
            return true;
        } else {
            System.debug('Item ' + this.title + ' is not available');
            return false;
        }
    }
    
    /**
     * @description Method to return the item
     * @return Boolean indicating success
     */
    public Boolean returnItem() {
        if (!this.isAvailable) {
            this.isAvailable = true;
            System.debug('Item ' + this.title + ' returned successfully');
            return true;
        } else {
            System.debug('Item ' + this.title + ' is already available');
            return false;
        }
    }
    
    /**
     * @description Method to get item information
     * Demonstrates method that operates on encapsulated data
     * @return Formatted string with item details
     */
    public String getItemInfo() {
        return 'ID: ' + this.itemId + 
               ', Title: ' + this.title + 
               ', Author: ' + this.author + 
               ', Year: ' + this.publicationYear + 
               ', Available: ' + this.isAvailable + 
               ', Price: $' + this.price + 
               ', Category: ' + this.category;
    }
    
    /**
     * @description Method to calculate age of the item
     * @return Age in years
     */
    public Integer getAge() {
        if (this.publicationYear != null) {
            return Date.today().year() - this.publicationYear;
        }
        return null;
    }
    
    /**
     * @description Override toString() method for better object representation
     * Demonstrates method overriding (will be shown in inheritance)
     * @return String representation of the object
     */
    public override String toString() {
        return this.getItemInfo();
    }
    
    /**
     * @description Override equals() method for object comparison
     * Demonstrates method overriding and object comparison
     * @param obj Object to compare
     * @return Boolean indicating equality
     */
    public override Boolean equals(Object obj) {
        if (obj instanceof LibraryItem) {
            LibraryItem other = (LibraryItem) obj;
            return this.itemId == other.itemId;
        }
        return false;
    }
    
    /**
     * @description Override hashCode() method
     * Important for using objects in Sets and as Map keys
     * @return Integer hash code
     */
    public override Integer hashCode() {
        return this.itemId.hashCode();
    }
}
// AI Generated Code by Deloitte + Cursor (END)


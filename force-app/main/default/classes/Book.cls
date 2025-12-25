// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description Demonstrates INHERITANCE - one of the four pillars of OOP
 * Inheritance: A class (Book) inherits properties and methods from a parent class (LibraryItem)
 * This allows code reuse and establishes an "is-a" relationship
 * 
 * Book "is-a" LibraryItem, so it inherits all fields and methods from LibraryItem
 * Demonstrates: Inheritance, Method Overriding, Polymorphism
 */
public class Book extends LibraryItem {
    
    // ========== INHERITANCE: Child class extends parent class ==========
    // Book inherits all public and protected members from LibraryItem
    
    // ========== ADDITIONAL FIELDS: Extended functionality ==========
    // Child class can add its own specific fields
    
    private Integer numberOfPages;
    private String isbn;
    private String publisher;
    private String edition;
    private String language;
    
    // ========== CONSTRUCTOR: Constructor chaining with super ==========
    /**
     * @description Default constructor for Book
     */
    public Book() {
        super(); // Call parent class constructor
        // Book-specific initialization
    }
    
    /**
     * @description Parameterized constructor
     * @param title Book title
     * @param author Book author
     * @param publicationYear Publication year
     * @param numberOfPages Number of pages
     * @param isbn ISBN number
     */
    public Book(String title, String author, Integer publicationYear, 
                Integer numberOfPages, String isbn) {
        super(title, author, publicationYear); // Call parent constructor
        this.numberOfPages = numberOfPages;
        this.isbn = isbn;
    }
    
    /**
     * @description Full constructor with all parameters
     */
    public Book(String title, String author, Integer publicationYear, 
                Decimal price, String category, Integer numberOfPages, 
                String isbn, String publisher, String edition, String language) {
        super(title, author, publicationYear, price, category); // Call parent constructor
        this.numberOfPages = numberOfPages;
        this.isbn = isbn;
        this.publisher = publisher;
        this.edition = edition;
        this.language = language;
    }
    
    // ========== GETTERS AND SETTERS ==========
    
    public Integer getNumberOfPages() {
        return this.numberOfPages;
    }
    
    public void setNumberOfPages(Integer numberOfPages) {
        if (numberOfPages != null && numberOfPages > 0) {
            this.numberOfPages = numberOfPages;
        } else {
            throw new IllegalArgumentException('Number of pages must be positive');
        }
    }
    
    public String getIsbn() {
        return this.isbn;
    }
    
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    
    public String getPublisher() {
        return this.publisher;
    }
    
    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }
    
    public String getEdition() {
        return this.edition;
    }
    
    public void setEdition(String edition) {
        this.edition = edition;
    }
    
    public String getLanguage() {
        return this.language;
    }
    
    public void setLanguage(String language) {
        this.language = language;
    }
    
    // ========== METHOD OVERRIDING: POLYMORPHISM ==========
    /**
     * @description Override parent class method to provide Book-specific implementation
     * This demonstrates POLYMORPHISM - same method name, different implementation
     * @return Formatted string with book details
     */
    public override String getItemInfo() {
        // Call parent method using super keyword
        String baseInfo = super.getItemInfo();
        return baseInfo + 
               ', Pages: ' + this.numberOfPages + 
               ', ISBN: ' + this.isbn + 
               ', Publisher: ' + this.publisher + 
               ', Edition: ' + this.edition + 
               ', Language: ' + this.language;
    }
    
    // ========== SPECIALIZED METHODS: Book-specific behavior ==========
    
    /**
     * @description Calculate reading time estimate (Book-specific method)
     * This method doesn't exist in parent class - demonstrates extended functionality
     * @param readingSpeed Words per minute (default: 200)
     * @return Estimated reading time in hours
     */
    public Decimal estimateReadingTime(Integer readingSpeed) {
        if (readingSpeed == null || readingSpeed <= 0) {
            readingSpeed = 200; // Default reading speed
        }
        // Average words per page: 250
        Integer totalWords = this.numberOfPages * 250;
        Decimal hours = (Decimal.valueOf(totalWords) / readingSpeed) / 60;
        return hours.setScale(2);
    }
    
    /**
     * @description Validate ISBN format (Book-specific validation)
     * @return Boolean indicating if ISBN is valid
     */
    public Boolean isValidIsbn() {
        if (String.isBlank(this.isbn)) {
            return false;
        }
        // Simple validation: ISBN-10 or ISBN-13
        String cleanIsbn = this.isbn.replaceAll('[^0-9X]', '');
        return cleanIsbn.length() == 10 || cleanIsbn.length() == 13;
    }
    
    /**
     * @description Get book category based on number of pages
     * Demonstrates additional business logic in child class
     * @return Category string
     */
    public String getBookCategoryByLength() {
        if (this.numberOfPages == null) {
            return 'Unknown';
        }
        if (this.numberOfPages < 100) {
            return 'Short Story';
        } else if (this.numberOfPages < 300) {
            return 'Novella';
        } else if (this.numberOfPages < 500) {
            return 'Novel';
        } else {
            return 'Epic';
        }
    }
    
    /**
     * @description Override toString() for Book
     * @return String representation
     */
    public override String toString() {
        return this.getItemInfo();
    }
}
// AI Generated Code by Deloitte + Cursor (END)


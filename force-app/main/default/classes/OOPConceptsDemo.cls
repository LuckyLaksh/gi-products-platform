// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description Comprehensive Demo Class - Demonstrates All OOP Concepts
 * 
 * This class serves as a practical demonstration and test harness for:
 * - All OOP concepts (Encapsulation, Inheritance, Polymorphism, Abstraction)
 * - Data Structures and Algorithms
 * - Design Patterns
 * - Exception Handling
 * 
 * Run methods from this class to see OOP concepts in action
 */
public class OOPConceptsDemo {
    
    /**
     * @description Main demo method - demonstrates all concepts
     * Call this method to see comprehensive OOP demonstration
     */
    public static void demonstrateAllConcepts() {
        System.debug('=== OOP CONCEPTS COMPREHENSIVE DEMONSTRATION ===\n');
        
        demonstrateEncapsulation();
        demonstrateInheritance();
        demonstratePolymorphism();
        demonstrateAbstraction();
        demonstrateDSA();
        demonstrateDesignPatterns();
        demonstrateExceptionHandling();
        
        System.debug('\n=== DEMONSTRATION COMPLETE ===');
    }
    
    /**
     * @description Demonstrate ENCAPSULATION
     */
    public static void demonstrateEncapsulation() {
        System.debug('\n--- ENCAPSULATION DEMONSTRATION ---');
        
        // Create LibraryItem - data is encapsulated (private fields)
        LibraryItem item = new LibraryItem('The Great Gatsby', 'F. Scott Fitzgerald', 1925);
        
        // Access data through public getters (encapsulation)
        System.debug('Title: ' + item.getTitle());
        System.debug('Author: ' + item.getAuthor());
        System.debug('Year: ' + item.getPublicationYear());
        
        // Modify data through public setters with validation (encapsulation)
        item.setPrice(29.99);
        item.setCategory('Fiction');
        
        System.debug('Item Info: ' + item.getItemInfo());
        System.debug('Total Items Created: ' + LibraryItem.getTotalItems());
    }
    
    /**
     * @description Demonstrate INHERITANCE
     */
    public static void demonstrateInheritance() {
        System.debug('\n--- INHERITANCE DEMONSTRATION ---');
        
        // Book inherits from LibraryItem
        Book book = new Book('1984', 'George Orwell', 1949, 328, '978-0-452-28423-4');
        book.setPrice(15.99);
        book.setCategory('Dystopian Fiction');
        
        // Book can use parent class methods
        System.debug('Book Info (inherited method): ' + book.getItemInfo());
        
        // Book has its own methods
        System.debug('Reading Time Estimate: ' + book.estimateReadingTime(200) + ' hours');
        System.debug('Book Category by Length: ' + book.getBookCategoryByLength());
        
        // Magazine also inherits from LibraryItem
        Magazine magazine = new Magazine('Time Magazine', 'Various', 2024, 1, 'Vol. 2024', Date.today());
        System.debug('Magazine Info: ' + magazine.getItemInfo());
        System.debug('Is Current: ' + magazine.isCurrent());
    }
    
    /**
     * @description Demonstrate POLYMORPHISM
     */
    public static void demonstratePolymorphism() {
        System.debug('\n--- POLYMORPHISM DEMONSTRATION ---');
        
        // Runtime Polymorphism - Method Overriding
        LibraryItem item1 = new Book('Book 1', 'Author 1', 2020, 300, 'ISBN1');
        LibraryItem item2 = new Magazine('Magazine 1', 'Author 2', 2024, 1, 'Vol.1', Date.today());
        
        // Same method call, different implementations (polymorphism)
        System.debug('Book getItemInfo: ' + item1.getItemInfo());
        System.debug('Magazine getItemInfo: ' + item2.getItemInfo());
        
        // Compile-time Polymorphism - Method Overloading
        PolymorphismExample polyExample = new PolymorphismExample();
        
        // Different method calls based on parameters (overloading)
        List<Book> results1 = polyExample.searchBooks('Title');
        List<Book> results2 = polyExample.searchBooks('Title', 'Author');
        List<Book> results3 = polyExample.searchBooks('Title', 'Author', 'Category');
        
        System.debug('Method overloading demonstrated with different parameter counts');
    }
    
    /**
     * @description Demonstrate ABSTRACTION
     */
    public static void demonstrateAbstraction() {
        System.debug('\n--- ABSTRACTION DEMONSTRATION ---');
        
        // Interface Implementation
        LoanableBook loanableBook = new LoanableBook('Loanable Book', 'Author', 2020, 400, 'ISBN123');
        loanableBook.setPrice(25.00);
        
        // Use interface methods (abstraction - we don't care about implementation)
        ILoanable loanable = loanableBook;
        Boolean loaned = loanable.loan('BORROWER001', Date.today());
        System.debug('Book loaned: ' + loaned);
        System.debug('Is on loan: ' + loanable.isOnLoan());
        System.debug('Current borrower: ' + loanable.getCurrentBorrower());
        
        // Abstract Class Implementation
        BookLoanService loanService = new BookLoanService(loanableBook, 'BORROWER002', Date.today());
        loanService.processService(); // Uses template method pattern
        System.debug('Service result: ' + loanService.getServiceResult());
    }
    
    /**
     * @description Demonstrate DATA STRUCTURES AND ALGORITHMS
     */
    public static void demonstrateDSA() {
        System.debug('\n--- DATA STRUCTURES AND ALGORITHMS DEMONSTRATION ---');
        
        // Create sample books
        List<Book> books = new List<Book>();
        books.add(new Book('Book A', 'Author 1', 2020, 300, 'ISBN1'));
        books.add(new Book('Book B', 'Author 2', 2021, 400, 'ISBN2'));
        books.add(new Book('Book C', 'Author 1', 2019, 250, 'ISBN3'));
        
        // Set prices
        books[0].setPrice(20.00);
        books[1].setPrice(30.00);
        books[2].setPrice(15.00);
        
        // Lists
        System.debug('List size: ' + books.size());
        
        // Sets
        Set<String> authors = new Set<String>();
        for (Book book : books) {
            authors.add(book.getAuthor());
        }
        System.debug('Unique authors: ' + authors);
        
        // Maps
        Map<String, Book> bookMap = DSAExamples.demonstrateMaps();
        System.debug('Book map size: ' + bookMap.size());
        
        // Grouping
        Map<String, List<Book>> grouped = DSAExamples.groupBooksByAuthor(books);
        System.debug('Books grouped by author: ' + grouped.keySet());
        
        // Searching
        Book found = DSAExamples.linearSearchByTitle(books, 'Book A');
        System.debug('Found book: ' + (found != null ? found.getTitle() : 'Not found'));
        
        // Sorting
        List<Book> sorted = DSAExamples.sortBooksByTitle(books);
        System.debug('Sorted books by title');
    }
    
    /**
     * @description Demonstrate DESIGN PATTERNS
     */
    public static void demonstrateDesignPatterns() {
        System.debug('\n--- DESIGN PATTERNS DEMONSTRATION ---');
        
        // Singleton Pattern
        LibraryManagerSingleton manager1 = LibraryManagerSingleton.getInstance();
        LibraryManagerSingleton manager2 = LibraryManagerSingleton.getInstance();
        System.debug('Singleton - Same instance: ' + (manager1 === manager2));
        
        // Register items
        Book book1 = new Book('Pattern Book', 'Design Author', 2023, 500, 'PAT001');
        manager1.registerItem(book1);
        System.debug('Total items in singleton: ' + manager1.getTotalItems());
        
        // Factory Pattern
        LibraryItem factoryBook = LibraryItemFactory.createItem('Book', 'Factory Book', 'Factory Author', 2023);
        System.debug('Factory created: ' + factoryBook.getTitle());
        
        LibraryItem factoryMagazine = LibraryItemFactory.createItem('Magazine', 'Factory Magazine', 'Factory Author', 2024);
        System.debug('Factory created: ' + factoryMagazine.getTitle());
        
        // Strategy Pattern
        Book strategyBook = new Book('Strategy Book', 'Strategy Author', 2023, 400, 'STRAT001');
        strategyBook.setPrice(100.00);
        
        // Use different pricing strategies
        PricingStrategy standardStrategy = new StandardPricingStrategy();
        PricingStrategy discountStrategy = new DiscountPricingStrategy(20); // 20% discount
        PricingStrategy ageStrategy = new AgeBasedPricingStrategy(0.05); // 5% per year
        
        PriceCalculator calculator = new PriceCalculator(standardStrategy);
        Decimal price1 = calculator.calculate(strategyBook.getPrice(), strategyBook);
        System.debug('Standard price: $' + price1);
        
        calculator.setStrategy(discountStrategy);
        Decimal price2 = calculator.calculate(strategyBook.getPrice(), strategyBook);
        System.debug('Discounted price: $' + price2);
        
        calculator.setStrategy(ageStrategy);
        Decimal price3 = calculator.calculate(strategyBook.getPrice(), strategyBook);
        System.debug('Age-based price: $' + price3);
        
        // Observer Pattern
        LibrarySubject subject = new LibrarySubject();
        ILibraryObserver observer = new LibraryLoggerObserver('Test Observer');
        subject.attach(observer);
        
        Book observedBook = new Book('Observed Book', 'Observer Author', 2023, 300, 'OBS001');
        Map<String, Object> eventData = new Map<String, Object>{'action' => 'created'};
        subject.notifyObservers('ITEM_ADDED', observedBook, eventData);
        System.debug('Observer notified');
    }
    
    /**
     * @description Demonstrate EXCEPTION HANDLING
     */
    public static void demonstrateExceptionHandling() {
        System.debug('\n--- EXCEPTION HANDLING DEMONSTRATION ---');
        
        // Basic exception handling
        LibraryItem validItem = new LibraryItem('Valid Item', 'Author', 2020);
        ExceptionHandlingExample.basicExceptionHandling(validItem);
        
        // Custom exception
        ExceptionHandlingExample.customExceptionExample('VALID123');
        ExceptionHandlingExample.customExceptionExample('INVALID123');
        
        // Try-catch-finally
        ExceptionHandlingExample.tryCatchFinallyExample(validItem);
        
        // Exception propagation
        try {
            LibraryItem invalidItem = new LibraryItem();
            ExceptionHandlingExample.validateItem(invalidItem);
        } catch (LibraryException e) {
            System.debug('Caught exception: ' + e.getFormattedError());
        }
    }
    
    /**
     * @description Complete real-world scenario demonstration
     */
    public static void realWorldScenario() {
        System.debug('\n=== REAL-WORLD LIBRARY MANAGEMENT SCENARIO ===\n');
        
        // 1. Create books using Factory Pattern
        LoanableBook book1 = LibraryItemFactory.createLoanableBook(
            'Design Patterns', 'Gang of Four', 1994, 395, '978-0201633610', 21
        );
        book1.setPrice(49.99);
        book1.setCategory('Programming');
        
        LoanableBook book2 = LibraryItemFactory.createLoanableBook(
            'Clean Code', 'Robert Martin', 2008, 464, '978-0132350884', 14
        );
        book2.setPrice(39.99);
        book2.setCategory('Programming');
        
        // 2. Register with Singleton Manager
        LibraryManagerSingleton manager = LibraryManagerSingleton.getInstance();
        manager.registerItem(book1);
        manager.registerItem(book2);
        
        // 3. Set up Observer Pattern
        LibrarySubject subject = new LibrarySubject();
        subject.attach(new LibraryLoggerObserver('Loan Logger'));
        
        // 4. Loan books using Strategy Pattern for pricing
        PriceCalculator calculator = new PriceCalculator(new DiscountPricingStrategy(10));
        Decimal finalPrice1 = calculator.calculate(book1.getPrice(), book1);
        System.debug('Book 1 final price: $' + finalPrice1);
        
        // 5. Loan the book
        ILoanable loanable1 = book1;
        Boolean loaned = loanable1.loan('STUDENT001', Date.today());
        if (loaned) {
            manager.registerLoan('STUDENT001', book1);
            subject.notifyObservers('ITEM_LOANED', book1, 
                new Map<String, Object>{'borrower' => 'STUDENT001'});
        }
        
        // 6. Demonstrate DSA operations
        List<Book> allBooks = new List<Book>{book1, book2};
        Map<String, List<Book>> grouped = DSAExamples.groupBooksByAuthor(allBooks);
        System.debug('Books grouped by author: ' + grouped);
        
        // 7. Check for overdue
        if (loanable1.isOnLoan()) {
            Decimal fine = loanable1.calculateFine(0.50);
            System.debug('Current fine: $' + fine);
        }
        
        System.debug('\n=== SCENARIO COMPLETE ===');
    }
}
// AI Generated Code by Deloitte + Cursor (END)


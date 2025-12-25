// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description Comprehensive Data Structures and Algorithms (DSA) examples in Apex
 * 
 * This class demonstrates:
 * - Lists (Dynamic Arrays)
 * - Sets (Unique Collections)
 * - Maps (Key-Value Pairs)
 * - Sorting Algorithms
 * - Searching Algorithms
 * - Common DSA patterns and operations
 * 
 * Essential for every experienced Apex developer
 */
public class DSAExamples {
    
    // ========== LIST OPERATIONS ==========
    // Lists are ordered, indexed collections (like arrays)
    
    /**
     * @description Demonstrate List operations
     * @return Example list
     */
    public static List<String> demonstrateLists() {
        // Create list
        List<String> books = new List<String>();
        
        // Add elements
        books.add('Book 1');
        books.add('Book 2');
        books.add('Book 3');
        
        // Add multiple elements at once
        books.addAll(new List<String>{'Book 4', 'Book 5'});
        
        // Access by index
        String firstBook = books[0];
        
        // Get size
        Integer size = books.size();
        
        // Check if empty
        Boolean isEmpty = books.isEmpty();
        
        // Check if contains element
        Boolean contains = books.contains('Book 1');
        
        // Remove element
        books.remove(0); // Remove by index
        books.remove(books.indexOf('Book 2')); // Remove by finding index
        
        // Clear list
        // books.clear();
        
        return books;
    }
    
    /**
     * @description Sort list of books by title
     * Demonstrates sorting algorithm
     * @param books List of books
     * @return Sorted list
     */
    public static List<Book> sortBooksByTitle(List<Book> books) {
        if (books == null || books.isEmpty()) {
            return books;
        }
        
        // Bubble Sort implementation (educational purpose)
        // In practice, use List.sort() or custom Comparator
        List<Book> sortedBooks = new List<Book>(books);
        Integer n = sortedBooks.size();
        
        for (Integer i = 0; i < n - 1; i++) {
            for (Integer j = 0; j < n - i - 1; j++) {
                if (sortedBooks[j].getTitle() > sortedBooks[j + 1].getTitle()) {
                    // Swap
                    Book temp = sortedBooks[j];
                    sortedBooks[j] = sortedBooks[j + 1];
                    sortedBooks[j + 1] = temp;
                }
            }
        }
        
        return sortedBooks;
    }
    
    /**
     * @description Quick Sort implementation (more efficient)
     * @param books List of books
     * @param low Starting index
     * @param high Ending index
     */
    public static void quickSortByPrice(List<Book> books, Integer low, Integer high) {
        if (low < high) {
            // Partition index
            Integer pi = partitionByPrice(books, low, high);
            
            // Recursively sort elements before and after partition
            quickSortByPrice(books, low, pi - 1);
            quickSortByPrice(books, pi + 1, high);
        }
    }
    
    /**
     * @description Partition function for Quick Sort
     * @param books List of books
     * @param low Starting index
     * @param high Ending index
     * @return Partition index
     */
    private static Integer partitionByPrice(List<Book> books, Integer low, Integer high) {
        Decimal pivot = books[high].getPrice() != null ? books[high].getPrice() : 0;
        Integer i = low - 1; // Index of smaller element
        
        for (Integer j = low; j < high; j++) {
            Decimal bookPrice = books[j].getPrice() != null ? books[j].getPrice() : 0;
            if (bookPrice <= pivot) {
                i++;
                // Swap
                Book temp = books[i];
                books[i] = books[j];
                books[j] = temp;
            }
        }
        
        // Swap pivot
        Book temp = books[i + 1];
        books[i + 1] = books[high];
        books[high] = temp;
        
        return i + 1;
    }
    
    // ========== SET OPERATIONS ==========
    // Sets are unordered collections of unique elements
    
    /**
     * @description Demonstrate Set operations
     * @return Example set
     */
    public static Set<String> demonstrateSets() {
        // Create set
        Set<String> uniqueAuthors = new Set<String>();
        
        // Add elements (duplicates are automatically ignored)
        uniqueAuthors.add('Author 1');
        uniqueAuthors.add('Author 2');
        uniqueAuthors.add('Author 1'); // Duplicate - will be ignored
        
        // Add multiple elements
        uniqueAuthors.addAll(new List<String>{'Author 3', 'Author 4', 'Author 3'});
        
        // Check if contains
        Boolean contains = uniqueAuthors.contains('Author 1');
        
        // Remove element
        uniqueAuthors.remove('Author 2');
        
        // Get size
        Integer size = uniqueAuthors.size();
        
        // Convert to list
        List<String> authorList = new List<String>(uniqueAuthors);
        
        return uniqueAuthors;
    }
    
    /**
     * @description Find common authors between two book lists
     * Demonstrates set intersection
     * @param books1 First list of books
     * @param books2 Second list of books
     * @return Set of common authors
     */
    public static Set<String> findCommonAuthors(List<Book> books1, List<Book> books2) {
        Set<String> authors1 = new Set<String>();
        Set<String> authors2 = new Set<String>();
        
        // Collect authors from first list
        for (Book book : books1) {
            if (String.isNotBlank(book.getAuthor())) {
                authors1.add(book.getAuthor());
            }
        }
        
        // Collect authors from second list
        for (Book book : books2) {
            if (String.isNotBlank(book.getAuthor())) {
                authors2.add(book.getAuthor());
            }
        }
        
        // Find intersection (common elements)
        authors1.retainAll(authors2);
        
        return authors1;
    }
    
    // ========== MAP OPERATIONS ==========
    // Maps are key-value pairs (like dictionaries/hash tables)
    
    /**
     * @description Demonstrate Map operations
     * @return Example map
     */
    public static Map<String, Book> demonstrateMaps() {
        // Create map
        Map<String, Book> bookMap = new Map<String, Book>();
        
        // Create sample books
        Book book1 = new Book('Title 1', 'Author 1', 2020, 300, 'ISBN1');
        Book book2 = new Book('Title 2', 'Author 2', 2021, 400, 'ISBN2');
        
        // Add key-value pairs
        bookMap.put('ISBN1', book1);
        bookMap.put('ISBN2', book2);
        
        // Access by key
        Book retrievedBook = bookMap.get('ISBN1');
        
        // Check if contains key
        Boolean containsKey = bookMap.containsKey('ISBN1');
        
        // Check if contains value
        Boolean containsValue = bookMap.containsValue(book1);
        
        // Get all keys
        Set<String> keys = bookMap.keySet();
        
        // Get all values
        List<Book> values = bookMap.values();
        
        // Remove by key
        bookMap.remove('ISBN1');
        
        // Get size
        Integer size = bookMap.size();
        
        // Clear map
        // bookMap.clear();
        
        return bookMap;
    }
    
    /**
     * @description Group books by author using Map
     * Demonstrates map grouping pattern
     * @param books List of books
     * @return Map of author to list of books
     */
    public static Map<String, List<Book>> groupBooksByAuthor(List<Book> books) {
        Map<String, List<Book>> authorToBooks = new Map<String, List<Book>>();
        
        for (Book book : books) {
            String author = book.getAuthor();
            if (String.isBlank(author)) {
                author = 'Unknown';
            }
            
            // Check if author key exists
            if (!authorToBooks.containsKey(author)) {
                authorToBooks.put(author, new List<Book>());
            }
            
            // Add book to author's list
            authorToBooks.get(author).add(book);
        }
        
        return authorToBooks;
    }
    
    /**
     * @description Count frequency of each category
     * Demonstrates map counting pattern
     * @param books List of books
     * @return Map of category to count
     */
    public static Map<String, Integer> countBooksByCategory(List<Book> books) {
        Map<String, Integer> categoryCount = new Map<String, Integer>();
        
        for (Book book : books) {
            String category = book.getCategory();
            if (String.isBlank(category)) {
                category = 'Uncategorized';
            }
            
            // Increment count
            if (categoryCount.containsKey(category)) {
                categoryCount.put(category, categoryCount.get(category) + 1);
            } else {
                categoryCount.put(category, 1);
            }
        }
        
        return categoryCount;
    }
    
    // ========== SEARCHING ALGORITHMS ==========
    
    /**
     * @description Linear Search - find book by title
     * Time Complexity: O(n)
     * @param books List of books
     * @param title Title to search
     * @return Found book or null
     */
    public static Book linearSearchByTitle(List<Book> books, String title) {
        if (books == null || String.isBlank(title)) {
            return null;
        }
        
        for (Book book : books) {
            if (book.getTitle() == title) {
                return book;
            }
        }
        
        return null;
    }
    
    /**
     * @description Binary Search - find book by price (requires sorted list)
     * Time Complexity: O(log n)
     * @param books Sorted list of books
     * @param price Price to search
     * @return Found book or null
     */
    public static Book binarySearchByPrice(List<Book> books, Decimal price) {
        if (books == null || books.isEmpty() || price == null) {
            return null;
        }
        
        Integer left = 0;
        Integer right = books.size() - 1;
        
        while (left <= right) {
            Integer mid = left + (right - left) / 2;
            Decimal midPrice = books[mid].getPrice() != null ? books[mid].getPrice() : 0;
            
            if (midPrice == price) {
                return books[mid];
            } else if (midPrice < price) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        
        return null;
    }
    
    // ========== ADVANCED DSA PATTERNS ==========
    
    /**
     * @description Find maximum price book
     * Demonstrates finding max/min pattern
     * @param books List of books
     * @return Book with maximum price
     */
    public static Book findMaxPriceBook(List<Book> books) {
        if (books == null || books.isEmpty()) {
            return null;
        }
        
        Book maxBook = books[0];
        Decimal maxPrice = maxBook.getPrice() != null ? maxBook.getPrice() : 0;
        
        for (Integer i = 1; i < books.size(); i++) {
            Decimal currentPrice = books[i].getPrice() != null ? books[i].getPrice() : 0;
            if (currentPrice > maxPrice) {
                maxPrice = currentPrice;
                maxBook = books[i];
            }
        }
        
        return maxBook;
    }
    
    /**
     * @description Reverse a list
     * Demonstrates list reversal algorithm
     * @param books List to reverse
     * @return Reversed list
     */
    public static List<Book> reverseList(List<Book> books) {
        if (books == null || books.isEmpty()) {
            return books;
        }
        
        List<Book> reversed = new List<Book>();
        for (Integer i = books.size() - 1; i >= 0; i--) {
            reversed.add(books[i]);
        }
        
        return reversed;
    }
    
    /**
     * @description Remove duplicates from list using Set
     * Demonstrates deduplication pattern
     * @param books List with potential duplicates
     * @return List without duplicates
     */
    public static List<Book> removeDuplicates(List<Book> books) {
        if (books == null || books.isEmpty()) {
            return books;
        }
        
        Set<String> seenTitles = new Set<String>();
        List<Book> uniqueBooks = new List<Book>();
        
        for (Book book : books) {
            String title = book.getTitle();
            if (!seenTitles.contains(title)) {
                seenTitles.add(title);
                uniqueBooks.add(book);
            }
        }
        
        return uniqueBooks;
    }
    
    /**
     * @description Merge two sorted lists
     * Demonstrates merge algorithm
     * @param list1 First sorted list
     * @param list2 Second sorted list
     * @return Merged sorted list
     */
    public static List<Book> mergeSortedLists(List<Book> list1, List<Book> list2) {
        List<Book> merged = new List<Book>();
        Integer i = 0, j = 0;
        
        while (i < list1.size() && j < list2.size()) {
            Decimal price1 = list1[i].getPrice() != null ? list1[i].getPrice() : 0;
            Decimal price2 = list2[j].getPrice() != null ? list2[j].getPrice() : 0;
            
            if (price1 <= price2) {
                merged.add(list1[i]);
                i++;
            } else {
                merged.add(list2[j]);
                j++;
            }
        }
        
        // Add remaining elements
        while (i < list1.size()) {
            merged.add(list1[i]);
            i++;
        }
        
        while (j < list2.size()) {
            merged.add(list2[j]);
            j++;
        }
        
        return merged;
    }
}
// AI Generated Code by Deloitte + Cursor (END)


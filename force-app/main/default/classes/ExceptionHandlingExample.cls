// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description Comprehensive Exception Handling Examples
 * 
 * Demonstrates:
 * - Try-Catch-Finally blocks
 * - Custom exception handling
 * - Exception propagation
 * - Multiple catch blocks
 * - Exception best practices
 */
public class ExceptionHandlingExample {
    
    /**
     * @description Basic try-catch example
     * @param item Library item
     */
    public static void basicExceptionHandling(LibraryItem item) {
        try {
            // Code that might throw exception
            String title = item.getTitle();
            System.debug('Title: ' + title);
        } catch (NullPointerException e) {
            // Handle NullPointerException
            System.debug('NullPointerException: ' + e.getMessage());
        } catch (Exception e) {
            // Handle any other exception
            System.debug('Exception: ' + e.getMessage());
            System.debug('Stack trace: ' + e.getStackTraceString());
        }
    }
    
    /**
     * @description Try-catch-finally example
     * Finally block always executes
     * @param item Library item
     */
    public static void tryCatchFinallyExample(LibraryItem item) {
        try {
            // Code that might throw exception
            item.setTitle('New Title');
            System.debug('Title set successfully');
        } catch (IllegalArgumentException e) {
            System.debug('Invalid argument: ' + e.getMessage());
        } catch (Exception e) {
            System.debug('Unexpected error: ' + e.getMessage());
        } finally {
            // This block always executes, even if exception occurs
            System.debug('Finally block executed - cleanup code here');
        }
    }
    
    /**
     * @description Custom exception example
     * @param itemId Item ID
     */
    public static void customExceptionExample(String itemId) {
        try {
            if (String.isBlank(itemId)) {
                throw new LibraryException('Item ID cannot be blank', 'ERR_001', itemId);
            }
            
            // Simulate item not found
            if (itemId.startsWith('INVALID')) {
                throw new LibraryException('Item not found', 'ERR_404', itemId);
            }
            
            System.debug('Item found: ' + itemId);
        } catch (LibraryException e) {
            System.debug('Library Exception: ' + e.getFormattedError());
            System.debug('Error Code: ' + e.getErrorCode());
        } catch (Exception e) {
            System.debug('General Exception: ' + e.getMessage());
        }
    }
    
    /**
     * @description Exception propagation example
     * @param item Library item
     * @throws LibraryException If validation fails
     */
    public static void validateItem(LibraryItem item) {
        if (item == null) {
            throw new LibraryException('Item cannot be null', 'ERR_NULL');
        }
        
        if (String.isBlank(item.getTitle())) {
            throw new LibraryException('Item title is required', 'ERR_TITLE');
        }
        
        if (String.isBlank(item.getAuthor())) {
            throw new LibraryException('Item author is required', 'ERR_AUTHOR');
        }
        
        System.debug('Item validated successfully');
    }
    
    /**
     * @description Call method that throws exception
     * Demonstrates exception propagation
     */
    public static void callValidateItem() {
        try {
            LibraryItem item = new LibraryItem();
            // This will throw exception because title is blank
            validateItem(item);
        } catch (LibraryException e) {
            System.debug('Validation failed: ' + e.getFormattedError());
            // Can re-throw or handle
        }
    }
    
    /**
     * @description Safe method execution with error handling
     * @param items List of items to process
     * @return List of successfully processed items
     */
    public static List<LibraryItem> safeProcessItems(List<LibraryItem> items) {
        List<LibraryItem> processedItems = new List<LibraryItem>();
        
        if (items == null || items.isEmpty()) {
            return processedItems;
        }
        
        for (LibraryItem item : items) {
            try {
                // Process item
                validateItem(item);
                processedItems.add(item);
            } catch (LibraryException e) {
                // Log error but continue with next item
                System.debug('Failed to process item: ' + e.getFormattedError());
                // Don't add to processed list
            } catch (Exception e) {
                // Handle unexpected errors
                System.debug('Unexpected error processing item: ' + e.getMessage());
            }
        }
        
        return processedItems;
    }
    
    /**
     * @description Nested try-catch example
     * @param item Library item
     */
    public static void nestedTryCatchExample(LibraryItem item) {
        try {
            // Outer try block
            try {
                // Inner try block
                String title = item.getTitle();
                Integer length = title.length();
                System.debug('Title length: ' + length);
            } catch (NullPointerException e) {
                System.debug('Inner catch: NullPointerException');
                throw; // Re-throw exception
            }
        } catch (Exception e) {
            System.debug('Outer catch: ' + e.getMessage());
        }
    }
}
// AI Generated Code by Deloitte + Cursor (END)


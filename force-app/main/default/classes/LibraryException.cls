// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description CUSTOM EXCEPTION CLASS
 * Demonstrates custom exception handling in Apex
 * 
 * Custom exceptions allow you to create domain-specific error handling
 * Extend Exception class to create custom exceptions
 * 
 * Demonstrates: Exception Handling, Custom Exceptions, Error Management
 */
public class LibraryException extends Exception {
    
    // ========== CUSTOM EXCEPTION FIELDS ==========
    // Can add custom fields to provide more context
    
    private String errorCode;
    private String itemId;
    
    /**
     * @description Constructor with message
     * @param message Error message
     */
    public LibraryException(String message) {
        this.setMessage(message);
    }
    
    /**
     * @description Constructor with message and error code
     * @param message Error message
     * @param errorCode Error code
     */
    public LibraryException(String message, String errorCode) {
        this.setMessage(message);
        this.errorCode = errorCode;
    }
    
    /**
     * @description Constructor with message, error code, and item ID
     * @param message Error message
     * @param errorCode Error code
     * @param itemId Item ID related to error
     */
    public LibraryException(String message, String errorCode, String itemId) {
        this.setMessage(message);
        this.errorCode = errorCode;
        this.itemId = itemId;
    }
    
    // ========== GETTERS ==========
    
    public String getErrorCode() {
        return this.errorCode;
    }
    
    public String getItemId() {
        return this.itemId;
    }
    
    /**
     * @description Get formatted error message
     * @return Formatted error string
     */
    public String getFormattedError() {
        String error = 'Library Error';
        if (String.isNotBlank(this.errorCode)) {
            error += ' [' + this.errorCode + ']';
        }
        error += ': ' + this.getMessage();
        if (String.isNotBlank(this.itemId)) {
            error += ' (Item ID: ' + this.itemId + ')';
        }
        return error;
    }
}
// AI Generated Code by Deloitte + Cursor (END)


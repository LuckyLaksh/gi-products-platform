// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description OBSERVER PATTERN - Concrete Observer Implementation
 * Logs library events to debug log
 * 
 * Demonstrates: Observer Pattern Implementation
 */
public class LibraryLoggerObserver implements ILibraryObserver {
    
    private String observerName;
    
    /**
     * @description Constructor
     * @param observerName Name of this observer
     */
    public LibraryLoggerObserver(String observerName) {
        this.observerName = observerName;
    }
    
    /**
     * @description Update method called when event occurs
     * @param eventType Type of event
     * @param item Library item involved
     * @param additionalData Additional event data
     */
    public void update(String eventType, LibraryItem item, Map<String, Object> additionalData) {
        String message = '[' + this.observerName + '] Event: ' + eventType;
        if (item != null) {
            message += ', Item: ' + item.getTitle();
        }
        if (additionalData != null && !additionalData.isEmpty()) {
            message += ', Data: ' + additionalData;
        }
        System.debug(message);
    }
}
// AI Generated Code by Deloitte + Cursor (END)


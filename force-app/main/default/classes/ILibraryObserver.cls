// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description OBSERVER PATTERN - Observer Interface
 * Observer Pattern: Define a one-to-many dependency between objects
 * When one object changes state, all dependents are notified
 * 
 * This interface defines observers that watch library events
 * Demonstrates: Observer Pattern, Event-driven Architecture
 */
public interface ILibraryObserver {
    /**
     * @description Called when library event occurs
     * @param eventType Type of event (e.g., 'ITEM_ADDED', 'ITEM_LOANED')
     * @param item Library item involved
     * @param additionalData Additional event data
     */
    void update(String eventType, LibraryItem item, Map<String, Object> additionalData);
}
// AI Generated Code by Deloitte + Cursor (END)


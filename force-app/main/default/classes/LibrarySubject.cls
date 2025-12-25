// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description OBSERVER PATTERN - Subject Class
 * Maintains a list of observers and notifies them of state changes
 * 
 * Demonstrates: Observer Pattern, Subject-Observer Relationship
 */
public class LibrarySubject {
    
    // ========== OBSERVER PATTERN: List of observers ==========
    private List<ILibraryObserver> observers;
    
    /**
     * @description Constructor
     */
    public LibrarySubject() {
        this.observers = new List<ILibraryObserver>();
    }
    
    /**
     * @description Attach an observer
     * @param observer Observer to attach
     */
    public void attach(ILibraryObserver observer) {
        if (observer != null && !this.observers.contains(observer)) {
            this.observers.add(observer);
        }
    }
    
    /**
     * @description Detach an observer
     * @param observer Observer to detach
     */
    public void detach(ILibraryObserver observer) {
        if (observer != null) {
            Integer index = this.observers.indexOf(observer);
            if (index >= 0) {
                this.observers.remove(index);
            }
        }
    }
    
    /**
     * @description Notify all observers of an event
     * @param eventType Type of event
     * @param item Library item involved
     * @param additionalData Additional event data
     */
    public void notifyObservers(String eventType, LibraryItem item, 
                                Map<String, Object> additionalData) {
        for (ILibraryObserver observer : this.observers) {
            try {
                observer.update(eventType, item, additionalData);
            } catch (Exception e) {
                System.debug('Error notifying observer: ' + e.getMessage());
                // Continue with other observers
            }
        }
    }
    
    /**
     * @description Get number of observers
     * @return Observer count
     */
    public Integer getObserverCount() {
        return this.observers.size();
    }
}
// AI Generated Code by Deloitte + Cursor (END)


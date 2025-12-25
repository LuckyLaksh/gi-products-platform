// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description ABSTRACT CLASS - Demonstrates ABSTRACTION
 * Abstract Class: A class that cannot be instantiated directly
 * Can contain both abstract methods (must be implemented by subclasses) and concrete methods
 * 
 * Abstract classes are used when you want to provide a base implementation
 * but require subclasses to implement specific methods
 * 
 * This abstract class provides common library service functionality
 * Demonstrates: Abstraction, Abstract Class, Template Method Pattern
 */
public abstract class AbstractLibraryService {
    
    // ========== CONCRETE FIELDS: Can have instance variables ==========
    
    protected String serviceName;
    protected Boolean isActive;
    protected DateTime lastUpdated;
    
    // ========== CONSTRUCTOR: Abstract classes can have constructors ==========
    
    public AbstractLibraryService(String serviceName) {
        this.serviceName = serviceName;
        this.isActive = true;
        this.lastUpdated = DateTime.now();
    }
    
    // ========== CONCRETE METHODS: Can have implemented methods ==========
    
    /**
     * @description Concrete method - has implementation
     * All subclasses inherit this method
     * @return Service name
     */
    public String getServiceName() {
        return this.serviceName;
    }
    
    /**
     * @description Concrete method
     * @return Active status
     */
    public Boolean getIsActive() {
        return this.isActive;
    }
    
    /**
     * @description Concrete method
     * @param isActive Active status
     */
    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
        this.lastUpdated = DateTime.now();
    }
    
    /**
     * @description Template Method Pattern
     * Defines the skeleton of an algorithm, delegating some steps to subclasses
     * This is a concrete method that calls abstract methods
     */
    public void processService() {
        System.debug('Starting service: ' + this.serviceName);
        
        // Step 1: Validate (abstract - must be implemented by subclass)
        if (!validate()) {
            System.debug('Validation failed');
            return;
        }
        
        // Step 2: Execute (abstract - must be implemented by subclass)
        execute();
        
        // Step 3: Log (concrete - inherited by all subclasses)
        logService();
        
        System.debug('Service completed: ' + this.serviceName);
    }
    
    /**
     * @description Concrete method for logging
     * Part of template method pattern
     */
    protected void logService() {
        System.debug('Service logged: ' + this.serviceName + ' at ' + DateTime.now());
    }
    
    // ========== ABSTRACT METHODS: Must be implemented by subclasses ==========
    // Abstract methods have no body - only signature
    // Subclasses MUST provide implementation
    
    /**
     * @description Abstract method - must be implemented by subclass
     * @return Boolean indicating validation success
     */
    public abstract Boolean validate();
    
    /**
     * @description Abstract method - must be implemented by subclass
     * Performs the main service operation
     */
    public abstract void execute();
    
    /**
     * @description Abstract method - must be implemented by subclass
     * @return Service result as string
     */
    public abstract String getServiceResult();
}
// AI Generated Code by Deloitte + Cursor (END)


// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description Another example of INHERITANCE
 * Magazine also extends LibraryItem, demonstrating that multiple classes can inherit from the same parent
 * This shows polymorphism - different child classes can be treated as the parent type
 * 
 * Demonstrates: Inheritance, Polymorphism, Method Overriding
 */
public class Magazine extends LibraryItem {
    
    // ========== MAGAZINE-SPECIFIC FIELDS ==========
    
    private Integer issueNumber;
    private String volume;
    private Date publicationDate;
    private String frequency; // Monthly, Weekly, Quarterly, etc.
    private String editor;
    
    // ========== CONSTRUCTORS ==========
    
    public Magazine() {
        super();
    }
    
    public Magazine(String title, String author, Integer publicationYear, 
                   Integer issueNumber, String volume, Date publicationDate) {
        super(title, author, publicationYear);
        this.issueNumber = issueNumber;
        this.volume = volume;
        this.publicationDate = publicationDate;
    }
    
    // ========== GETTERS AND SETTERS ==========
    
    public Integer getIssueNumber() {
        return this.issueNumber;
    }
    
    public void setIssueNumber(Integer issueNumber) {
        if (issueNumber != null && issueNumber > 0) {
            this.issueNumber = issueNumber;
        } else {
            throw new IllegalArgumentException('Issue number must be positive');
        }
    }
    
    public String getVolume() {
        return this.volume;
    }
    
    public void setVolume(String volume) {
        this.volume = volume;
    }
    
    public Date getPublicationDate() {
        return this.publicationDate;
    }
    
    public void setPublicationDate(Date publicationDate) {
        this.publicationDate = publicationDate;
    }
    
    public String getFrequency() {
        return this.frequency;
    }
    
    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }
    
    public String getEditor() {
        return this.editor;
    }
    
    public void setEditor(String editor) {
        this.editor = editor;
    }
    
    // ========== METHOD OVERRIDING: POLYMORPHISM ==========
    
    /**
     * @description Override parent method with Magazine-specific implementation
     * Same method name as parent and Book class, but different implementation
     * @return Formatted string with magazine details
     */
    public override String getItemInfo() {
        String baseInfo = super.getItemInfo();
        return baseInfo + 
               ', Issue: ' + this.issueNumber + 
               ', Volume: ' + this.volume + 
               ', Publication Date: ' + this.publicationDate + 
               ', Frequency: ' + this.frequency + 
               ', Editor: ' + this.editor;
    }
    
    // ========== MAGAZINE-SPECIFIC METHODS ==========
    
    /**
     * @description Check if magazine is current (published within last 3 months)
     * @return Boolean indicating if magazine is current
     */
    public Boolean isCurrent() {
        if (this.publicationDate == null) {
            return false;
        }
        Date threeMonthsAgo = Date.today().addMonths(-3);
        return this.publicationDate >= threeMonthsAgo;
    }
    
    /**
     * @description Get days since publication
     * @return Number of days
     */
    public Integer getDaysSincePublication() {
        if (this.publicationDate == null) {
            return null;
        }
        return Date.today().daysBetween(this.publicationDate);
    }
    
    /**
     * @description Override toString()
     * @return String representation
     */
    public override String toString() {
        return this.getItemInfo();
    }
}
// AI Generated Code by Deloitte + Cursor (END)


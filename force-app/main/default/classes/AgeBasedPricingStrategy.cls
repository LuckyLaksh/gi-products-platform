// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description STRATEGY PATTERN - Another Concrete Strategy Implementation
 * Age-based pricing: Older items get discount based on age
 * 
 * Demonstrates: Strategy Pattern - Context-aware Strategy
 */
public class AgeBasedPricingStrategy implements PricingStrategy {
    
    private Decimal discountPerYear;
    
    /**
     * @description Constructor
     * @param discountPerYear Discount per year of age (e.g., 0.05 for 5% per year)
     */
    public AgeBasedPricingStrategy(Decimal discountPerYear) {
        if (discountPerYear < 0 || discountPerYear > 1) {
            throw new IllegalArgumentException('Discount per year must be between 0 and 1');
        }
        this.discountPerYear = discountPerYear;
    }
    
    /**
     * @description Calculate price based on item age
     * @param basePrice Base price
     * @param item Library item
     * @return Age-adjusted price
     */
    public Decimal calculatePrice(Decimal basePrice, LibraryItem item) {
        if (basePrice == null || basePrice <= 0) {
            return 0;
        }
        
        Integer age = item.getAge();
        if (age == null || age <= 0) {
            return basePrice;
        }
        
        Decimal totalDiscount = age * this.discountPerYear;
        // Cap discount at 50%
        if (totalDiscount > 0.50) {
            totalDiscount = 0.50;
        }
        
        Decimal discountAmount = basePrice * totalDiscount;
        return basePrice - discountAmount;
    }
}
// AI Generated Code by Deloitte + Cursor (END)


// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description STRATEGY PATTERN - Another Concrete Strategy Implementation
 * Discount pricing: Apply percentage discount
 * 
 * Demonstrates: Strategy Pattern - Multiple Strategies
 */
public class DiscountPricingStrategy implements PricingStrategy {
    
    private Decimal discountPercentage;
    
    /**
     * @description Constructor
     * @param discountPercentage Discount percentage (e.g., 10 for 10%)
     */
    public DiscountPricingStrategy(Decimal discountPercentage) {
        if (discountPercentage < 0 || discountPercentage > 100) {
            throw new IllegalArgumentException('Discount must be between 0 and 100');
        }
        this.discountPercentage = discountPercentage;
    }
    
    /**
     * @description Calculate price with discount
     * @param basePrice Base price
     * @param item Library item
     * @return Discounted price
     */
    public Decimal calculatePrice(Decimal basePrice, LibraryItem item) {
        if (basePrice == null || basePrice <= 0) {
            return 0;
        }
        
        Decimal discountAmount = basePrice * (this.discountPercentage / 100);
        return basePrice - discountAmount;
    }
}
// AI Generated Code by Deloitte + Cursor (END)


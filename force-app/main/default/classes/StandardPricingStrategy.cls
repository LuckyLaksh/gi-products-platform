// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description STRATEGY PATTERN - Concrete Strategy Implementation
 * Standard pricing: No discount, return base price
 * 
 * Demonstrates: Strategy Pattern Implementation
 */
public class StandardPricingStrategy implements PricingStrategy {
    
    /**
     * @description Calculate standard price (no discount)
     * @param basePrice Base price
     * @param item Library item
     * @return Base price
     */
    public Decimal calculatePrice(Decimal basePrice, LibraryItem item) {
        return basePrice != null ? basePrice : 0;
    }
}
// AI Generated Code by Deloitte + Cursor (END)


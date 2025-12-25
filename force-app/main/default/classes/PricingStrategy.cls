// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description STRATEGY PATTERN - Interface
 * Strategy Pattern: Define a family of algorithms, encapsulate each one, and make them interchangeable
 * 
 * This interface defines the strategy for calculating prices
 * Different implementations can provide different pricing algorithms
 * 
 * Demonstrates: Strategy Pattern, Interface-based Design
 */
public interface PricingStrategy {
    /**
     * @description Calculate price based on strategy
     * @param basePrice Base price of the item
     * @param item Library item
     * @return Calculated price
     */
    Decimal calculatePrice(Decimal basePrice, LibraryItem item);
}
// AI Generated Code by Deloitte + Cursor (END)


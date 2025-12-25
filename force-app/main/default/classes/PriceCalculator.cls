// AI Generated Code by Deloitte + Cursor (BEGIN)
/**
 * @description STRATEGY PATTERN - Context Class
 * This class uses the strategy pattern to calculate prices
 * It can switch between different pricing strategies at runtime
 * 
 * Demonstrates: Strategy Pattern Context, Runtime Strategy Selection
 */
public class PriceCalculator {
    
    // ========== STRATEGY PATTERN: Hold reference to strategy ==========
    private PricingStrategy strategy;
    
    /**
     * @description Constructor with strategy
     * @param strategy Pricing strategy to use
     */
    public PriceCalculator(PricingStrategy strategy) {
        this.strategy = strategy;
    }
    
    /**
     * @description Set strategy (allows changing strategy at runtime)
     * @param strategy New pricing strategy
     */
    public void setStrategy(PricingStrategy strategy) {
        this.strategy = strategy;
    }
    
    /**
     * @description Calculate price using current strategy
     * @param basePrice Base price
     * @param item Library item
     * @return Calculated price
     */
    public Decimal calculate(Decimal basePrice, LibraryItem item) {
        if (this.strategy == null) {
            return basePrice != null ? basePrice : 0;
        }
        return this.strategy.calculatePrice(basePrice, item);
    }
    
    /**
     * @description Calculate price for multiple items
     * @param items List of items with base prices
     * @return Map of item ID to calculated price
     */
    public Map<String, Decimal> calculateBatch(List<LibraryItem> items) {
        Map<String, Decimal> prices = new Map<String, Decimal>();
        
        for (LibraryItem item : items) {
            Decimal basePrice = item.getPrice();
            Decimal calculatedPrice = this.calculate(basePrice, item);
            prices.put(item.getItemId(), calculatedPrice);
        }
        
        return prices;
    }
}
// AI Generated Code by Deloitte + Cursor (END)


# GI Products Platform - Quick Reference

A comprehensive Salesforce Experience Cloud platform for displaying and managing Geographical Indication (GI) tag products in India.

## Overview

This platform provides:
- **Product Directory**: Searchable, filterable catalog of GI products, handlooms, and foods
- **Seller Verification**: Profiles of verified sellers with ratings and badges
- **Interactive Maps**: Visual representation of product origins
- **Origin Stories**: Rich storytelling about products and their heritage
- **Buy/Connect**: Direct connection between buyers and sellers
- **News & Events**: Updates on fairs, exhibitions, and new GI registrations

## Architecture

### Standard Objects Used
- **Product2**: Stores GI product information
- **Contact**: Stores verified seller information
- **Lead**: Captures user registrations
- **Opportunity**: Tracks buyer-seller connections

### Custom Objects
- **GI_News_Event__c**: Stores news articles and event information

### Custom Fields

#### Product2 Fields
- `GI_Status__c` (Picklist): Registered, Pending, Not Registered
- `Product_Type__c` (Picklist): GI Tag Product, Handloom, Food, Handicraft
- `Origin_State__c` (Text): State of origin
- `Origin_City__c` (Text): City of origin
- `Origin_Story__c` (Long Text): Product origin story
- `GI_Registration_Number__c` (Text): Official GI registration number
- `Latitude__c` (Number): Geographic latitude
- `Longitude__c` (Number): Geographic longitude

#### Contact Fields
- `Verification_Status__c` (Picklist): Verified, Pending, Not Verified
- `Seller_Badge__c` (Picklist): Gold, Silver, Bronze, None
- `Seller_Rating__c` (Number): Seller rating (0-5)

#### Opportunity Fields
- `Product__c` (Lookup to Product2): Links opportunity to product

### Apex Classes

1. **GIProductController**: Product search, filtering, and retrieval
   - `searchProducts()`: Search and filter products
   - `getProductById()`: Get single product details
   - `getProductsByLocation()`: Get products for map display
   - `getOriginStates()`: Get unique states for filters

2. **GISellerController**: Seller management and retrieval
   - `getVerifiedSellers()`: Get list of verified sellers
   - `getSellerById()`: Get seller details
   - `getSellersByProduct()`: Get sellers for a specific product

3. **GIRegistrationController**: User registration and connections
   - `createRegistration()`: Create Lead from registration form
   - `createOpportunity()`: Create Opportunity for buy/connect

4. **GINewsEventController**: News and events management
   - `getNewsEvents()`: Get published news and events
   - `getNewsEventsByType()`: Filter by type

### Lightning Web Components

1. **giProductDirectory**: Main product catalog with search and filters
2. **giSellerDirectory**: Verified sellers directory
3. **giProductMap**: Interactive map showing product origins
4. **giProductStory**: Product origin stories
5. **giBuyConnect**: Buy/connect functionality
6. **giRegistration**: User registration form
7. **giNewsEvents**: News and events feed

## Quick Start

1. **Deploy Metadata**
   ```bash
   sfdx force:source:deploy -p force-app/main/default
   ```

2. **Enable Experience Cloud**
   - Setup → Digital Experiences → New Site

3. **Configure Guest User Profile**
   - Grant read access to Product2, Contact, GI_News_Event__c
   - Grant create access to Lead, Opportunity
   - Grant Apex class access

4. **Create Experience Cloud Pages**
   - Products page with `giProductDirectory`
   - Sellers page with `giSellerDirectory`
   - Map page with `giProductMap`
   - News & Events page with `giNewsEvents`
   - Registration page with `giRegistration`

5. **Populate Data**
   - Create Product2 records with custom fields
   - Create Contact records for sellers
   - Create GI_News_Event__c records
   - Link sellers to products via Opportunities

## Key Features

### Product Directory
- Real-time search across product names, descriptions, and stories
- Filter by Product Type, GI Status, and Origin State
- Pagination support
- Responsive grid layout

### Seller Verification
- Badge system (Gold, Silver, Bronze)
- Rating display
- Product associations
- Contact information

### Maps & Origins
- Interactive Salesforce Maps
- Marker clustering
- Product details on marker click
- Geographic filtering

### Storytelling
- Rich text origin stories
- Product heritage information
- GI registration details
- Location information

### Buy/Connect
- Direct seller contact
- Opportunity creation
- Inquiry management
- Seller selection

### News & Events
- Published content management
- Event date tracking
- Type categorization
- Chronological display

## Data Model Relationships

```
Product2 (Product)
    ↓ (Product__c lookup)
Opportunity
    ↓ (OpportunityContactRole)
Contact (Seller)
```

## Security Considerations

- Guest users have read-only access to public product data
- Only verified sellers are displayed
- Registration creates Leads (not Contacts)
- Opportunities track buyer interest
- Field-level security enforced on sensitive data

## Customization Points

1. **Styling**: Edit component CSS files
2. **Fields**: Add custom fields as needed
3. **Filters**: Extend filter options in components
4. **Validation**: Add validation rules on objects
5. **Workflows**: Create processes for lead/opportunity management
6. **Reports**: Build reports and dashboards

## Best Practices

1. **Data Quality**
   - Ensure all products have complete information
   - Verify seller information before marking as verified
   - Keep news/events up to date

2. **Performance**
   - Use pagination for large datasets
   - Cache frequently accessed data
   - Optimize SOQL queries

3. **User Experience**
   - Provide clear navigation
   - Use consistent styling
   - Include helpful error messages
   - Make forms user-friendly

4. **Maintenance**
   - Regularly update product information
   - Monitor seller verification status
   - Keep news/events current
   - Review and respond to inquiries

## Support & Documentation

- See `GI_PRODUCTS_SETUP_GUIDE.md` for detailed setup instructions
- Review component code comments for implementation details
- Check Salesforce Experience Cloud documentation

## Version History

- **v1.0**: Initial release with core functionality
  - Product directory with search and filters
  - Seller verification system
  - Interactive maps
  - Origin stories
  - Buy/connect functionality
  - News & events feed
  - User registration

---

**Platform**: Salesforce Experience Cloud  
**API Version**: 64.0  
**License**: Custom Development


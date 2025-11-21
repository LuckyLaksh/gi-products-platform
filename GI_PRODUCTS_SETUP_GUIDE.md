# GI Products Platform - Setup Guide

This guide will help you set up the GI (Geographical Indication) Products platform on Salesforce Experience Cloud.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Deployment](#deployment)
3. [Experience Cloud Setup](#experience-cloud-setup)
4. [Data Configuration](#data-configuration)
5. [Component Configuration](#component-configuration)
6. [Permissions & Sharing](#permissions--sharing)
7. [Testing](#testing)
8. [Customization](#customization)

## Prerequisites

- Salesforce org with Experience Cloud enabled
- System Administrator access
- API version 64.0 or higher
- Basic knowledge of Salesforce Experience Cloud

## Deployment

### 1. Deploy Metadata

Deploy all metadata to your Salesforce org using Salesforce CLI:

```bash
sfdx force:source:deploy -p force-app/main/default
```

Or use VS Code with Salesforce Extensions.

### 2. Verify Deployment

Check that all components are deployed:
- Custom fields on Product2, Contact, and Opportunity
- Custom object: GI_News_Event__c
- Apex classes (4 classes)
- Lightning Web Components (7 components)

## Experience Cloud Setup

### 1. Enable Experience Cloud

1. Navigate to **Setup** → **Digital Experiences** → **All Sites**
2. Click **New** → **Get Started**
3. Choose a template (e.g., **Customer Account Portal** or **Build Your Own**)
4. Enter site name: "GI Products Portal"
5. Click **Create**

### 2. Configure Site Settings

1. Go to **Workspaces** → **Administration** → **Settings**
2. Configure:
   - **Site URL**: Set your preferred URL
   - **Public Access**: Enable for public access
   - **Guest User Profile**: Assign appropriate profile

### 3. Create Navigation Menu

1. Go to **Workspaces** → **Builder**
2. Click **Navigation Menu**
3. Add menu items:
   - **Home** (default)
   - **Products** → Link to Products page
   - **Sellers** → Link to Sellers page
   - **Map** → Link to Map page
   - **News & Events** → Link to News & Events page
   - **Registration** → Link to Registration page
   - **About** → Link to About page (create custom content)

## Data Configuration

### 1. Product Data Setup

1. Navigate to **Products** tab
2. Create Product records with the following fields:
   - **Name**: Product name
   - **Description**: Product description
   - **Product Type**: Select from picklist (GI Tag Product, Handloom, Food, Handicraft)
   - **GI Status**: Select from picklist (Registered, Pending, Not Registered)
   - **Origin State**: State name
   - **Origin City**: City name
   - **Origin Story**: Detailed story about the product
   - **GI Registration Number**: Registration number (if applicable)
   - **Latitude** & **Longitude**: For map display
   - **IsActive**: Set to true

### 2. Seller (Contact) Setup

1. Navigate to **Contacts** tab
2. Create Contact records for sellers:
   - **Name**: Seller name
   - **Email**: Contact email
   - **Phone**: Contact phone
   - **Mailing Address**: Full address
   - **Verification Status**: Set to "Verified"
   - **Seller Badge**: Select badge level (Gold, Silver, Bronze)
   - **Seller Rating**: Enter rating (0-5)

3. Link sellers to products:
   - Create **Opportunity** records
   - Set **Product__c** field to link to Product2
   - Create **OpportunityContactRole** with Role = "Seller" and IsPrimary = true

### 3. News & Events Setup

1. Navigate to **GI News & Events** tab
2. Create records:
   - **Title**: News/Event title
   - **Type**: Select (News, Event, Exhibition, Fair)
   - **Description**: Detailed description
   - **Event Date**: Date of event (if applicable)
   - **Is Published**: Check to make visible on site

### 4. Lead Source Configuration

1. Navigate to **Setup** → **Object Manager** → **Lead** → **Fields & Relationships**
2. Verify **Lead Source** picklist includes "GI Products Website"
3. If not, add it to the picklist values

## Component Configuration

### 1. Create Experience Cloud Pages

#### Products Page
1. Go to **Workspaces** → **Builder**
2. Click **Pages** → **New**
3. Name: "Products"
4. Drag **giProductDirectory** component to the page
5. Save and activate

#### Sellers Page
1. Create new page: "Sellers"
2. Drag **giSellerDirectory** component
3. Save and activate

#### Map Page
1. Create new page: "Map"
2. Drag **giProductMap** component
3. Save and activate

#### News & Events Page
1. Create new page: "News & Events"
2. Drag **giNewsEvents** component
3. Save and activate

#### Registration Page
1. Create new page: "Registration"
2. Drag **giRegistration** component
3. Save and activate

### 2. Product Detail Page

1. Create a record page for Product2:
   - Go to **Pages** → **New** → **Record Page**
   - Select **Product2** object
   - Add components:
     - **giProductStory** (Origin Story)
     - **giBuyConnect** (Buy/Connect functionality)
   - Save and activate

## Permissions & Sharing

### 1. Guest User Profile

Configure guest user profile to allow:
- **Read** access to:
  - Product2 (with custom fields)
  - Contact (with custom fields)
  - GI_News_Event__c
- **Create** access to:
  - Lead
  - Opportunity
- **Apex Class Access**:
  - GIProductController
  - GISellerController
  - GIRegistrationController
  - GINewsEventController

### 2. Sharing Rules (if needed)

If you need to restrict certain data:
1. Go to **Setup** → **Sharing Settings**
2. Create sharing rules for Product2, Contact, and GI_News_Event__c
3. Configure public read access for guest users

### 3. Field-Level Security

Ensure guest users can see:
- All Product2 custom fields
- Contact: Name, Email, Phone, MailingCity, MailingState, Verification_Status__c, Seller_Badge__c, Seller_Rating__c
- GI_News_Event__c: All fields except internal fields

## Testing

### 1. Test Product Directory
- Search functionality
- Filter by Product Type, GI Status, Origin State
- Pagination
- Product detail navigation

### 2. Test Seller Directory
- View verified sellers
- Seller ratings and badges
- Contact information display

### 3. Test Map
- Map markers display
- Product location accuracy
- Marker click functionality

### 4. Test Registration
- Form submission
- Lead creation
- Validation messages

### 5. Test Buy/Connect
- Opportunity creation
- Seller selection
- Form submission

### 6. Test News & Events
- Display of published items
- Date formatting
- Navigation

## Customization

### 1. Styling

Customize component styling by editing CSS files:
- `giProductDirectory/giProductDirectory.css`
- `giSellerDirectory/giSellerDirectory.css`
- `giNewsEvents/giNewsEvents.css`
- etc.

### 2. Additional Fields

Add more custom fields as needed:
- Product: Add fields for images, videos, certifications
- Contact: Add fields for social media, website, certifications
- News & Events: Add fields for images, location, registration links

### 3. Enhanced Features

Consider adding:
- Product image galleries
- Video embeds for origin stories
- Social sharing functionality
- Email notifications
- Advanced search with filters
- Product comparison
- Wishlist functionality
- Reviews and ratings

### 4. Integration Options

- **E-commerce**: Integrate with external e-commerce platforms
- **Payment Gateway**: Add payment processing
- **Government APIs**: Connect to official GI registration databases
- **Social Media**: Add social media feeds
- **Analytics**: Integrate Google Analytics or Salesforce Analytics

## Troubleshooting

### Common Issues

1. **Components not visible**
   - Check guest user profile permissions
   - Verify field-level security
   - Check component exposure settings

2. **Map not displaying**
   - Verify Latitude and Longitude fields are populated
   - Check map component permissions

3. **Opportunity creation fails**
   - Ensure default Account exists or is created
   - Check Opportunity validation rules
   - Verify required fields are populated

4. **Sellers not showing**
   - Verify Contact Verification_Status__c = "Verified"
   - Check OpportunityContactRole relationships
   - Verify sharing rules

## Support

For issues or questions:
1. Check Salesforce Trailblazer Community
2. Review component code comments
3. Check Salesforce documentation for Experience Cloud

## Next Steps

1. Populate sample data
2. Customize branding and styling
3. Configure email templates for notifications
4. Set up workflows/processes for lead management
5. Create reports and dashboards
6. Set up analytics tracking

---

**Version**: 1.0  
**Last Updated**: 2024  
**Author**: Salesforce Development Team


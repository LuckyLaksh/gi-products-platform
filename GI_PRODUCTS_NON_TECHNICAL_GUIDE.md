# GI Products Platform - Simple Explanation Guide

**For Non-Technical Users**

This guide explains what has been built for your GI Products website in simple, easy-to-understand language.

---

## What Is This Platform?

Imagine you want to create a website where people can:
- Browse and search for GI tag products (like Darjeeling Tea, Banarasi Silk, etc.)
- Find verified sellers who sell these authentic products
- See where these products come from on a map
- Read stories about the products' heritage
- Contact sellers to buy products
- Stay updated with news and events about GI products

This platform does all of that! It's built on Salesforce Experience Cloud, which is like having a website that's connected to a powerful database.

---

## What Has Been Created? (In Simple Terms)

Think of this platform like building a house. Here's what each "room" does:

### 1. **The Product Catalog (Product Directory)**
**What it is:** Like a searchable online store catalog

**What it does:**
- Shows all your GI products in a nice grid layout
- Lets visitors search for products by name or description
- Allows filtering by:
  - Type of product (GI Tag Product, Handloom, Food, Handicraft)
  - GI Status (Registered, Pending, Not Registered)
  - Which state the product comes from
- Shows product information like name, description, origin location
- Has page numbers so visitors can browse through many products

**Example:** A visitor types "tea" and filters by "West Bengal" to find Darjeeling Tea products.

---

### 2. **The Seller Directory**
**What it is:** A list of verified, trustworthy sellers

**What it does:**
- Shows only sellers who have been verified (checked and approved)
- Displays seller badges (Gold, Silver, Bronze) to show quality
- Shows seller ratings (like 4.5 out of 5 stars)
- Lists what products each seller offers
- Shows contact information (email, phone, location)

**Why it's important:** Visitors know they're buying from genuine, verified sellers, not fake ones.

**Example:** A visitor sees "Rajesh Handlooms" with a Gold badge and 4.8 rating, selling Banarasi Silk.

---

### 3. **The Map View**
**What it is:** An interactive map showing where products come from

**What it does:**
- Shows a map of India with markers (pins) for each product location
- When you click a marker, it shows product details
- Helps visitors understand the geographic origin of products
- Makes it easy to see which products come from which regions

**Example:** A visitor clicks on a marker in Varanasi and sees "Banarasi Silk - GI Registered Product from Varanasi, Uttar Pradesh."

---

### 4. **The Origin Stories**
**What it is:** A storytelling section about each product's heritage

**What it does:**
- Shows the history and cultural significance of each product
- Explains why the product is special and unique to that region
- Displays the official GI registration number
- Shows the exact origin location

**Why it's important:** People love to know the story behind products - it makes them more valuable and interesting.

**Example:** A visitor reads about how Pashmina shawls have been made in Kashmir for centuries using traditional techniques.

---

### 5. **The Buy/Connect Feature**
**What it is:** A way for visitors to contact sellers and express interest in buying

**What it does:**
- Shows all verified sellers who sell a particular product
- Lets visitors select a seller they want to contact
- Creates an inquiry form where visitors can:
  - Enter their name
  - Specify how much they're interested in buying
  - Set an expected date
- Sends this information to the seller (via Salesforce)

**Example:** A visitor finds a product they like, selects a seller, fills out a form saying "I'm interested in buying 10 units by next month," and the seller gets notified.

---

### 6. **The Registration Form**
**What it is:** A sign-up form for visitors who want to stay updated

**What it does:**
- Collects visitor information (name, email, phone)
- Lets visitors specify their interests
- Saves this information so you can:
  - Send them updates about new products
  - Notify them about events and exhibitions
  - Follow up with them later

**Example:** A visitor fills out the form saying they're interested in handlooms, and later you can email them about a new handloom exhibition.

---

### 7. **The News & Events Section**
**What it is:** A feed showing updates, news, and upcoming events

**What it does:**
- Displays news articles about GI products
- Shows upcoming events, fairs, and exhibitions
- Categorizes content (News, Event, Exhibition, Fair)
- Shows dates for events
- Only shows published content (you control what's visible)

**Example:** Visitors see "New GI Registration: Mithila Paintings from Bihar" or "Upcoming: GI Products Fair in Delhi - March 15-20."

---

## How Does It All Work Together?

Here's a simple flow of how a visitor uses your website:

1. **Visitor arrives** → Sees the homepage with navigation menu
2. **Browses products** → Uses the Product Directory to search and filter
3. **Finds interesting product** → Clicks to see details
4. **Reads the story** → Learns about the product's heritage
5. **Checks the map** → Sees where it comes from
6. **Finds sellers** → Views verified sellers who offer this product
7. **Contacts seller** → Uses Buy/Connect to send an inquiry
8. **Stays updated** → Registers to receive news and event updates

---

## What Information Is Stored? (The Database)

Think of the database like a filing cabinet with different folders:

### **Products Folder**
Each product has:
- Name (e.g., "Darjeeling Tea")
- Description
- Type (GI Tag Product, Handloom, Food, etc.)
- GI Status (Registered, Pending, etc.)
- Origin State and City
- The story behind the product
- GI Registration Number
- Location (latitude/longitude for the map)

### **Sellers Folder**
Each seller has:
- Name and contact information
- Verification status (Verified, Pending, Not Verified)
- Badge level (Gold, Silver, Bronze)
- Rating (0-5 stars)
- Which products they sell

### **News & Events Folder**
Each news item has:
- Title
- Type (News, Event, Exhibition, Fair)
- Description
- Event date (if applicable)
- Published status (visible or hidden)

### **Leads Folder** (From Registration)
When someone registers, it creates a "Lead" with:
- Their name and contact information
- Their interests
- When they registered

### **Opportunities Folder** (From Buy/Connect)
When someone wants to buy, it creates an "Opportunity" with:
- Which product they're interested in
- Which seller they want to contact
- How much they want to buy
- Expected date

---

## Step-by-Step: What Was Built

### Step 1: Created Custom Fields (Data Storage)
**What this means:** Added special boxes to store information that wasn't there before.

**For Products:**
- Added a box to mark GI Status (Registered/Pending/Not Registered)
- Added boxes for Origin State and City
- Added a big text box for the Origin Story
- Added boxes for location (latitude/longitude) for the map
- Added a box for the GI Registration Number

**For Sellers (Contacts):**
- Added a box to mark if they're Verified
- Added a box for their Badge (Gold/Silver/Bronze)
- Added a box for their Rating

**Why this matters:** Without these boxes, you couldn't store and display this special information.

---

### Step 2: Created a News & Events Object
**What this means:** Created a new "folder" in the database specifically for news and events.

**What it stores:**
- News articles
- Event announcements
- Exhibition information
- Fair details

**Why this matters:** You need a dedicated place to manage all your news and events content.

---

### Step 3: Created Apex Classes (The Brain)
**What this means:** Created "smart helpers" that know how to find and organize information.

**GIProductController (Product Helper):**
- Knows how to search for products
- Knows how to filter products
- Knows how to get products for the map
- Knows how to get a list of all states

**GISellerController (Seller Helper):**
- Knows how to find verified sellers
- Knows how to find sellers for a specific product
- Knows how to get seller details

**GIRegistrationController (Registration Helper):**
- Knows how to save registration information
- Knows how to create a connection between buyer and seller

**GINewsEventController (News Helper):**
- Knows how to get published news and events
- Knows how to filter by type

**Why this matters:** These helpers do the "thinking" so the website knows what information to show.

---

### Step 4: Created Lightning Web Components (The Face)
**What this means:** Created the visual parts that visitors see and interact with.

**giProductDirectory:**
- The search box
- The filter dropdowns
- The product cards in a grid
- The page numbers at the bottom

**giSellerDirectory:**
- The list of sellers
- The badges and ratings
- The seller cards

**giProductMap:**
- The map itself
- The markers (pins) on the map
- The popup when you click a marker

**giProductStory:**
- The story text
- The origin location
- The GI registration number

**giBuyConnect:**
- The seller selection dropdown
- The inquiry form
- The submit button

**giRegistration:**
- The registration form fields
- The submit button

**giNewsEvents:**
- The list of news items
- The event dates
- The type badges

**Why this matters:** These are what visitors actually see and click on. They make the website look good and work smoothly.

---

## How to Use This Platform (For Administrators)

### Adding a New Product

1. Go to the Products section in Salesforce
2. Click "New"
3. Fill in:
   - Product name
   - Description
   - Select Product Type (GI Tag Product, Handloom, etc.)
   - Select GI Status
   - Enter Origin State and City
   - Write the Origin Story
   - Enter GI Registration Number (if applicable)
   - Enter Latitude and Longitude (for map)
4. Make sure "Is Active" is checked
5. Save

**Result:** The product appears on your website!

---

### Adding a New Seller

1. Go to Contacts in Salesforce
2. Click "New"
3. Fill in:
   - Name
   - Email and Phone
   - Address
   - Set Verification Status to "Verified"
   - Select Seller Badge (if applicable)
   - Enter Seller Rating (if applicable)
4. Save
5. Create an Opportunity linking this seller to products they sell

**Result:** The seller appears in the Seller Directory!

---

### Adding News or an Event

1. Go to GI News & Events in Salesforce
2. Click "New"
3. Fill in:
   - Title
   - Select Type (News, Event, Exhibition, Fair)
   - Write Description
   - Enter Event Date (if it's an event)
   - Check "Is Published" to make it visible
4. Save

**Result:** It appears on the News & Events page!

---

### Managing Inquiries (From Buy/Connect)

1. Go to Opportunities in Salesforce
2. You'll see all inquiries from visitors
3. Each opportunity shows:
   - Which product they're interested in
   - Which seller they selected
   - How much they want to buy
   - Expected date
4. You can contact the seller or the buyer to follow up

**Result:** You can track and manage all buyer interest!

---

### Managing Registrations

1. Go to Leads in Salesforce
2. You'll see all people who registered
3. Each lead shows:
   - Their contact information
   - Their interests
   - When they registered
4. You can:
   - Send them emails about new products
   - Invite them to events
   - Follow up with them

**Result:** You have a list of interested visitors to market to!

---

## What Makes This Special?

### 1. **Everything Is Connected**
- Products are linked to sellers
- Sellers are linked to opportunities
- Everything works together automatically

### 2. **Only Verified Sellers Show**
- Visitors only see sellers you've approved
- This builds trust and prevents fraud

### 3. **Rich Information**
- Not just product names, but stories, origins, and heritage
- Makes products more valuable and interesting

### 4. **Easy to Manage**
- Add products, sellers, and news through simple forms
- No coding required for day-to-day management

### 5. **Professional Appearance**
- Modern, clean design
- Works on computers, tablets, and phones
- Fast and responsive

---

## Common Questions

### Q: Do I need to know coding to use this?
**A:** No! Once it's set up, you just fill out forms to add products, sellers, and news. It's like using any website form.

### Q: Can I change how it looks?
**A:** Yes, but you might need a developer for major changes. Small changes like colors and text can be done through Salesforce.

### Q: How do visitors find my website?
**A:** You'll get a URL (web address) when you create the Experience Cloud site. Share this URL with visitors.

### Q: Can I add photos to products?
**A:** Yes! Salesforce Products support images. You can add product photos that will display on the website.

### Q: What if I want to add more features?
**A:** The platform is built to be expandable. You can add more fields, more components, or integrate with other systems.

### Q: How do I know if someone wants to buy?
**A:** When someone uses the Buy/Connect feature, it creates an Opportunity in Salesforce. You'll see it in your Opportunities list and can follow up.

### Q: Can I see statistics about visitors?
**A:** Yes! Salesforce provides analytics. You can see how many people visit, which products are popular, etc.

---

## Summary

**What you have:**
- A complete website platform for GI products
- A way to showcase products with rich information
- A seller verification system
- A way for visitors to contact sellers
- A news and events section
- A registration system

**What you can do:**
- Add products easily
- Manage verified sellers
- Publish news and events
- Track visitor interest
- Connect buyers with sellers

**What visitors can do:**
- Search and browse products
- Read origin stories
- See products on a map
- Find verified sellers
- Contact sellers
- Register for updates
- Read news and events

---

## Next Steps

1. **Get it set up** (follow the technical setup guide)
2. **Add your first products** (start with 5-10 products)
3. **Add verified sellers** (start with 3-5 sellers)
4. **Publish some news** (add 2-3 news items)
5. **Test everything** (make sure it all works)
6. **Launch!** (share the website URL)

---

**Remember:** This platform is like a digital storefront for GI products. The more products and sellers you add, the more valuable it becomes for visitors!

---

**Need Help?**
- Refer to the technical setup guide for installation
- Contact your Salesforce administrator
- Check Salesforce documentation for Experience Cloud

---

*This guide is written in simple language to help non-technical users understand what has been built. For technical setup instructions, see "GI_PRODUCTS_SETUP_GUIDE.md".*


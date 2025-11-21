public with sharing class GIRegistrationController {
    
    /**
     * Create a Lead for user registration
     */
    @AuraEnabled
    public static Id createRegistration(
        String firstName,
        String lastName,
        String email,
        String phone,
        String company,
        String comments
    ) {
        try {
            Lead leadRecord = new Lead(
                FirstName = firstName,
                LastName = lastName,
                Email = email,
                Phone = phone,
                Company = String.isNotBlank(company) ? company : 'Individual',
                Description = comments,
                LeadSource = 'GI Products Website'
            );
            
            insert leadRecord;
            return leadRecord.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Error creating registration: ' + e.getMessage());
        }
    }
    
    /**
     * Create an Opportunity for buy/connect functionality
     * Note: Opportunity doesn't have direct Product2Id field.
     * Products are linked via OpportunityLineItem after Pricebook setup.
     * For now, we'll store product reference in Description or use a custom field.
     */
    @AuraEnabled
    public static Id createOpportunity(
        String productId,
        String contactId,
        String opportunityName,
        Decimal amount,
        Date closeDate
    ) {
        try {
            // Get Contact's Account if available, otherwise create/get default account
            Id accountId = null;
            if (String.isNotBlank(contactId)) {
                Contact con = [SELECT AccountId FROM Contact WHERE Id = :contactId LIMIT 1];
                if (con.AccountId != null) {
                    accountId = con.AccountId;
                }
            }
            
            // If no account, use a default account or create one
            // For now, we'll require an account - this should be configured in your org
            if (accountId == null) {
                // Try to find a default account or create one
                List<Account> defaultAccounts = [SELECT Id FROM Account WHERE Name = 'GI Products Customers' LIMIT 1];
                if (!defaultAccounts.isEmpty()) {
                    accountId = defaultAccounts[0].Id;
                } else {
                    // Create default account
                    Account defaultAccount = new Account(Name = 'GI Products Customers');
                    insert defaultAccount;
                    accountId = defaultAccount.Id;
                }
            }
            
            Opportunity opp = new Opportunity(
                Name = opportunityName,
                AccountId = accountId,
                Product__c = productId,
                Amount = amount,
                CloseDate = closeDate != null ? closeDate : Date.today().addDays(30),
                StageName = 'Prospecting',
                Description = 'Product Interest Inquiry'
            );
            
            insert opp;
            
            // Create OpportunityContactRole
            if (String.isNotBlank(contactId)) {
                OpportunityContactRole ocr = new OpportunityContactRole(
                    OpportunityId = opp.Id,
                    ContactId = contactId,
                    IsPrimary = true,
                    Role = 'Seller'
                );
                insert ocr;
            }
            
            // Note: To link Product2, you'll need to:
            // 1. Create a PricebookEntry for the Product2
            // 2. Create an OpportunityLineItem linking to that PricebookEntry
            // This requires Pricebook setup which is org-specific
            
            return opp.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Error creating opportunity: ' + e.getMessage());
        }
    }
}


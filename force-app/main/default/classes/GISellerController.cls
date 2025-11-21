public with sharing class GISellerController {
    
    /**
     * Get verified sellers with their products
     * @param limitSize Maximum number of records to return
     * @param offset Offset for pagination
     * @return List of Contact records with related products
     */
    @AuraEnabled(cacheable=true)
    public static List<Contact> getVerifiedSellers(Integer limitSize, Integer offset) {
        return [
            SELECT Id, Name, Email, Phone, MailingCity, MailingState,
                   Verification_Status__c, Seller_Badge__c, Seller_Rating__c,
                   (SELECT Id, Name, Product2Id, Product2.Name, Product2.Product_Type__c,
                           Product2.GI_Status__c, Product2.Origin_State__c
                    FROM OpportunityContactRoles
                    WHERE IsPrimary = true
                    LIMIT 5)
            FROM Contact
            WHERE Verification_Status__c = 'Verified'
            ORDER BY Seller_Rating__c DESC NULLS LAST, Name
            LIMIT :limitSize
            OFFSET :offset
        ];
    }
    
    /**
     * Get seller details by ID
     */
    @AuraEnabled(cacheable=true)
    public static Contact getSellerById(Id sellerId) {
        return [
            SELECT Id, Name, Email, Phone, MailingStreet, MailingCity,
                   MailingState, MailingPostalCode, MailingCountry,
                   Verification_Status__c, Seller_Badge__c, Seller_Rating__c,
                   (SELECT Id, Name, Product2Id, Product2.Name, Product2.Description,
                           Product2.Product_Type__c, Product2.GI_Status__c,
                           Product2.Origin_State__c, Product2.Origin_City__c
                    FROM OpportunityContactRoles
                    WHERE IsPrimary = true)
            FROM Contact
            WHERE Id = :sellerId
            LIMIT 1
        ];
    }
    
    /**
     * Get sellers by product
     */
    @AuraEnabled(cacheable=true)
    public static List<Contact> getSellersByProduct(Id productId) {
        Set<Id> contactIds = new Set<Id>();
        
        // Find opportunities linked to this product via custom Product__c field
        for (OpportunityContactRole ocr : [
            SELECT ContactId
            FROM OpportunityContactRole
            WHERE Opportunity.Product__c = :productId
            AND IsPrimary = true
        ]) {
            contactIds.add(ocr.ContactId);
        }
        
        // If no matches found, return all verified sellers as fallback
        if (contactIds.isEmpty()) {
            return [
                SELECT Id, Name, Email, Phone, MailingCity, MailingState,
                       Verification_Status__c, Seller_Badge__c, Seller_Rating__c
                FROM Contact
                WHERE Verification_Status__c = 'Verified'
                ORDER BY Seller_Rating__c DESC NULLS LAST
                LIMIT 10
            ];
        }
        
        return [
            SELECT Id, Name, Email, Phone, MailingCity, MailingState,
                   Verification_Status__c, Seller_Badge__c, Seller_Rating__c
            FROM Contact
            WHERE Id IN :contactIds
            AND Verification_Status__c = 'Verified'
            ORDER BY Seller_Rating__c DESC NULLS LAST
        ];
    }
    
    /**
     * Get seller count
     */
    @AuraEnabled(cacheable=true)
    public static Integer getSellerCount() {
        return [
            SELECT COUNT()
            FROM Contact
            WHERE Verification_Status__c = 'Verified'
        ];
    }
}


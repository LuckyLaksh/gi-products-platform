public with sharing class GIProductController {
    
    /**
     * Search and filter GI products
     * @param searchTerm Search term for product name or description
     * @param productType Filter by product type
     * @param giStatus Filter by GI status
     * @param originState Filter by origin state
     * @param limitSize Maximum number of records to return
     * @param offset Offset for pagination
     * @return List of Product2 records with related information
     */
    @AuraEnabled(cacheable=true)
    public static List<Product2> searchProducts(
        String searchTerm,
        String productType,
        String giStatus,
        String originState,
        Integer limitSize,
        Integer offset
    ) {
        String query = 'SELECT Id, Name, Description, ProductCode, GI_Status__c, ' +
                      'Origin_State__c, Origin_City__c, Product_Type__c, ' +
                      'Origin_Story__c, GI_Registration_Number__c, ' +
                      'Latitude__c, Longitude__c, IsActive ' +
                      'FROM Product2 ' +
                      'WHERE IsActive = true';
        
        List<String> conditions = new List<String>();
        
        if (String.isNotBlank(searchTerm)) {
            String searchPattern = '%' + String.escapeSingleQuotes(searchTerm) + '%';
            conditions.add('(Name LIKE :searchPattern OR Description LIKE :searchPattern OR Origin_Story__c LIKE :searchPattern)');
        }
        
        if (String.isNotBlank(productType)) {
            conditions.add('Product_Type__c = :productType');
        }
        
        if (String.isNotBlank(giStatus)) {
            conditions.add('GI_Status__c = :giStatus');
        }
        
        if (String.isNotBlank(originState)) {
            conditions.add('Origin_State__c = :originState');
        }
        
        if (!conditions.isEmpty()) {
            query += ' AND ' + String.join(conditions, ' AND ');
        }
        
        query += ' ORDER BY Name LIMIT :limitSize OFFSET :offset';
        
        return Database.query(query);
    }
    
    /**
     * Get product count for pagination
     */
    @AuraEnabled(cacheable=true)
    public static Integer getProductCount(
        String searchTerm,
        String productType,
        String giStatus,
        String originState
    ) {
        String query = 'SELECT COUNT() FROM Product2 WHERE IsActive = true';
        
        List<String> conditions = new List<String>();
        
        if (String.isNotBlank(searchTerm)) {
            String searchPattern = '%' + String.escapeSingleQuotes(searchTerm) + '%';
            conditions.add('(Name LIKE :searchPattern OR Description LIKE :searchPattern OR Origin_Story__c LIKE :searchPattern)');
        }
        
        if (String.isNotBlank(productType)) {
            conditions.add('Product_Type__c = :productType');
        }
        
        if (String.isNotBlank(giStatus)) {
            conditions.add('GI_Status__c = :giStatus');
        }
        
        if (String.isNotBlank(originState)) {
            conditions.add('Origin_State__c = :originState');
        }
        
        if (!conditions.isEmpty()) {
            query += ' AND ' + String.join(conditions, ' AND ');
        }
        
        return Database.countQuery(query);
    }
    
    /**
     * Get product details by ID
     */
    @AuraEnabled(cacheable=true)
    public static Product2 getProductById(Id productId) {
        return [
            SELECT Id, Name, Description, ProductCode, GI_Status__c,
                   Origin_State__c, Origin_City__c, Product_Type__c,
                   Origin_Story__c, GI_Registration_Number__c,
                   Latitude__c, Longitude__c, IsActive
            FROM Product2
            WHERE Id = :productId
            LIMIT 1
        ];
    }
    
    /**
     * Get all unique states for filter dropdown
     */
    @AuraEnabled(cacheable=true)
    public static List<String> getOriginStates() {
        List<String> states = new List<String>();
        List<AggregateResult> results = [
            SELECT Origin_State__c
            FROM Product2
            WHERE IsActive = true AND Origin_State__c != null
            GROUP BY Origin_State__c
            ORDER BY Origin_State__c
        ];
        
        for (AggregateResult ar : results) {
            states.add((String)ar.get('Origin_State__c'));
        }
        
        return states;
    }
    
    /**
     * Get products by location (for map view)
     */
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductsByLocation() {
        return [
            SELECT Id, Name, Origin_State__c, Origin_City__c,
                   Latitude__c, Longitude__c, Product_Type__c, GI_Status__c
            FROM Product2
            WHERE IsActive = true
            AND Latitude__c != null
            AND Longitude__c != null
            ORDER BY Name
        ];
    }
}


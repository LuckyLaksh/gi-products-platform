public with sharing class GINewsEventController {
    
    /**
     * Get published news and events
     */
    @AuraEnabled(cacheable=true)
    public static List<GI_News_Event__c> getNewsEvents(Integer limitSize) {
        return [
            SELECT Id, Name, Title__c, Type__c, Description__c, 
                   Event_Date__c, CreatedDate
            FROM GI_News_Event__c
            WHERE Is_Published__c = true
            ORDER BY Event_Date__c DESC NULLS LAST, CreatedDate DESC
            LIMIT :limitSize
        ];
    }
    
    /**
     * Get news and events by type
     */
    @AuraEnabled(cacheable=true)
    public static List<GI_News_Event__c> getNewsEventsByType(String eventType, Integer limitSize) {
        return [
            SELECT Id, Name, Title__c, Type__c, Description__c, 
                   Event_Date__c, CreatedDate
            FROM GI_News_Event__c
            WHERE Is_Published__c = true
            AND Type__c = :eventType
            ORDER BY Event_Date__c DESC NULLS LAST, CreatedDate DESC
            LIMIT :limitSize
        ];
    }
}


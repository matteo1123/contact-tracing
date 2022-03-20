public with sharing class CTPeopleTracingController {

    public static List<People_Tracing__c> getTraces(String personId) {
        return [SELECT Id, Contact_Date__c, Person_1__c, Person_1__r.Health_Status__c, Person_1__r.Token__c
                FROM People_Tracing__c 
                WHERE Person_1__c = :personId
                    OR Person_2__c = :personId
                    ORDER BY Contact_Date__c DESC];
    }

    public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> newPeopleTraces) {
        Set<Id> recordIds = new Set<Id>();
        for(People_Tracing__c trace : newPeopleTraces) {
            recordIds.add(trace.person_1__c);
            recordIds.add(trace.Person_2__c);
        }

        List<People_Tracing__c> duplicates = new List<People_Tracing__c>();

        Map<Id, Set<Id>> mapOfExistingRecords = new Map<Id, Set<Id>>();
        List<People_Tracing__c> existingRecords = [SELECT Id, Person_1__c, Person_2__c 
                                                    FROM People_Tracing__c
                                                    WHERE Person_1__c IN :recordIds
                                                        OR Person_2__c IN :recordIds];

        if (existingRecords != null && existingRecords.size() > 0) {
            for(People_Tracing__c trace : existingRecords) {
                if (mapOfExistingRecords.containsKey(trace.person_1__c)) {
                    mapOfExistingRecords.put(trace.person_1__c, new Set<Id>());
                }
                mapOfExistingRecords.get(trace.person_1__c).add(trace.Person_2__c);
            }
            for(People_Tracing__c trace : newPeopleTraces) {
                if(
                    (mapOfExistingRecords.containsKey(trace.person_1__c) && mapOfExistingRecords.get(trace.person_1__c).contains(trace.Person_2__c))
                    ||
                    (mapOfExistingRecords.containsKey(trace.person_2__c) && mapOfExistingRecords.get(trace.person_2__c).contains(trace.Person_1__c))
                ) {
                    duplicates.add(trace);
                }
            }
        }
        return duplicates;
    }
}
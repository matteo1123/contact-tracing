public with sharing class getAccounts {
    @AuraEnabled
    public static List<Account> accountList() {
        return [SELECT Id, Name FROM Account WHERE Name like 'New Account%'];
    }
}
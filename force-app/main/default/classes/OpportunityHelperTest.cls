@isTest
private class OpportunityHelperTest {

    @TestSetup
    static void makeData(){
        insert DataFactory.createAccounts(4);
    }

    @isTest
    static void testGreenOpportunityUpdate(){
		Oportunity_Revenue_Range__mdt range = Oportunity_Revenue_Range__mdt.getInstance('Green');
        
        Account acct = [
            SELECT Id, AnnualRevenue 
            FROM Account
			WHERE AnnualRevenue >= :range.Lower_Limit__c
        ];
           
        Opportunity opp = DataFactory.createOpportunities(1, new Account[]{acct})[0];
		insert opp;
        
        Opportunity insertedOpp = [SELECT Priority__c FROM Opportunity WHERE Id=:opp.Id];
        
        System.assertEquals('Green', insertedOpp.Priority__c);
    }

    @isTest
    static void testYellowOpportunityUpdate(){
        Oportunity_Revenue_Range__mdt range = Oportunity_Revenue_Range__mdt.getInstance('Yellow');
        
        Account acct = [
            SELECT Id, AnnualRevenue 
            FROM Account
			WHERE AnnualRevenue <= :range.Upper_Limit__c AND AnnualRevenue >= :range.Lower_Limit__c 
        ];
           
        Opportunity opp = DataFactory.createOpportunities(1, new Account[]{acct})[0];
		insert opp;
        
        Opportunity insertedOpp = [SELECT Priority__c FROM Opportunity WHERE Id=:opp.Id];
        
        System.assertEquals('Yellow', insertedOpp.Priority__c);
    }

    @isTest
    static void testRedOpportunityUpdate(){
        Oportunity_Revenue_Range__mdt range = Oportunity_Revenue_Range__mdt.getInstance('Red');
        
        Account acct = [
            SELECT Id, AnnualRevenue 
            FROM Account
			WHERE AnnualRevenue <= :range.Upper_Limit__c AND AnnualRevenue >= :range.Lower_Limit__c 
        ];
           
        Opportunity opp = DataFactory.createOpportunities(1, new Account[]{acct})[0];
		insert opp;
        
        Opportunity insertedOpp = [SELECT Priority__c FROM Opportunity WHERE Id=:opp.Id];
        
        System.assertEquals('Red', insertedOpp.Priority__c);
    }
    
    @isTest
    static void testOrangeOpportunityUpdate(){
        Oportunity_Revenue_Range__mdt range = Oportunity_Revenue_Range__mdt.getInstance('Orange');
        
        Account acct = [
            SELECT Id, AnnualRevenue 
            FROM Account
			WHERE AnnualRevenue = null
        ];
           
        Opportunity opp = DataFactory.createOpportunities(1, new Account[]{acct})[0];
		insert opp;
        
        Opportunity insertedOpp = [SELECT Priority__c FROM Opportunity WHERE Id=:opp.Id];
        
        System.assertEquals('Orange', insertedOpp.Priority__c);
    }

}
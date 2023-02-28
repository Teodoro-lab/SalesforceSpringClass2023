@isTest
private class AccountHelperTest {

    @testSetup
    static void makeDate(){
        DataFactory.createData(4);
    }
    
    @isTest
    static void checkOppCreation(){
        Opportunity[] opps = [
          SELECT Id
          FROM Opportunity 
        ];
        
        Integer beforeInsertOpps = opps.size();
        
        Account acct = new Account(Name='TestAccountForOpp');
        insert acct;
        
        opps = [
          SELECT Id
          FROM Opportunity 
        ];
        
        System.assertEquals(beforeInsertOpps+1,opps.size());
    }
    
    
    @isTest
    static void testOppUpdateOnAnnualRevChange(){
		Oportunity_Revenue_Range__mdt range = Oportunity_Revenue_Range__mdt.getInstance('Green');
        
        Account acctOrange = [
            SELECT Id, AnnualRevenue 
            FROM Account
			WHERE AnnualRevenue = null
        ];
        
        acctOrange.AnnualRevenue = range.Lower_Limit__c + 1;
        update acctOrange;
                
        Opportunity opp = [
            SELECT Priority__c
            FROM Opportunity
            WHERE AccountId=:acctOrange.Id
            LIMIT 1
        ];
        
        System.assertEquals(range.Color__c, opp.Priority__c);
    }
    
}
@isTest
private class OpportunityHelperTest {

    @TestSetup
    static void makeData(){
        Date d = Date.newInstance(2023, 1, 1);
        Opportunity opp = new Opportunity(Name='TestOpp', StageName='Closed Won', CloseDate=d);
        insert opp;
    }

    @isTest
    static void testInsertInTrigger(){
        Date d = Date.newInstance(2023, 1, 1);
        Opportunity opp = new Opportunity(Name='TestOpp', StageName='Closed Won', CloseDate=d);
        insert opp;
        System.assertEquals(2, [ SELECT Amount FROM Opportunity ].size());
    }

    @isTest
    static void testGreenOpportunityUpdate(){
        Oportunity_Revenue_Range__mdt range = Oportunity_Revenue_Range__mdt.getInstance('Green');
        Opportunity opp = [ SELECT Amount FROM Opportunity ];
        opp.Amount = range.Lower_Limit__c + 1;
        update opp;
        opp = [ SELECT Amount, Priority__c FROM Opportunity ];
        System.assertEquals('Green', opp.Priority__c);
    }

    @isTest
    static void testYellowOpportunityUpdate(){
        Oportunity_Revenue_Range__mdt range = Oportunity_Revenue_Range__mdt.getInstance('Yellow');
        Opportunity opp = [ SELECT Amount FROM Opportunity ];
        opp.Amount = range.Lower_Limit__c + 1;
        update opp;
        opp = [ SELECT Amount, Priority__c FROM Opportunity ];
        System.assertEquals('Yellow', opp.Priority__c);
    }

    @isTest
    static void testRedOpportunityUpdate(){
        Oportunity_Revenue_Range__mdt range = Oportunity_Revenue_Range__mdt.getInstance('Red');
        Opportunity opp = [ SELECT Amount FROM Opportunity ];
        opp.Amount = range.Lower_Limit__c + 1;
        update opp;
        opp = [ SELECT Amount, Priority__c FROM Opportunity ];
        System.assertEquals('Red', opp.Priority__c);
    }

}
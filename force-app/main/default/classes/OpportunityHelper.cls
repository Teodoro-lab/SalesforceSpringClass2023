public with sharing class OpportunityHelper {
    
    public void assignOppPriority(Opportunity opp){
		List<Oportunity_Revenue_Range__mdt> ranges = Oportunity_Revenue_Range__mdt.getAll().values();
		
        for (Oportunity_Revenue_Range__mdt range : ranges) {
            if (range.Label == 'Green' && opp.Account.AnnualRevenue >= range.Lower_Limit__c){
                    opp.Priority__c = range.MasterLabel;
            } else if (range.Label == 'Orange' && opp.Account.AnnualRevenue == null){
                    opp.Priority__c = range.MasterLabel;
            } else if (opp.Account.AnnualRevenue >= range.Lower_Limit__c && opp.Account.AnnualRevenue <= range.Upper_Limit__c) {
                opp.Priority__c = range.MasterLabel;
            }
		}
    }
    
    public void insertOpportunitiesPriorities(list<Opportunity> opps){ 
        Id[] acctsIds = new Id[]{};
        for(Opportunity opp: opps){
            if (opp.AccountId != null){
            	acctsIds.add(opp.AccountId);    
            }
        }
        
       	Map<Id, Account> accts = new Map<Id, Account>([
            SELECT Id, AnnualRevenue
            FROM Account
            WHERE Id IN :acctsIds
        ]);
                
        for (Opportunity opp: opps){
            opp.Account = accts.get(opp.AccountId);
            assignOppPriority(opp);
        }
    }
    
    public void updateOpportunitiesPriorities(list<Opportunity> opps){        
        for (Opportunity opp: opps){
            assignOppPriority(opp);
        }
    }
}
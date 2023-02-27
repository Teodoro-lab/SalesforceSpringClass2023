public with sharing class OpportunityHelper {
    public OpportunityHelper() {

    }

    public void assignOpportunityImportance(list<Opportunity> opps){
        List<Oportunity_Revenue_Range__mdt> ranges = Oportunity_Revenue_Range__mdt.getAll().values();
        
        for (Opportunity opp: opps){
            for (Oportunity_Revenue_Range__mdt range : ranges) {
                if (range.Label == 'Green'){
                    if (opp.Amount >= range.Lower_Limit__c) {
                        opp.Priority__c = range.MasterLabel;
                    }
                } else if (range.Label == 'Orange'){
                    if (opp.Amount == null) {
                        opp.Priority__c = range.MasterLabel;
                    }
                } else if (opp.Amount >= range.Lower_Limit__c && opp.Amount <= range.Upper_Limit__c) {
                    opp.Priority__c = range.MasterLabel;
                }
            }
        }
    }
}
public class AccountHelper {
    public boolean annualRevenueChanged(Account oldAcct, Account newAcct){
        if (oldAcct.AnnualRevenue != newAcct.AnnualRevenue){
            return true;
        }
        return false;
    }
    
    public Account[] filterAccountsWithAnnualRevenueChange(Account[] oldAccts, Map<Id, Account> newAcctsMap){
        Account[] filteredList = new Account[]{};
        for(Account oldAcct: oldAccts){
            Account newAcctVersion = newAcctsMap.get(oldAcct.Id); 
            if (annualRevenueChanged(oldAcct, newAcctVersion)){
                filteredList.add(newAcctVersion);
            }
        }
        return filteredList;
    }
    
    public Opportunity[] updateOpportunitiesPriorities(Map<Id, Account> accts){
        Opportunity[] opps = [
            SELECT Priority__c, Account.Id, Account.AnnualRevenue
            FROM Opportunity 
            WHERE AccountId IN :accts.keySet()
        ];
        
        for (Opportunity opp: opps){
            opp.Account.AnnualRevenue = accts.get(opp.Account.Id).AnnualRevenue;
        }
        
        OpportunityHelper oppHelper = new OpportunityHelper();
        oppHelper.updateOpportunitiesPriorities(opps);
        return opps;
    } 
    
    public void processUpdatesInOppPriorities(Account[] oldAccts, Map<Id, Account> newAcctsMap){
        Account[] filteredAccts = filterAccountsWithAnnualRevenueChange(oldAccts, newAcctsMap);
        Map<Id, Account> filteredAcctsMap = new Map<Id, Account>(filteredAccts);
        Opportunity[] opps = updateOpportunitiesPriorities(filteredAcctsMap);
        update opps;
    }

    public void createRelatedOpp(Account[] accts){
        List<Opportunity> opps = new List<Opportunity>();
        Date d = Date.newInstance(2023, 1, 1);
        for(Account acct : accts){
            Opportunity opp = new Opportunity(Name=acct.Name + ' \'s Opp',StageName='Closed Won', CloseDate=d, AccountId=acct.Id);
            opps.add(opp);
        }
        insert opps;
    }
}
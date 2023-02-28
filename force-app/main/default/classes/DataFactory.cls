public class DataFactory {
    public static Opportunity[] createOpportunities(integer size, Account[] accts){
        Date d = Date.newInstance(2023, 1, 1);        
        Opportunity[] opps = new Opportunity[]{};
        for (integer i = 0; i < size; i++){
            opps.add(
                new Opportunity(Name='TestOpp'+i,StageName='Closed Won', CloseDate=d, AccountId=accts.get(i).Id)
            );
        }
        return opps;
    }
    
    public static Account[] createAccounts(integer size){
        Account[] accts = new Account[]{};
		List<Oportunity_Revenue_Range__mdt> ranges = Oportunity_Revenue_Range__mdt.getAll().values();
        for (integer i = 0; i < size; i++){
            Oportunity_Revenue_Range__mdt range = ranges.get(math.mod(i, ranges.size()));
            if(range.Label == 'Orange'){
				accts.add(new Account(Name='TestAcct'+i));
            }else {
				accts.add(new Account(Name='TestAcct'+i, AnnualRevenue=range.Lower_Limit__c+1));
            }
            
        }
        return accts;
    }
    
    public static void createData(integer size){
		Account[] accts = createAccounts(size);
        insert accts;
        Opportunity[] opps = createOpportunities(size, accts);
        insert opps;
    }
    
}
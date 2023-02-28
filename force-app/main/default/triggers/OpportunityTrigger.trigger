trigger OpportunityTrigger on Opportunity (before insert) {
    OpportunityHelper helper = new OpportunityHelper();
    
    if (trigger.isBefore && trigger.isInsert){
        helper.insertOpportunitiesPriorities(trigger.new);
    }
}
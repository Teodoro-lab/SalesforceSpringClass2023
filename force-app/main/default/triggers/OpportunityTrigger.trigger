trigger OpportunityTrigger on Opportunity (before insert, before update) {
    
    OpportunityHelper helper = new OpportunityHelper();
    
    if (trigger.isBefore && trigger.isInsert) {
        helper.assignOpportunityImportance(trigger.new);
    } else if (trigger.isBefore && trigger.isUpdate) {
        helper.assignOpportunityImportance(trigger.new);
    }
}
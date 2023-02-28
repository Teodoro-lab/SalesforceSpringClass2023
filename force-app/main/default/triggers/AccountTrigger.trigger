trigger AccountTrigger on Account (before update, after insert) {
	AccountHelper helper = new AccountHelper();
    
    if (trigger.isBefore && trigger.isUpdate) {
		  helper.processUpdatesInOppPriorities(trigger.old, trigger.newMap);
    }

    if (trigger.isAfter && trigger.isInsert) {
		  helper.createRelatedOpp(trigger.new);
    }
}
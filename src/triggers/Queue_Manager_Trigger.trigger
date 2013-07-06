/**
	* Queue_Manager_Trigger - <description>
	* @author: Collin Parker
	* @version: 1.0
*/

trigger Queue_Manager_Trigger on BMCServiceDesk__Incident__c bulk (before insert,before update) {


	List<BMCServiceDesk__Incident__c> updatedIncs = new List<BMCServiceDesk__Incident__c>();
	
	for (BMCServiceDesk__Incident__c inc : trigger.new) {
		
		if (trigger.oldMap != null) {
		
			BMCServiceDesk__Incident__c oldInc = trigger.oldMap.get(inc.Id);
			String ownerId = inc.OwnerId;
			String oldOwnerId = oldInc.OwnerId;
			
			if (oldInc != null &&  ownerId != oldOwnerId ) {
					updatedIncs.add(inc);
			} else {
				
				if ( String.isNotBlank(inc.OwnerId) && String.isNotEmpty(inc.OwnerId) ) {
					updatedIncs.add(inc);
				}
			}
				
		} else {
		
				if ( String.isNotBlank(inc.OwnerId) && String.isNotEmpty(inc.OwnerId) ) {
					updatedIncs.add(inc);
				}
		}
		
	}
	
	
	
	Queue_Manager_Assign qma = new Queue_Manager_Assign(updatedIncs);
	
	
	
		
}
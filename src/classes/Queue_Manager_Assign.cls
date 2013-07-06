/**
	* Queue_Manager_Class - <description>
	* @author: Collin Parker
	* @version: 1.0
*/

public class Queue_Manager_Assign {


	
	public Queue_Manager_Assign(List<sObject> ObjList) {
		
		
		Set<Id> ownerSet = new Set<Id>();
		for (sObject sObj : ObjList) {
			Id ownerId = (Id)sObj.get('OwnerId');
			ownerSet.add(ownerId);
		}
		
		
		Map<String,Id> qmMap = new Map<String,Id>();
		List<Queue_Manager_Mapping__c> qmm = 
			[ select Id, Queue_Id__c, User__c from Queue_Manager_Mapping__c where Queue_Id__c IN :ownerSet ];
		for (Queue_Manager_Mapping__c qm : qmm) {
			qmMap.put(qm.Queue_Id__c,qm.User__c);
		}
		
		
		for (sObject sObj : ObjList) {
			
			String ownerId = String.valueOf(sObj.get('OwnerId'));
			Id mgrId = qmMap.get( ownerId );
			if ( String.isNotEmpty(mgrId) && String.isNotEmpty(mgrId) ) {
				sObj.put('Queue_Manager__c', mgrId);
			}
		}
		
		
	}

}
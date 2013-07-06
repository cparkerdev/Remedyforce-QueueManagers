/**
	* Queue_Manager_Test - <description>
	* @author: Collin Parker
	* @version: 1.0
*/

@isTest
private class Queue_Manager_Test {
	static testMethod void queueAssignTest() {
		
		
		Queue_Manager_TestData.createTestData();
		
		BMCServiceDesk__Incident__c createInc = [select Id, OwnerId, Queue_Manager__c from BMCServiceDesk__Incident__c LIMIT 1];
		Queue_Manager_Mapping__c createQMM = 
			[select Id, Queue_Id__c, User__c from Queue_Manager_Mapping__c where Queue_Id__c = :createInc.OwnerId LIMIT 1];
		
		System.assertEquals(createInc.Queue_Manager__c,createQMM.User__c);
		
		
		
		Queue_Manager_TestData.updateTestData();
		
		BMCServiceDesk__Incident__c updateInc = [select Id, OwnerId, Queue_Manager__c from BMCServiceDesk__Incident__c LIMIT 1];
		Queue_Manager_Mapping__c updateQMM = 
			[select Id, Queue_Id__c, User__c from Queue_Manager_Mapping__c where Queue_Id__c = :updateInc.OwnerId LIMIT 1];
		
		System.assertEquals(updateInc.Queue_Manager__c,updateQMM.User__c);
		
	}
	
	static testMethod void adminUITest() {
	
		Queue_Manager_TestData.createTestData();
		
		Queue_Manager_Controller qmc = new Queue_Manager_Controller ();
		
		List<SelectOption> qSelectOptions =  qmc.getQueueSelOpts();
		
		List<SelectOption> qAllSelectOptions =  qmc.getAllQueueSelOpts();
		
		qmc.save();
		
		qmc.qmId = qmc.qmanagers[0].Id;
		qmc.delQM();
		
	}
	
}
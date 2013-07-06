/**
	* Queue_Manager_TestData - <description>
	* @author: Collin Parker
	* @version: 1.0
*/
@isTest
public class Queue_Manager_TestData {

	public static void createTestData() {
	
		Group q2 = new Group(Name='TestQueue2',Type='Queue',DeveloperName='TestQueue2');
		insert q2;
		Group q1 = new Group(Name='TestQueue1',Type='Queue',DeveloperName='TestQueue1');
		insert q1;
		
		User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
		System.runAs (thisUser ) {
			QueuesObject qObj1 = new QueuesObject (queueid=q2.id, sobjectType='BMCServiceDesk__Incident__c');
			insert qObj1;
			QueuesObject qObj2 = new QueuesObject (queueid=q1.id, sobjectType='BMCServiceDesk__Incident__c');
			insert qObj2;
		}

		
		BMCServiceDesk__Category__c testCat = new BMCServiceDesk__Category__c(
			BMCServiceDesk__AvailableForIncidents__c=true,
			Name='test category'
		);
		insert testCat;
		
		
		sObject profile = [ select id from profile where Name = 'Standard User' LIMIT 1 ];
		User testUser = new User (
		
			Username='testuser2@test.rs.com',
			Email='testuser2@test.rs.com',
			Lastname='user',
			Firstname='test',
			Alias='test2',
			CommunityNickname = 'test212',
			ProfileId = (ID) profile.get('Id'),
			//CurrencyIsoCode = 'USD',
			TimeZoneSidKey = 'GMT',
			LocaleSidKey = 'en_US',
			EmailEncodingKey = 'ISO-8859-1',
			LanguageLocaleKey = 'en_US'
			
		);
		insert testUser;
		
		
		
		Queue_Manager_Mapping__c testQMM = new Queue_Manager_Mapping__c(
			Queue_Id__c=q1.Id,
			User__c=testUser.Id
		);
		insert testQMM;		
		
		
		
		BMCServiceDesk__Incident__c inc = new BMCServiceDesk__Incident__c(
		
			BMCServiceDesk__FKCategory__c=testCat.Id,
			BMCServiceDesk__FKClient__c=testUser.Id,
			BMCServiceDesk__incidentDescription__c='test description',
			OwnerId=q1.Id
		);
		insert inc;
	
	}
	

	public static void updateTestData() {
	
		
		sObject profile = [ select id from profile where Name = 'Standard User' LIMIT 1 ];
		User testMgr = new User (
		
			Username='testuser@test.rs.com',
			Email='testuser@test.rs.com',
			Lastname='user',
			Firstname='test',
			Alias='test',
			CommunityNickname = 'test12',
			ProfileId = (ID) profile.get('Id'),
			//CurrencyIsoCode = 'USD',
			TimeZoneSidKey = 'GMT',
			LocaleSidKey = 'en_US',
			EmailEncodingKey = 'ISO-8859-1',
			LanguageLocaleKey = 'en_US'
			
		);
		insert testMgr;
		
		
		
		Group q2 = [select Id, Name from Group where Name='TestQueue2' LIMIT 1];
		Queue_Manager_Mapping__c testQMM = new Queue_Manager_Mapping__c(
			Queue_Id__c=q2.Id,
			User__c=testMgr.Id
		);
		insert testQMM;
		
		
		
		BMCServiceDesk__Incident__c inc = [select Id, OwnerId from BMCServiceDesk__Incident__c LIMIT 1];
		
		inc.OwnerId = q2.Id;
		update inc;
		
	}

}
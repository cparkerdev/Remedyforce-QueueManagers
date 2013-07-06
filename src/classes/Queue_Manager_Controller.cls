/**
	* Queue_Manager_Controller - <description>
	* @author: Collin Parker
	* @version: 1.0
*/

public class Queue_Manager_Controller {

	
	public List<Queue_Manager_Mapping__c> qmanagers {get; set;}
	public Queue_Manager_Mapping__c newQM {get; set;}
	public String qmId {get; set;}
	
	public Queue_Manager_Controller () {
	
		this.qmanagers = getQManagers();
		newQM = new Queue_Manager_Mapping__c();
	}
	
	public List<Queue_Manager_Mapping__c> getQManagers () {
	
		List<Queue_Manager_Mapping__c> retList = [select Id, Queue_Id__c, User__c from Queue_Manager_Mapping__c];
	
		return retList;
		
	}
	
	public List<SelectOption> getQueueSelOpts () {
		
		List<SelectOption> retList = new List<SelectOption>();
		Set<String> existIds = new Set<String>();
		
		for (Queue_Manager_Mapping__c qm : qmanagers ) {
			existIds.add(qm.Queue_Id__c);
		}
		
		for (Group gr : [select Id, Name from Group where Type = 'Queue']) {
			if (!existIds.contains(gr.Id)) retList.add(new SelectOption(gr.Id,gr.Name));
		}
		
		return retList;
		
	}
	
	public List<SelectOption> getAllQueueSelOpts () {
		
		List<SelectOption> retList = new List<SelectOption>();

		for (Group gr : [select Id, Name from Group where Type = 'Queue']) {
			retList.add(new SelectOption(gr.Id,gr.Name));
		}
		
		return retList;
		
	}
	
	public PageReference addNew () {
	
		upsert newQM;
		newQM = new Queue_Manager_Mapping__c();
		this.qmanagers = getQManagers();
		return null;
	}
	
	public PageReference delQM () {
	
		Queue_Manager_Mapping__c qm = new Queue_Manager_Mapping__c(Id=qmId);
		delete qm;
		this.qmanagers = getQManagers();
		return null;
		
	}
	
	public void save () {
		
		upsert qmanagers;
		this.qmanagers = getQManagers();
	}
	
	
	
}
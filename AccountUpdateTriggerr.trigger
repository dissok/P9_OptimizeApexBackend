/* Trigger of update of turnover of an account, 
after the update of a related order to this account */

trigger AccountUpdateTriggerr on Order (after update) {
    set<Id> setAccountIds = new set<Id>();
    List<Account> accsToUpdate = new List<Account>{};
 
    for(Order o : Trigger.new){
   setAccountIds.add(o.AccountId); 
}
accsToUpdate = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN: setAccountIds];
AccountService.updateChiffreAffaires(accsToUpdate);
}
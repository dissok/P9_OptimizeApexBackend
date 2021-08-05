trigger AccountUpdateTriggerr on Order (after update) {
    set<Id> setAccountIds = new set<Id>();
    List<Id> accountIds = new List<Id>{};
    List<Account> accsToUpdate = new List<Account>{};
 
 for(integer i=0; i< trigger.new.size(); i++){
    Order newOrder= trigger.new[i];
        accountIds.add(newOrder.AccountId); // compile list of Ids found in the "AccouintId" field       

// compiles and loops through list of Accounts found in Id list from above
for(Account a: [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:newOrder.AccountId]){
    a.Chiffre_d_affaire__c = a.Chiffre_d_affaire__c + newOrder.TotalAmount;
        accstoUpdate.add(a);
}
if(!accsToUpdate.isEmpty())
    update accsToUpdate;
}
}
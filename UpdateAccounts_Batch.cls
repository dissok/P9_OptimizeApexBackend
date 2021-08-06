/* Batch of the accounts update -- we modified this code in order 
 to obtain more simple: AccountService.cls */

global class UpdateAccounts_Batch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
     //Request only the accounts which have at least an order with the 'Ordered' status
        return Database.getQueryLocator('SELECT Id FROM Account');
    }   
    global void execute(Database.BatchableContext info, List<Account> scope){   
        list<Order> listOrders =  [SELECT Id, TotalAmount, AccountId FROM Order];
        
         for(integer i=0; i < scope.size(); i++){
             Account myAccount = scope[i];
             myAccount.Chiffre_d_affaire__c = 0;
            for(integer j=0; j < listOrders.size(); j++){
             if(listOrders[j].AccountId == myAccount.Id){
                 myAccount.Chiffre_d_affaire__c = myAccount.Chiffre_d_affaire__c + listOrders[j].TotalAmount;
                }                   
            }
        }  
        update scope;
    }    
    global void finish(Database.BatchableContext info){         
    } 
 }
global class UpdateAllAccounts_Batch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        // Request only the accounts which have at least an order with the 'Ordered' status
        return Database.getQueryLocator('SELECT Id FROM Account WHERE Id IN (SELECT accountid from order where status=\'Ordered\')');
    }
    global void execute(Database.BatchableContext info, List<Account> scope){
                    AccountService.updateChiffreAffaires(scope);
    }     
    global void finish(Database.BatchableContext info){         
    } 
 }
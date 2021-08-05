public class AccountService {
      public static void updateChiffreAffaires(List<Account> scope) {

        List<Account> accountsToUpdate = new List <Account>();
          Set<Id> accIds = new Set<Id>();

            for(Account a : scope){

                accIds.add(a.Id);
            }
             AggregateResult[] totalCA = [SELECT AccountId, SUM(TotalAmount) sum FROM Order WHERE 
             AccountId IN :accIds and status='Ordered' GROUP BY AccountId];

        //for each account in the scope, we get the orders associated if there's some

       for(Account a: scope){
        Decimal amount = (Decimal)totalCA[0].get('sum');
        a.Chiffre_d_affaire__c = (a.Chiffre_d_affaire__c!=null)?a.Chiffre_d_affaire__c:0; //setting at 0 to avoid null exception after
        a.Chiffre_d_affaire__c = a.Chiffre_d_affaire__c + amount;
        System.debug('account '+a.Chiffre_d_affaire__c);
       }
       update scope;
    }
    public class AccountServiceException extends Exception {}
}
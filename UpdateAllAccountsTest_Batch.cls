@isTest
public with sharing class UpdateAllAccountsTest_Batch {
    @isTest
    static void updateAllAccountsTest() {

        Account updateAccountTest = new Account();
        updateAccountTest.Name = 'Lepicier';
        insert updateAccountTest;

        //create a new product, give it a price and relate it at an order
        Product2 myProduct = new Product2();
        myProduct.Name = 'Ngomna';
        insert myProduct;
  
        PricebookEntry pbe = new PricebookEntry();
        pbe.Pricebook2Id = Test.getStandardPricebookId();//standard method of SF which allow us to directly create a Pricebook
        pbe.Product2Id = myProduct.Id;
        pbe.UnitPrice = 1020;
        pbe.IsActive = true;
        Insert pbe;

        Order theOrder = new Order();
        Date myDate = Date.newInstance(2021, 7, 23);
        theOrder.EffectiveDate = myDate;
        theOrder.Status = 'Ordered';
        theOrder.AccountId = updateAccountTest.Id;
        theOrder.Pricebook2Id = Test.getStandardPricebookId();
        insert theOrder;

        OrderItem oi1 = new OrderItem (OrderId = theOrder.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        
        List<Account> lAcc = [SELECT Id, chiffre_d_affaire__c from Account where Id =: updateAccountTest.Id];

        UpdateAllAccounts_Batch updateAccount = new UpdateAllAccounts_Batch();//Must normally update the turnover of all our acc
        Database.QueryLocator ql = updateAccount.start(null);
        updateAccount.execute(null, lAcc);
        updateAccount.finish(null);
        Account acc = [SELECT Id, chiffre_d_affaire__c from Account where Name = 'Lepicier'];
        System.debug('The turnover of account is: ' + acc.chiffre_d_affaire__c + ' euros.');
    }
}

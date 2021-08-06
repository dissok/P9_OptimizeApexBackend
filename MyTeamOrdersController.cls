/* This class use the variable groupedResult, to retrieve
 the total price of all products to an order and modify it */

public with sharing class MyTeamOrdersController {
    public decimal sumOrders{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
			return (decimal)groupedResults.get('total');
        }
        set;
 }
}
// Trigger of update of NetAmount__c executed before update an order

trigger OrderTrigger on Order (before update) {
	Order newOrder= trigger.new[0];
	newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
}
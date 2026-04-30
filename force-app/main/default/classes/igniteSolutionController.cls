public with sharing class igniteSolutionController {
  
    @AuraEnabled(cacheable=true)
    public static List<Shipment__c> getShipments(){
        return [SELECT Id, Name, Status__c, Expected_Delivery_Date__c FROM Shipment__c LIMIT 10];
    }


    @AuraEnabled
    public static void syncShipments (List<Id> shipmentIds) {
        
    }

    @AuraEnabled
     public static void updateShipmentStatus(Id shipmentId, String newStatus, string newLocation) {
        Shipment__c shipmentToUpdate = [SELECT Id, Status__c, Location__c FROM Shipment__c WHERE Id = :shipmentId LIMIT 1];
        shipmentToUpdate.Status__c = newStatus;
        shipmentToUpdate.Location__c = newLocation;
        update shipmentToUpdate;

}  
}
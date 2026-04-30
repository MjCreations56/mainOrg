@RestResource(urlMapping='/InboundREST/*')
global with sharing class InboundREST {
    @HttpPost
    global static String updateShipmentStatus() {
           
        Request req = RestContext.request;
        String body = req.requestBody.toString();


        Map<String, object> data = (Map<String, Object>) JSON.deserializeUntyped(body);

        String shipmentId = (String) data.get('shipmentId');
        String newStatus = (String) data.get('newStatus');

        Shipment__c shipment = [SELECT Id, Status__c FROM Shipment__c WHERE Shipment_Id__c = :shipmentId LIMIT 1];
        if (shipment != null) {
            shipment.Status__c = newStatus;
            update shipment;
            return 'Shipment status updated successfully.';
        } else {
            return 'Shipment not found.';
        }
    }
}
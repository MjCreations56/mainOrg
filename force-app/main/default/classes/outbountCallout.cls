public with sharing class outbountCallout {
    public static void sendShipment(Shipment__c shipment){

          Http http = new Http();
            HttpRequest request = new HttpRequest();

            request.setEndpoint('https://api.mocklogistics.com/v1/track');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json');


            Map<String, Object> payload = new Map<String, Object>();
            payload.put('shipmentId', shipment.Shipment_Id);
            payload.put('location', shipment.Location__c);
            payload.put('status', shipment.Status__c);  
    };

          request.setBody(JSON.serialize(payload));

          HttpResponse response = http.send(request);
          System.debug('Response: ' + response.getBody());
}
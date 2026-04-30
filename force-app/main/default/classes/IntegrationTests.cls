/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
global class IntegrationTests implements HTTPCalloutMock {
            
       public HTTPResponse respond(HTTPRequest req){

        HTTPResponse res = new HTTPResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"shipmentId": "12345", "newStatus": "Delivered"}');
        res.setStatusCode(200);
        return res;
       }
      

       @isTest
       static void testCallout(){
        Test.setMock(HTTPCalloutMock.class, new IntegrationTests());

        Shipment__c shipment = new Shipment__c(Name='Test Shipment', Id='12345', Status__c='In Transit', Location__c='Warehouse');
        insert shipment;

       Test.startTest();
         outbountCallout.sendShipment(shipment);
         Test.stopTest();

         System.assert(true);
       }
  }
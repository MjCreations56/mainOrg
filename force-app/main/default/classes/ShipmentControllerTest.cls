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
private class ShipmentControllerTest {

    @isTest
    static void testGetShipments() {
        Shipment__c shipment1 = new Shipment__c(Name='Test Shipment 1', Status__c='In Transit', Expected_Delivery_Date__c=Date.today().addDays(5));

        insert shipment1;

        Test.startTest();
        List<Shipment__c> shipments = igniteSolutionController.getShipments();
        Test.stopTest();

        system.assertNotEquals(0, shipments.size(), 'Expected to retrieve at least one shipment');
    }


    @isTest
    static void NegativeTestGetShipments() {
        Test.startTest();
        try{
            igniteSolutionController.updateShipmentStatus(null, 'Delivered', 'New Location');
            System.assert(false, 'Expected an exception to be thrown when shipmentId is null');
        }
        catch(Exception e){
            System.assert(true, 'Expected an exception to be thrown when shipmentId is null');
        }
        Test.stopTest();
    }
}
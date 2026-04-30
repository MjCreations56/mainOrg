import { LightningElement } from 'lwc';
import getShipments from '@salesforce/apex/igniteSolutionController.getShipments';
import syncShipments from '@salesforce/apex/igniteSolutionController.syncShipments';  
import updateShipments from '@salesforce/apex/igniteSolutionController.updateShipmentStatus';
export default class IgniteSolution extends LightningElement {


    shipments = [];
    selectedShipments = [];
    updatedShipments = [];
     

    connectedCallback(){
        this.loadShipments();
    }

    loadShipments(){
        getShipments()
        .then(result => {
            this.shipments = result;
        })
        .catch(error => {
            console.error('Error loading shipments: ', error);
        });
    }
        handleRowSelection(event) {
            const id = event.target.dataset.id;
            if (event.target.checked) {
                this.selectedShipments.push(id);
            } else {
                this.selectedShipments = this.selectedShipments.filter(shipmentId => shipmentId !== id);
            }
        }

        handleMessSync(){
            syncShipments({ shipmentIds: this.selectedShipments })
            .then(() => {
                alert('Sync started successfully!');
            })
            .catch(error => {
                console.error('Error syncing shipments: ', error);
            });
        }

          get isSyncDisabled() {
            return this.selectedShipments.length === 0;
        }

        handleStatusChange(event) {
            const id = event.target.dataset.id;
            const newStatus = event.target.value;
            const shipmentIndex = this.shipments.findIndex(shipment => shipment.Id === id);
            if (shipmentIndex !== -1) {
                this.shipments[shipmentIndex].Status__c = newStatus;
                if (!this.updatedShipments.includes(id)) {
                    this.updatedShipments.push(id);
                }
            };
        }

        handleLocationChange(event) {
            const id = event.target.dataset.id;
            const newLocation = event.target.value;
            const shipmentIndex = this.shipments.findIndex(shipment => shipment.Id === id);
            if (shipmentIndex !== -1) {
                this.shipments[shipmentIndex].Location__c = newLocation;
                if (!this.updatedShipments.includes(id)) {
                    this.updatedShipments.push(id);
                }
            };
        }

            handleQuickUpdate(){
                const id = event.target.dataset.id;
                const values = this.updatedShipments.map(shipmentId => {
                    const shipment = this.shipments.find(s => s.Id === shipmentId);
                    return {
                        Id: shipment.Id,
                        Status__c: shipment.Status__c,
                        Location__c: shipment.Location__c
                    };
                });
                updateShipments({ shipmentsToUpdate: values })
                .then(() => {
                    alert('Shipments updated successfully!');
                    this.updatedShipments = [];
                })
                .catch(error => {
                    console.error('Error updating shipments: ', error);
                });
            }
}
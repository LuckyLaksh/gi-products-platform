import { LightningElement, wire, track } from 'lwc';
import getProductsByLocation from '@salesforce/apex/GIProductController.getProductsByLocation';

export default class GiProductMap extends LightningElement {
    @track products = [];
    @track mapMarkers = [];
    @track isLoading = false;
    @track selectedProduct = null;
    
    connectedCallback() {
        this.loadProducts();
    }
    
    loadProducts() {
        this.isLoading = true;
        
        getProductsByLocation()
        .then(result => {
            this.products = result;
            this.mapMarkers = result.map(product => ({
                location: {
                    Latitude: product.Latitude__c,
                    Longitude: product.Longitude__c
                },
                title: product.Name,
                description: `${product.Product_Type__c} - ${product.Origin_City__c}, ${product.Origin_State__c}`,
                value: product.Id
            }));
            this.isLoading = false;
        })
        .catch(error => {
            console.error('Error loading products:', error);
            this.isLoading = false;
        });
    }
    
    handleMarkerSelect(event) {
        const selectedMarkerValue = event.detail.selectedMarkerValue;
        this.selectedProduct = this.products.find(
            product => product.Id === selectedMarkerValue
        );
    }
    
    get hasProducts() {
        return this.products && this.products.length > 0;
    }
    
    get mapHeight() {
        return '500px';
    }
}


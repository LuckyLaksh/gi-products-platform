import { LightningElement, api, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getProductById from '@salesforce/apex/GIProductController.getProductById';

export default class GiProductStory extends NavigationMixin(LightningElement) {
    @api recordId; // Product ID when used on record page
    
    @track product = null;
    @track isLoading = false;
    
    connectedCallback() {
        if (this.recordId) {
            this.loadProduct();
        }
    }
    
    loadProduct() {
        this.isLoading = true;
        getProductById({ productId: this.recordId })
        .then(result => {
            this.product = result;
            this.isLoading = false;
        })
        .catch(error => {
            console.error('Error loading product:', error);
            this.isLoading = false;
        });
    }
    
    get hasStory() {
        return this.product && this.product.Origin_Story__c;
    }
    
    get hasProduct() {
        return this.product !== null;
    }
}


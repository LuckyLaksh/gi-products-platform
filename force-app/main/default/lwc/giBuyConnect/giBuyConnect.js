import { LightningElement, api, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getProductById from '@salesforce/apex/GIProductController.getProductById';
import getSellersByProduct from '@salesforce/apex/GISellerController.getSellersByProduct';
import createOpportunity from '@salesforce/apex/GIRegistrationController.createOpportunity';

export default class GiBuyConnect extends NavigationMixin(LightningElement) {
    @api recordId; // Product ID when used on record page
    
    @track product = null;
    @track sellers = [];
    @track isLoading = false;
    @track showForm = false;
    
    // Form fields
    contactId = '';
    opportunityName = '';
    amount = 0;
    closeDate;
    
    connectedCallback() {
        if (this.recordId) {
            this.loadProduct();
            this.loadSellers();
        }
    }
    
    loadProduct() {
        this.isLoading = true;
        getProductById({ productId: this.recordId })
        .then(result => {
            this.product = result;
            this.opportunityName = `Inquiry for ${result.Name}`;
            this.isLoading = false;
        })
        .catch(error => {
            console.error('Error loading product:', error);
            this.isLoading = false;
        });
    }
    
    loadSellers() {
        getSellersByProduct({ productId: this.recordId })
        .then(result => {
            this.sellers = result;
        })
        .catch(error => {
            console.error('Error loading sellers:', error);
        });
    }
    
    handleContactChange(event) {
        this.contactId = event.detail.value;
    }
    
    handleNameChange(event) {
        this.opportunityName = event.target.value;
    }
    
    handleAmountChange(event) {
        this.amount = event.target.value;
    }
    
    handleDateChange(event) {
        this.closeDate = event.target.value;
    }
    
    handleShowForm() {
        this.showForm = true;
    }
    
    handleCancel() {
        this.showForm = false;
        this.contactId = '';
        this.amount = 0;
        this.closeDate = null;
    }
    
    handleSubmit() {
        if (!this.contactId) {
            this.showToast('Error', 'Please select a seller', 'error');
            return;
        }
        
        this.isLoading = true;
        createOpportunity({
            productId: this.recordId,
            contactId: this.contactId,
            opportunityName: this.opportunityName,
            amount: this.amount,
            closeDate: this.closeDate
        })
        .then(result => {
            this.showToast('Success', 'Your inquiry has been submitted successfully!', 'success');
            this.handleCancel();
            this.isLoading = false;
        })
        .catch(error => {
            this.showToast('Error', error.body?.message || 'An error occurred', 'error');
            this.isLoading = false;
        });
    }
    
    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(evt);
    }
    
    get sellerOptions() {
        return this.sellers.map(seller => ({
            label: `${seller.Name}${seller.Seller_Rating__c ? ' (' + seller.Seller_Rating__c + '/5)' : ''}`,
            value: seller.Id
        }));
    }
    
    get hasSellers() {
        return this.sellers && this.sellers.length > 0;
    }
}


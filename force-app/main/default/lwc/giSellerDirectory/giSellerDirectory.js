import { LightningElement, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getVerifiedSellers from '@salesforce/apex/GISellerController.getVerifiedSellers';
import getSellerCount from '@salesforce/apex/GISellerController.getSellerCount';

export default class GiSellerDirectory extends NavigationMixin(LightningElement) {
    @track sellers = [];
    @track totalCount = 0;
    @track isLoading = false;
    
    pageSize = 12;
    currentPage = 1;
    totalPages = 0;
    
    connectedCallback() {
        this.loadSellers();
        this.loadCount();
    }
    
    loadSellers() {
        this.isLoading = true;
        const offset = (this.currentPage - 1) * this.pageSize;
        
        getVerifiedSellers({
            limitSize: this.pageSize,
            offset: offset
        })
        .then(result => {
            // Add badge class to each seller
            this.sellers = result.map(seller => ({
                ...seller,
                badgeClass: this.getBadgeClass(seller.Seller_Badge__c)
            }));
            this.isLoading = false;
        })
        .catch(error => {
            console.error('Error loading sellers:', error);
            this.isLoading = false;
        });
    }
    
    loadCount() {
        getSellerCount()
        .then(result => {
            this.totalCount = result;
            this.totalPages = Math.ceil(this.totalCount / this.pageSize);
        })
        .catch(error => {
            console.error('Error loading count:', error);
        });
    }
    
    handlePreviousPage() {
        if (this.currentPage > 1) {
            this.currentPage--;
            this.loadSellers();
        }
    }
    
    handleNextPage() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
            this.loadSellers();
        }
    }
    
    handleSellerClick(event) {
        const sellerId = event.currentTarget.dataset.id;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: sellerId,
                actionName: 'view'
            }
        });
    }
    
    getBadgeClass(badge) {
        if (badge === 'Gold') return 'slds-badge_inverse';
        if (badge === 'Silver') return 'slds-badge';
        if (badge === 'Bronze') return 'slds-badge_lightest';
        return '';
    }
    
    get hasSellers() {
        return this.sellers && this.sellers.length > 0;
    }
    
    get hasPreviousPage() {
        return this.currentPage > 1;
    }
    
    get isPreviousPageDisabled() {
        return !this.hasPreviousPage;
    }
    
    get hasNextPage() {
        return this.currentPage < this.totalPages;
    }
    
    get isNextPageDisabled() {
        return !this.hasNextPage;
    }
    
    get pageInfo() {
        const start = (this.currentPage - 1) * this.pageSize + 1;
        const end = Math.min(this.currentPage * this.pageSize, this.totalCount);
        return `Showing ${start}-${end} of ${this.totalCount} verified sellers`;
    }
}


import { LightningElement, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import searchProducts from '@salesforce/apex/GIProductController.searchProducts';
import getProductCount from '@salesforce/apex/GIProductController.getProductCount';
import getOriginStates from '@salesforce/apex/GIProductController.getOriginStates';

export default class GiProductDirectory extends NavigationMixin(LightningElement) {
    @track products = [];
    @track originStates = [];
    @track totalCount = 0;
    @track isLoading = false;
    
    // Filter properties
    searchTerm = '';
    selectedProductType = '';
    selectedGIStatus = '';
    selectedOriginState = '';
    
    // Pagination
    pageSize = 12;
    currentPage = 1;
    totalPages = 0;
    
    // Product type options
    productTypeOptions = [
        { label: 'All Types', value: '' },
        { label: 'GI Tag Product', value: 'GI Tag Product' },
        { label: 'Handloom', value: 'Handloom' },
        { label: 'Food', value: 'Food' },
        { label: 'Handicraft', value: 'Handicraft' }
    ];
    
    // GI Status options
    giStatusOptions = [
        { label: 'All Status', value: '' },
        { label: 'Registered', value: 'Registered' },
        { label: 'Pending', value: 'Pending' },
        { label: 'Not Registered', value: 'Not Registered' }
    ];
    
    @wire(getOriginStates)
    wiredStates({ error, data }) {
        if (data) {
            this.originStates = [{ label: 'All States', value: '' }].concat(
                data.map(state => ({ label: state, value: state }))
            );
        } else if (error) {
            console.error('Error loading states:', error);
        }
    }
    
    connectedCallback() {
        this.loadProducts();
        this.loadCount();
    }
    
    loadProducts() {
        this.isLoading = true;
        const offset = (this.currentPage - 1) * this.pageSize;
        
        searchProducts({
            searchTerm: this.searchTerm,
            productType: this.selectedProductType,
            giStatus: this.selectedGIStatus,
            originState: this.selectedOriginState,
            limitSize: this.pageSize,
            offset: offset
        })
        .then(result => {
            this.products = result;
            this.isLoading = false;
        })
        .catch(error => {
            console.error('Error loading products:', error);
            this.isLoading = false;
        });
    }
    
    loadCount() {
        getProductCount({
            searchTerm: this.searchTerm,
            productType: this.selectedProductType,
            giStatus: this.selectedGIStatus,
            originState: this.selectedOriginState
        })
        .then(result => {
            this.totalCount = result;
            this.totalPages = Math.ceil(this.totalCount / this.pageSize);
        })
        .catch(error => {
            console.error('Error loading count:', error);
        });
    }
    
    handleSearch(event) {
        this.searchTerm = event.target.value;
        this.currentPage = 1;
        this.loadProducts();
        this.loadCount();
    }
    
    handleProductTypeChange(event) {
        this.selectedProductType = event.detail.value;
        this.currentPage = 1;
        this.loadProducts();
        this.loadCount();
    }
    
    handleGIStatusChange(event) {
        this.selectedGIStatus = event.detail.value;
        this.currentPage = 1;
        this.loadProducts();
        this.loadCount();
    }
    
    handleOriginStateChange(event) {
        this.selectedOriginState = event.detail.value;
        this.currentPage = 1;
        this.loadProducts();
        this.loadCount();
    }
    
    handlePreviousPage() {
        if (this.currentPage > 1) {
            this.currentPage--;
            this.loadProducts();
        }
    }
    
    handleNextPage() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
            this.loadProducts();
        }
    }
    
    handleProductClick(event) {
        const productId = event.currentTarget.dataset.id;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: productId,
                actionName: 'view'
            }
        });
    }
    
    get hasProducts() {
        return this.products && this.products.length > 0;
    }
    
    get hasPreviousPage() {
        return this.currentPage > 1;
    }
    
    get hasNextPage() {
        return this.currentPage < this.totalPages;
    }
    
    get pageInfo() {
        const start = (this.currentPage - 1) * this.pageSize + 1;
        const end = Math.min(this.currentPage * this.pageSize, this.totalCount);
        return `Showing ${start}-${end} of ${this.totalCount} products`;
    }
}


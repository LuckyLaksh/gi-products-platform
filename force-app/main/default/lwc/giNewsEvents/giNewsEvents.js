import { LightningElement, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getNewsEvents from '@salesforce/apex/GINewsEventController.getNewsEvents';

export default class GiNewsEvents extends NavigationMixin(LightningElement) {
    @track newsEvents = [];
    @track isLoading = false;
    
    limitSize = 10;
    
    connectedCallback() {
        this.loadNewsEvents();
    }
    
    loadNewsEvents() {
        this.isLoading = true;
        getNewsEvents({ limitSize: this.limitSize })
        .then(result => {
            this.newsEvents = result;
            this.isLoading = false;
        })
        .catch(error => {
            console.error('Error loading news/events:', error);
            this.isLoading = false;
        });
    }
    
    handleItemClick(event) {
        const itemId = event.currentTarget.dataset.id;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: itemId,
                actionName: 'view'
            }
        });
    }
    
    formatDate(dateValue) {
        if (!dateValue) return '';
        const date = new Date(dateValue);
        return date.toLocaleDateString('en-US', { 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric' 
        });
    }
    
    get hasNewsEvents() {
        return this.newsEvents && this.newsEvents.length > 0;
    }
}


import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createRegistration from '@salesforce/apex/GIRegistrationController.createRegistration';

export default class GiRegistration extends LightningElement {
    @track isLoading = false;
    
    // Form fields
    firstName = '';
    lastName = '';
    email = '';
    phone = '';
    company = '';
    comments = '';
    
    handleFirstNameChange(event) {
        this.firstName = event.target.value;
    }
    
    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }
    
    handleEmailChange(event) {
        this.email = event.target.value;
    }
    
    handlePhoneChange(event) {
        this.phone = event.target.value;
    }
    
    handleCompanyChange(event) {
        this.company = event.target.value;
    }
    
    handleCommentsChange(event) {
        this.comments = event.target.value;
    }
    
    handleSubmit() {
        // Validate required fields
        if (!this.firstName || !this.lastName || !this.email) {
            this.showToast('Error', 'Please fill in all required fields', 'error');
            return;
        }
        
        this.isLoading = true;
        
        createRegistration({
            firstName: this.firstName,
            lastName: this.lastName,
            email: this.email,
            phone: this.phone,
            company: this.company,
            comments: this.comments
        })
        .then(result => {
            this.showToast('Success', 'Registration submitted successfully! We will contact you soon.', 'success');
            this.resetForm();
            this.isLoading = false;
        })
        .catch(error => {
            this.showToast('Error', error.body?.message || 'An error occurred', 'error');
            this.isLoading = false;
        });
    }
    
    resetForm() {
        this.firstName = '';
        this.lastName = '';
        this.email = '';
        this.phone = '';
        this.company = '';
        this.comments = '';
        
        // Reset form fields
        const inputFields = this.template.querySelectorAll('lightning-input, lightning-textarea');
        inputFields.forEach(field => {
            field.value = '';
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
}


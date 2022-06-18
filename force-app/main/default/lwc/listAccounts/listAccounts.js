import { LightningElement } from 'lwc';
import accountList from '@salesforce/apex/getAccounts.accountList';

export default class ListAccounts extends LightningElement {
    accounts;
    connectedCallback(){
        accountList().then(data => {
            console.log('success', data)
            this.accounts = data;
        }).catch(err => console.log('failed', err));
    }

}
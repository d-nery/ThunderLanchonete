import { Component, Inject } from '@angular/core';
import { ViewController, NavParams } from 'ionic-angular';
import { BarcodeScanner } from 'ionic-native';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { FirebaseListObservable, FirebaseApp } from 'angularfire2';

import { PriceValidator } from '../../validators/price';
import { BarcodeValidator } from '../../validators/barcode';

@Component({
  selector: 'page-add-product',
  templateUrl: 'add-product.html'
})
export class AddProductPage {
  productsRef: FirebaseListObservable<any[]>;
  productForm: FormGroup;
  submitAttempt: boolean = false;

  constructor(@Inject(FirebaseApp) public firebaseApp: any, public viewCtrl: ViewController, public navParams: NavParams, public formBuilder: FormBuilder) {
    this.productsRef = navParams.get('products');

    this.productForm = formBuilder.group({
      name: ['', Validators.compose([Validators.required, Validators.maxLength(15)])],
      price: ['', Validators.compose([PriceValidator.isValid, Validators.required])],
      barcode: ['', Validators.compose([BarcodeValidator.isValid, Validators.required])]
    });
  }

  close() {
    this.viewCtrl.dismiss();
  }

  save() {
    this.submitAttempt = true;

    if (this.productForm.valid) {
      const storageRef = this.firebaseApp.storage().ref().child('products/default.png');
      storageRef.getDownloadURL().then(url => {
        this.productsRef.push({
          name: this.productForm.value['name'],
          price: Number(this.productForm.value['price']),
          barcode: Number(this.productForm.value['barcode']),
          image: url
        });
      });

      this.viewCtrl.dismiss();
    }
  }

  barcodeScan() {
    BarcodeScanner.scan().then(data => {
      if (!data.cancelled)
        this.productForm.patchValue({ barcode: Number(data.text) });
    }, err => {
      console.log('Barcode scan failed:', err);
    });
  }
}

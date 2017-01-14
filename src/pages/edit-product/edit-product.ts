import { Component, Inject } from '@angular/core';
import { ViewController, NavParams } from 'ionic-angular';
import { BarcodeScanner } from 'ionic-native';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { FirebaseObjectObservable, FirebaseApp, AngularFire } from 'angularfire2';

import { PriceValidator } from '../../validators/price';
import { BarcodeValidator } from '../../validators/barcode';

@Component({
  selector: 'page-edit-product',
  templateUrl: 'edit-product.html'
})
export class EditProductPage {
  productRef: FirebaseObjectObservable<any>;
  productForm: FormGroup;
  submitAttempt: boolean = false;
  available: boolean;

  constructor(@Inject(FirebaseApp) public firebaseApp: any, public af: AngularFire, public viewCtrl: ViewController, public navParams: NavParams, public formBuilder: FormBuilder) {
    this.productRef = this.af.database.object('/products/' + navParams.get('key'), { preserveSnapshot: true });

    this.productForm = formBuilder.group({
      name: ['', Validators.compose([Validators.required, Validators.maxLength(15)])],
      price: ['', Validators.compose([PriceValidator.isValid, Validators.required])],
      barcode: ['', Validators.compose([BarcodeValidator.isValid, Validators.required])]
    });

    this.productRef.subscribe(snap => {
      this.productForm.patchValue({
        name: snap.val().name,
        price: snap.val().price,
        barcode: snap.val().barcode
      });

      this.available = snap.val().available;
    });
  }

  close() {
    this.viewCtrl.dismiss();
  }

  save() {
    this.submitAttempt = true;

    if (this.productForm.valid) {
      this.productRef.update({
        name: this.productForm.value['name'],
        price: Number(this.productForm.value['price']),
        barcode: Number(this.productForm.value['barcode']),
        available: this.available
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

import { Component } from '@angular/core';
import { ViewController, NavParams, LoadingController } from 'ionic-angular';
import { BarcodeScanner, HTTP } from 'ionic-native';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { FirebaseListObservable } from 'angularfire2';

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
  img_url: string;

  constructor(public viewCtrl: ViewController, public navParams: NavParams, public formBuilder: FormBuilder, public loadingCtrl: LoadingController) {
    this.productsRef = navParams.get('products');

    this.productForm = formBuilder.group({
      name: ['', Validators.compose([Validators.required, Validators.maxLength(15)])],
      price: ['', Validators.compose([PriceValidator.isValid, Validators.required])],
      barcode: ['', Validators.compose([BarcodeValidator.isValid, Validators.required])]
    });

    this.img_url = "";
  }

  close() {
    this.viewCtrl.dismiss();
  }

  save() {
    this.submitAttempt = true;

    if (this.productForm.valid) {
      this.productsRef.push({
        name: this.productForm.value['name'],
        price: Number(this.productForm.value['price']),
        barcode: Number(this.productForm.value['barcode']),
        available: true,
        image: this.img_url
      });

      this.viewCtrl.dismiss();
    }
  }

  barcodeScan() {
    BarcodeScanner.scan().then(data => {
      if (!data.cancelled) {
        let loader = this.loadingCtrl.create({
          content: 'Carregando...'
        });
        loader.present();
        HTTP.get('https://pod.opendatasoft.com/api/v2/catalog/datasets/pod_gtin/records', {
          q: Number(data.text),
          rows: 10,
          fields: 'gtin_cd,gtin_nm,gtin_img',
          pretty: false,
          timezone: 'UTC'
        }, {}).then(resp => {
          if (resp.status == 200) {
            this.productForm.patchValue({
              name: JSON.parse(resp.data).records[0].record.fields.gtin_nm,
              barcode: Number(data.text)
            });
            this.img_url = JSON.parse(resp.data).records[0].record.fields.gtin_img;
          } else {
            this.productForm.patchValue({
              name: "Nao encontrado",
              barcode: Number(data.text)
            });
          }
          loader.dismiss();
        }).catch(err => {
          this.productForm.patchValue({
            name: "Nao encontrado",
            barcode: Number(data.text)
          });
          console.log(err);
          loader.dismiss();
        })

      }
    }, err => {
      console.log('Barcode scan failed:', err);
    });
  }
}

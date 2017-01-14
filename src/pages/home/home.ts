import { Component, Inject } from '@angular/core';
import { NavController, ModalController, AlertController } from 'ionic-angular';
import { BarcodeScanner } from 'ionic-native';
import { AngularFire, FirebaseListObservable } from 'angularfire2';

import { AddProductPage } from '../add-product/add-product';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  showSearch: boolean;
  barcodeScan: boolean;
  barcodeIcon: string;
  productsRef: FirebaseListObservable<any[]>;

  constructor(public navCtrl: NavController, public af: AngularFire, public modalCtrl: ModalController, public alertCtrl: AlertController) {
    this.showSearch = false;
    this.barcodeScan = false;
    this.barcodeIcon = 'barcode';

    this.productsRef = af.database.list('/products', {
      query: {
        orderByChild: 'name'
      }
    });
  }

  toggleSearch(): void {
    this.showSearch = !this.showSearch;
  }

  addNew(): void {
    let newItemsModal = this.modalCtrl.create(AddProductPage, { products: this.productsRef });
    newItemsModal.present();
  }

  delete(key: string): void {
    let alert = this.alertCtrl.create({
      title: 'Deletar Produto',
      message: 'Deseja realmente deletar o produto?',
      buttons: [
        { text: 'Cancelar' },
        {
          text: 'Deletar',
          handler: (data) => {
            this.productsRef.remove(key);
          }
        }
      ]
    });

    alert.present();
  }

  searchBarcode(): void {
    if (!this.barcodeScan) {
      BarcodeScanner.scan().then(data => {
        if (!data.cancelled) {
          this.productsRef = this.af.database.list('/products', {
            query: {
              orderByChild: 'barcode',
              equalTo: Number(data.text)
            }
          });
        }
      }, err => {
        console.log('Barcode scan failed:', err);
      });
      this.barcodeScan = true;
      this.barcodeIcon = 'arrow-back';
    } else {
      this.productsRef = this.af.database.list('/products', {
        query: {
          orderByChild: 'name'
        }
      });
      this.barcodeScan = false;
      this.barcodeIcon = 'barcode';
    }
  }
}

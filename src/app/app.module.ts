import { NgModule, ErrorHandler } from '@angular/core';
import { IonicApp, IonicModule, IonicErrorHandler } from 'ionic-angular';
import { AngularFireModule } from 'angularfire2';
import { MyApp } from './app.component';
import { HomePage } from '../pages/home/home';
import { AddProductPage } from '../pages/add-product/add-product';
import { EditProductPage } from '../pages/edit-product/edit-product';

export const fbConf = {
  apiKey: "AIzaSyDovbGrxXPrFgkuSh0A_0Fv_hBHGtwrQSc",
  authDomain: "thunderlanchonete.firebaseapp.com",
  databaseURL: "https://thunderlanchonete.firebaseio.com",
  storageBucket: "thunderlanchonete.appspot.com",
  messagingSenderId: "688203982991"
};

@NgModule({
  declarations: [
    MyApp,
    HomePage,
    AddProductPage,
    EditProductPage
  ],
  imports: [
    IonicModule.forRoot(MyApp),
    AngularFireModule.initializeApp(fbConf)
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    HomePage,
    AddProductPage,
    EditProductPage
  ],
  providers: [{provide: ErrorHandler, useClass: IonicErrorHandler}]
})
export class AppModule {}

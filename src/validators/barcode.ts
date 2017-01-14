import { FormControl } from '@angular/forms';

export class BarcodeValidator {
  static isValid(control: FormControl): any {
    if (isNaN(control.value)){
      return {
        "not a number": true
      };
    }
    if (control.value % 1 !== 0){
      return {
        "not a whole number": true
      };
    }
    if (control.value < 0){
      return {
        "negative": true
      };
    }
    if (control.value > 999999999999999){
      return {
        "too high": true
      };
    }

    return null;
  }
}

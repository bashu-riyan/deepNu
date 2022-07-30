import 'package:flutter/widgets.dart';

class SaveData with ChangeNotifier { 
bool emailPrivate = false;
bool get getEmailPrivate => emailPrivate;
set setEmailPrivate(bool val){ 
  emailPrivate = val;
  notifyListeners();
}
bool phonePrivate  =false;
bool get getphonePrivate => phonePrivate;
set setphoneprivate(bool val){ 
  phonePrivate =val;
  notifyListeners();
}
bool cityPrivate = false;
bool get getCityPrivate => cityPrivate;
set setcityPrivate(bool val){ 
  cityPrivate = val;
  notifyListeners();
}
bool AboutPrivate = false;
bool get getAboutPrivate => AboutPrivate;
set setAboutPrivate(bool val){ 
  AboutPrivate =val;
  notifyListeners();
}

} 
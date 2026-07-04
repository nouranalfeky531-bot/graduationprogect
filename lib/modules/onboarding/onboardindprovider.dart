import 'package:flutter/cupertino.dart';
import 'package:graduation_progect/modules/onboarding/prefsmanager.dart';
import 'package:provider/provider.dart';

class onboardprovider extends ChangeNotifier{
 bool isopened=false ;
  getvalue() async {
   isopened = await PrefsManager. getPrefs();
   notifyListeners();
  }

}
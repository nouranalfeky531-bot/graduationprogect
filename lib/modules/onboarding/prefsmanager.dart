
import 'package:shared_preferences/shared_preferences.dart';

class prefsemanager {

  static Future<void> setprefs(state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool whatstate=  prefs.getBool("intro_seen")??false;
    //  if(whatstate==true){
    //   whatstate=state;
    //  }
    prefs.setBool("intro_seen", state);

    print("======================================");
    // bool whatstate=  prefs.getBool("intro_seen")??false;
    print(state);
    print("======================================");
  }

static  Future<bool> getprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = prefs.getBool("intro_seen") ?? false;
    print("=======================================");
    print(seen);
    print("============================================================");
    return seen = prefs.getBool("intro_seen") ?? false;
  }
}
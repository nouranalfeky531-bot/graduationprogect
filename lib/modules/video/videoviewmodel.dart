import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:graduation_progect/modules/video/models/Videoresponse.dart';

class videoviewModel{

  static Future<Videoresponse> loadvediodetails() async {
     String filepath="assets/files/SmartObjectSample.json";
    String jsonString = await rootBundle.loadString(filepath);
    print("==========================================================================================");
    print(jsonString);
    var jsonData = json.decode(jsonString);
    return Videoresponse.fromJson(jsonData);
  }
}
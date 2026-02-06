import 'package:flutter/material.dart';
import 'package:graduation_progect/modules/video/models/Data.dart';
import 'package:graduation_progect/modules/video/videoviewmodel.dart';

import 'models/AudioList.dart';
import 'models/AvailableLanguages.dart';
import 'models/Videoresponse.dart';
import 'models/VttList.dart';

class VideoProvider extends ChangeNotifier {
  List<String>? keywords=[];
  List<AudioList>? audioList=[];
  List<VttList>? vttList=[];
  String url='https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  List<AvailableLanguages>?availableLanguages =[];
  // List<Data>? data;
  List<String> languageCodes = [];
  // AvailableLanguages languages=AvailableLanguages();

  bool isLoading = false;
  String selectedvalue="transcript";

  Data? selecteddata;

Data? selecctdata(int index){
  selecteddata=availableLanguages![index].data;
  notifyListeners();
  return selecteddata;
}
void selected(String value){
  if (value == "summary25") {
    selectedvalue=selecteddata!.summary25!;
    notifyListeners();
  } else if (value == "summary50") {
    selectedvalue=selecteddata!.summary50!;
    notifyListeners();
  }else if(value=="transcript"){
    selectedvalue=selecteddata!.transcript!;
  }
}

 Future<void>fetchvideodata()async {
    isLoading = true;
    notifyListeners();
    Videoresponse videoresponse = await videoviewModel.loadvediodetails();
    isLoading = false;
    notifyListeners();
    url=videoresponse.url?? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
    keywords=videoresponse.keywords??[];
    audioList=videoresponse.audioList??[];
    vttList=videoresponse.vttList??[];
    availableLanguages=videoresponse.availableLanguages??[];
    // data=Data();
    notifyListeners();
    languageCodes = availableLanguages
        ?.map((e) => e.languageCode.toString())
        .toList() ??
        [];
    notifyListeners();

  }


}



import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesService {
  //Singleton class
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  static late final SharedPreferences prefs;

  Future<void> setPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

 
 

  
}

class SharedPreferenceController {
  //Set an initial value of controller
  Future<void> setInitialControllerValues({
    String? token,
  }) async {
    if (token != null) {
      await SharedPreferencesService.prefs.setString("token", token);
    }
  }
}

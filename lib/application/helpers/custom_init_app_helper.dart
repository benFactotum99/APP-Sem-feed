import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sem_feed/data/helpers/custom_api_helper.dart';
import 'package:sem_feed/data/helpers/user_session_helper.dart';

import 'strings_helper.dart';

class CustomInitAppHelper {
  static Future<bool> isLoggedIn() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: CURRENT_USER);
    if (value != null)
      return true;
    else
      return false;
  }

  static Future<bool> isValidToken() async {
    final storage = new FlutterSecureStorage();
    final userSessionHelper = UserSessionHelper(storage);
    var currentUser = await userSessionHelper.currentUser;
    if (currentUser == null) return false;
    try {
      var accessToken = await CustomApiHelper.getNewAccessToken(
          baseUrl, currentUser.refreshToken);
      currentUser.accessToken = accessToken;
      userSessionHelper.saveUserSession(currentUser);
      return true;
    } catch (e) {
      userSessionHelper.deleteUserSession();
      return false;
    }
  }
}

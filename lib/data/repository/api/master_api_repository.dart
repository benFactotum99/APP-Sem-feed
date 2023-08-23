import 'package:sem_feed/data/helpers/custom_api_helper.dart';
import 'package:sem_feed/data/helpers/user_session_helper.dart';

abstract class MasterApiRepository {
  final String baseUrl;
  final UserSessionHelper userSessionHelper;
  MasterApiRepository(this.baseUrl, this.userSessionHelper);

  Future<void> refreshSession() async {
    var currentUser = await userSessionHelper.currentUser;
    if (currentUser == null) throw Exception("Utente non trovato");
    var accessToken = await CustomApiHelper.getNewAccessToken(
        baseUrl, currentUser.refreshToken);
    currentUser.accessToken = accessToken;
    await userSessionHelper.saveUserSession(currentUser);
  }
}

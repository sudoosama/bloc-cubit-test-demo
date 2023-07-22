
import 'package:demo_new/utils/preference_utils.dart';

class UserDataRepository {
  Future<void> storeUserData(String token) async {
    PreferenceUtils.setString(PrefKey.USERTOKEN, token);
  }
}

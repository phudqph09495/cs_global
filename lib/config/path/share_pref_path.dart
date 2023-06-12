


import '../../model/model_login.dart';
import '../share_pref.dart';

class SharePrefsKeys {
  static String login = "login";
  static String user = "user";
  static String user_id = "id";
  static String user_token = "access_token";
  static String name = "username";
  static String avatar = "avatar";
  static String phone = "phone";
  static String email = "email";
static String expired_at="expired_at";


  static saveUserKey(ModelLogin model) async {

SharedPrefs.saveBool(SharePrefsKeys.login, true);
    SharedPrefs.saveString(SharePrefsKeys.user_token,model.token!.data!.token);


  }

  static removeAllKey() async {
    SharedPrefs.remove(SharePrefsKeys.login);
    SharedPrefs.remove(SharePrefsKeys.user_token);
    SharedPrefs.clear();



    // SharedPrefs.remove(SharePrefsKeys.user_id);
    // SharedPrefs.remove(SharePrefsKeys.name);
    // SharedPrefs.remove(SharePrefsKeys.phone);
    // SharedPrefs.remove(SharePrefsKeys.email);
    // SharedPrefs.remove(SharePrefsKeys.avatar);
  }
}

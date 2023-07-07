import 'package:shared_preferences/shared_preferences.dart';

import 'user_config.dart';

class PersitenceManager {
  final String store_key = "appconfig";

  Future<UserConfig> loadStore() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String json = preferences.getString(store_key) ??
        userConfigToJson(
          UserConfig.empty(
            profile: Profile.empty()
          ),
        );
    UserConfig config = userConfigFromJson(json);
    return config;
  }

  Future<bool> saveStore(UserConfig config) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String json = userConfigToJson(config);
    preferences.setString(store_key, json);
    return true;
  }
}

import 'dart:async';
import 'dart:convert';


Future<dynamic> getClassFromStore(storage, key) async {
  try {
    final check = await storage?.containsKey(key) ?? false;
    if (check) {
      final userString = await storage?.getString(key);
      final userJson = jsonDecode(userString!);
      return userJson;
    }
  } catch (e) {
    throw "storage key:$key does not exist";
  }
}

void saveStringToStore(storage, key, payload) {
  final String? savedString = jsonEncode(payload);
  if (savedString != null) storage?.setString(key, savedString);
}

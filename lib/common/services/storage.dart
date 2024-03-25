// Import the libraries from the external.
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that wraps the `SharedPreference` plugin functionality for
/// persistent storage
class StorageService extends GetxService {

  /// Get the single instance of the StorageService using the GetX framework
  static StorageService get to => Get.find();

  late final SharedPreferences _prefs;

  /// Initialize the instance of the SharedPreference asynchronously
  /// This function must be called before accessing any SharedPreferences data.
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  /// Set a string value for a given key in the SharedPreferences
  /// Return true if the operation success
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  /// Set a boolean value for a given key in the SharedPreferences
  /// Return true if the operation success
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  /// Set a list of string for a given key in the SharedPreferences
  /// Return true if the operation success
  Future<bool> setList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  /// Get a String value by key from the SharedPreferences
  /// Return an empty string if the key does not exist
  String getString(String key) {
    return _prefs.getString(key) ?? "";
  }

  /// Get a boolean value by key from the SharedPreferences
  /// Return false if the key does not exist
  bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  /// Get a list of strings by the key from the SharedPreferences
  /// Return an empty list if the key does not exist
  List<String> getList(String key) {
    return _prefs.getStringList(key) ?? [];
  }

  /// Remove a value by key from the SharedPreferences
  /// Return true if the operation success
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
}
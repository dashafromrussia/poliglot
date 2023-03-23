/*import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const cookieId = 'cookie_id';
}
abstract class AppCookieData{
  Future<String?> getSessionId();
  Future<void> setSessionId(String value);
  Future<void> deleteSessionId();

}

class AppCookieDataProvider implements AppCookieData{
  static const _secureStorage = FlutterSecureStorage();

@override
  Future<String?> getSessionId() => _secureStorage.read(key: _Keys.cookieId);

  @override
  Future<void> setSessionId(String value) {
    return _secureStorage.write(key: _Keys.cookieId, value: value);
  }

  @override
  Future<void> deleteSessionId() {
    return _secureStorage.delete(key: _Keys.cookieId);
  }

}*/

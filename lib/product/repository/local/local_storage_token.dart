import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../network/model/token/token_model.dart';

class LocalStorageToken {
  final _storageSecure = const FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static const String _keyToken = "token";

  Future<void> setToken(TokenModel token) async {
    await _storageSecure.write(key: _keyToken, value: token.token);
  }

  Future<String> getToken() async {
    return await _storageSecure.read(key: _keyToken) ?? "";
  }
}

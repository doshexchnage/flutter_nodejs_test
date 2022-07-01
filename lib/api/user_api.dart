import '../mixin/http_middleware.dart';
import '../models/user_model.dart';

abstract class AuthApi {
  Future<User> login(encodedParams);
  Future<User> signup(encodedParams);
}

class UseAuthApi extends HttpMiddleware implements AuthApi {
  @override
  Future<User> login(encodedParams) async {
    final response = await withPost('auth/login', encodedParams);
    if (response['success']) {
      return User.fromJson(response['data']);
    }
    throw response['message'];
  }

  @override
  Future<User> signup(encodedParams) async {
    final response = await withPost('auth/signup', encodedParams);
    if (response['success']) {
      return User.fromJson(response['data']);
    }
     throw response['message'];
  }
}

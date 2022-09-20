import 'package:note_sharing_project/models/user_model.dart';

class AuthModule {
  static final AuthModule _singleton = AuthModule._internal();
  factory AuthModule() => _singleton;
  AuthModule._internal();
  static AuthModule get shared => _singleton;

  UserModel? userModel;
}

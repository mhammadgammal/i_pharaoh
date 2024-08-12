
class BaseParameter {}

class LoginParameter extends BaseParameter {
  late String email;
  late String password;

  LoginParameter({
    required this.email,
    required this.password,
  });
}

class RegisterParameter extends BaseParameter {
  late String name;
  late String email;
  late String password;

  RegisterParameter({
    required this.name,
    required this.email,
    required this.password,
  });
}

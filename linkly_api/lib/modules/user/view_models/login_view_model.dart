
import 'package:dart_application/application/exceptions/request_validation_exception.dart';
import 'package:dart_application/application/helpers/request_mapping.dart';

class LoginViewModel extends RequestMapping{
  late String login;
  String? password;
  late bool socialLogin;
  late bool supplierUser;
  // String? avatar;
  // String? socialType;
  // String? socialKey;

  LoginViewModel(String dataRequest) : super(dataRequest);

  @override
  void map() {
    login = data['login'];
    password = data['password'];
    socialLogin = data['social_login'];
    supplierUser = data['supplier_user'];
    // avatar = data['avatar'];
    // socialType = data['social_type'];
    // socialKey = data['social_key'];
  }

  //   void loginEmailValidate() {
  //   final errors = <String, String>{};

  //   if (password == null) {
  //     errors['password'] = 'required';
  //   }

  //   if (errors.isNotEmpty) {
  //     throw RequestValidationException(errors);
  //   }
  // }

  // void loginSocialValidate() {
  //   final errors = <String, String>{};

  //   if (socialType == null) {
  //     errors['social_type'] = 'required';
  //   }

  //   if (socialKey == null) {
  //     errors['social_key'] = 'required';
  //   }

  //   if (errors.isNotEmpty) {
  //     throw RequestValidationException(errors);
  //   }
  // }
}
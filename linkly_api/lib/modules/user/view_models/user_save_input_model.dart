// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dart_application/application/helpers/request_mapping.dart';

class UserSaveInputModel extends RequestMapping {
  late String email;
  late String password;
  int? supplierId;

  UserSaveInputModel({required this.email, required this.password, this.supplierId})
      : super.empty();

  UserSaveInputModel.requestMapping(String dataRequest) : super(dataRequest);

  @override
  void map() {
    email = data['email'];
    password = data['password'];
    print('Email: $email\nSenha: $password');
  }
}

import 'package:edu_app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../services/postServices.dart';
import 'package:edu_app/widgets/alertKsm.dart';
import 'package:go_router/go_router.dart';


class RegisterController extends GetxController {

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  
  Future<void> loginUser(BuildContext context) async {
    context.go('/login');
  }

  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final fullname = fullNameController.text;
    final username = usernameController.text;
    final password = passwordController.text;


    final req = UserModel(user_id: username, password: password, full_name: fullname);
    
    try {
      final response = await ApiServiceForm.postModel(
        endpoint: 'register_emo_land',
        data: req.toJson(),
        fromJson: (json) => UserModel.fromJson(json),
      );

      if (response.status == true) {
        context.go('/login');
      } else {
        AlertKsm.show(
          context: context,
          title: 'Info!',
          message: response.message,
          type: AlertType.info,
        );
      }
    
    } catch (e) {
      AlertKsm.show(
        context: context,
        title: 'Failed!',
        message: e.toString(),
        type: AlertType.warning,
      );
    } finally {}
    
  }

  

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.onClose();
  }

}

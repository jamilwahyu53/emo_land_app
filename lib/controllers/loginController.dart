import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../services/postServices.dart';
import 'package:edu_app/widgets/alertKsm.dart';
import 'package:go_router/go_router.dart';


class LoginController extends GetxController {

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  
  Future<void> forgotPass(BuildContext context) async {
    context.go('/forgotPass');
  }

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final username = usernameController.text;
    final password = passwordController.text;


    context.go('/playForm');

    //final req = Staffs(Username: username, Password: password);
    /*
    try {
      /*
      final response = await ApiService.postModel<Staffs>(
        endpoint: '/Login',
        data: req.toJson(),
        fromJson: (json) => Staffs.fromJson(json),
      );
      */
       final response = await ApiServiceForm.postModel(
        endpoint: 'login/',
        data: {
          "username": username,
          "password": password,
        },
        fromJson: (json) => Staff_Vr.fromJson(json),
      );

      //if (response.status == 'Success') {
      if (response.status == 'Success') {
        //await storage.saveStaff(response.data!);
        print(response.data);
        /*
        final getStorage = await storage.getStaff();
        print(getStorage?.Username);
        print(getStorage?.Password);

        //await storage.clear();

        print(
          'Login berhasil, token: ${response.data?.token}, name: ${response.data?.Username}',
        );
        */
        /*
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => Dashboard()));
        */
        context.go('/dashboardVr');
      } else {
        AlertKsm.show(
          context: context,
          title: 'Info!',
          message: 'Gagal Ambil Data',
          type: AlertType.info,
        );
      }
    } catch (e) {
      //print("error e");
      //print(e.toString());
      AlertKsm.show(
        context: context,
        title: 'Failed!',
        message: e.toString(),
        type: AlertType.warning,
      );
    } finally {}
    */
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

}

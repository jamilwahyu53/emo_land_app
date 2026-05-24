import 'package:flutter/material.dart';
import 'package:edu_app/widgets/buttonKsm.dart';
import 'package:edu_app/widgets/generalField.dart';
import 'package:edu_app/widgets/textLink.dart';
import '../controllers/loginController.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {

  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key}); //digunakan untuk validasi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: 
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_login.png'),
            fit: BoxFit.cover,
          ),
        ),
      child: SafeArea(
          //agar tidak tertutup status bar
          child: Center(
            child: SingleChildScrollView(
              //bisa scroll saat keyboard muncul
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ), //dan sizebox agar ada spasi antar element
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icon_emo_land.png',
                          width: 200,
                          fit: BoxFit.contain,
                        ),

                        Text(
                          'Masuk Ke Akun',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 32),

                    // Email Field
                    GeneralField(
                      label: "Namamu",
                      icon: Icons.account_circle_outlined,
                      controller: controller.usernameController,
                    ),
                    GeneralField(
                      label: "Sandi",
                      icon: Icons.lock_clock_outlined,
                      isPassword: true,
                      controller: controller.passwordController,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextLink(
                          text: 'Register',
                          onTap: () => controller.registerStaff(context),
                        ),

                        TextLink(
                          text: 'Lupa Kata Sandi?',
                          onTap: () => controller.forgotPass(context),
                        ), 
                      ],
                    ),

                    SizedBox(height: 32),

                    // Tombol Login
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => controller.login(context),
                        child: Image.asset(
                          'assets/btn_next.png',
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    //SizedBox(height: 32),
                    //StatusWidget(count: 1240, label: "Pengguna Aktif")

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

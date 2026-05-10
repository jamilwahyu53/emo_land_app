import 'package:flutter/material.dart';
import 'package:edu_app/widgets/buttonKsm.dart';
import 'package:edu_app/widgets/generalField.dart';
import 'package:edu_app/widgets/textLink.dart';
import '../controllers/loginController.dart';
import 'package:get/get.dart';

class Forgotpass extends StatelessWidget {

  Forgotpass({super.key}); //digunakan untuk validasi

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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icon_emo_land.png',
                          width: 150,
                          height: 150,
                        ),

                        const SizedBox(height: 10),

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
                      label: "Kode Akses",
                      icon: Icons.key_off_outlined,
                    ),
                    GeneralField(
                      label: "Type Password",
                      icon: Icons.lock_clock_outlined,
                      isPassword: true,
                    ),
                    GeneralField(
                      label: "Re-Type Password",
                      icon: Icons.lock_clock_outlined,
                      isPassword: true,
                    ),

                    SizedBox(height: 32),

                    // Tombol Login
                    CustomButton(
                      label: "Reset Password",
                      widthBtn: double.infinity,
                      onPressed: () => Null,
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

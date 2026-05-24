import 'package:flutter/material.dart';
import 'package:edu_app/widgets/buttonKsm.dart';
import 'package:edu_app/widgets/generalField.dart';
import 'package:edu_app/widgets/textLink.dart';
import 'package:go_router/go_router.dart';
import '../controllers/loginController.dart';
import 'package:get/get.dart';

class PlayForm extends StatelessWidget {

  PlayForm({super.key}); //digunakan untuk validasi

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
            image: AssetImage('assets/bg_play.png'),
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
                    Text(
                      'SELAMAT',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'DATANG',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 45,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Temani perjalananmu mengenal emosi dan dirimu sendiri. Main, belajar dan tumbuh bersama!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 120),

                    // Tombol Login
                    CustomButton(
                      label: "PLAY",
                      widthBtn: double.infinity,
                      onPressed: () => context.go('/playingMode'),
                    ),

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

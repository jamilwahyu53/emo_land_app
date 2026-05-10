import 'package:flutter/material.dart';
import 'package:edu_app/widgets/buttonKsm.dart';
import 'package:edu_app/widgets/generalField.dart';
import 'package:edu_app/widgets/textLink.dart';
import 'package:get/get.dart';

class PlayingMode extends StatelessWidget {

  PlayingMode({super.key}); //digunakan untuk validasi

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
            image: AssetImage('assets/bg_select_menu.png'),
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
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Temani perjalananmu mengenal emosi dan dirimu sendiri. Main, belajar dan tumbuh bersama!',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 32),

                    // Tombol Login
                    CustomButton(
                      label: "PLAY",
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

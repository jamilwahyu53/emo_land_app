import 'package:edu_app/controllers/playingModeController.dart';
import 'package:edu_app/widgets/alertKsm.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/widgets/buttonKsm.dart';
import 'package:edu_app/widgets/generalField.dart';
import 'package:edu_app/widgets/textLink.dart';
import 'package:edu_app/widgets/playMode.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PlayingMode extends GetView<PlayingModeController>  {

  PlayingMode({super.key}); 

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
                      'Pilih Metode',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'PERMAINAN',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: 32),

                    // Tombol Login
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [

                          // CARD KIRI
                          Expanded(
                            child: Material(
                              color: const Color(0xFFFFE1E4),
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  PlayMode.show(
                                    context: context,
                                    title: "LEVEL",
                                    message: "Pilih Level Permainan",
                                    type: AlertType.info,

                                    primaryButtonText: "EASY",
                                    secondaryButtonText: "HARD",

                                    onPrimaryPressed: () {
                                      context.go(
                                        '/videoMode',
                                        extra: {
                                          'mode': "easy",
                                          'stage': 1,
                                        },
                                      );
                                    },

                                    onSecondaryPressed: () {
                                      context.go(
                                        '/videoMode',
                                        extra: {
                                          'mode': "hard",
                                          'stage': 1,
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFE1E4),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/book.png',
                                        height: 60,
                                        width: 90,
                                      ),

                                      const SizedBox(height: 12),

                                      Text(
                                        'STORY\nMODE',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      Text(
                                        'Ikuti cerita rakyat dan Selesaikan tantangannya',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black54,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // CARD KANAN
                          Expanded(
                            child: Material(
                              color: const Color(0xFFFFE1E4),
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                   context.go('/detectionMode');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFE1E4),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/target.png',
                                        height: 60,
                                        width: 60,
                                      ),

                                      const SizedBox(height: 12),

                                      Text(
                                        'DETECTION MODE',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      Text(
                                        'Latihan ekspresi dan tingkatkan kemampuanmu',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black54,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

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

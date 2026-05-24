import 'package:flutter/material.dart';
import 'package:edu_app/widgets/generalField.dart';
import 'package:edu_app/widgets/buttonKsm.dart';
import 'package:get/get.dart';
import '../controllers/videoController.dart';

class UpsertVideo extends StatelessWidget {

  final VideoController controller = Get.put(VideoController());

  UpsertVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Slate 50
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                // 1. Title & Description
                const Text(
                  'Tambah Video',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    fontFamily: 'IntroHeadR-Base',
                    height: 1.1,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 32),

                // 2. Main Form Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Nama Lengkap
                      GeneralField(
                        label: 'URL',
                        controller: controller.urlController,
                        hint: 'Masukkan URL',
                        icon: Icons.link_off_outlined,
                      ),

                      // Posisi
                      GeneralField(
                        label: 'Grade',
                        controller: controller.gradeController,
                        hint: 'Contoh: HARD',
                        icon: Icons.work_outline_rounded,
                      ),

                      
                      const SizedBox(height: 24),
                     
                      CustomButton(
                      label: "Simpan Video",
                      widthBtn: double.infinity,
                      onPressed: () => controller.upsertVideo(context)
                    ),
                      
                    ],
                  ),
                ),

                
                const SizedBox(height: 100), // Space for bottom bar
              ],
            ),
          ),
        ),
      ),
      
    );
  }

}


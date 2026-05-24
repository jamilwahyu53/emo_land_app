import 'package:flutter/material.dart';
import 'package:edu_app/widgets/generalField.dart';
import 'package:edu_app/widgets/buttonKsm.dart';
import '../controllers/registerController.dart';
import 'package:get/get.dart';
import 'package:edu_app/widgets/textLink.dart';


class RegisterStaff extends StatelessWidget {

  final RegisterController controller = Get.put(RegisterController());

  RegisterStaff({super.key});

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
                  'Registrasi User\nBaru',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    fontFamily: 'IntroHeadR-Base',
                    height: 1.1,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Lengkapi informasi di bawah ini untuk menambahkan anggota tim baru ke dalam sistem.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF64748B),
                    fontFamily: 'IntroHeadR-Base',
                    height: 1.5,
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
                        label: 'NAMA LENGKAP',
                        controller: controller.fullNameController,
                        hint: 'Masukkan nama lengkap staff',
                        icon: Icons.person_outline_rounded,
                      ),

                      // Posisi
                      GeneralField(
                        label: 'User ID',
                        controller: controller.usernameController,
                        hint: 'Contoh: user_123',
                        icon: Icons.work_outline_rounded,
                      ),

                      
                      // Nomor Telepon
                      GeneralField(
                        label: 'Password',
                        controller: controller.passwordController,
                        isPassword: true,
                        icon: Icons.key_outlined,
                      ),

                      TextLink(
                        text: 'Login',
                        onTap: () => controller.loginUser(context),
                      ),

                      const SizedBox(height: 24),
                     
                      CustomButton(
                      label: "Simpan User",
                      widthBtn: double.infinity,
                      onPressed: () => controller.register(context)
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


import 'package:flutter/material.dart';
import 'package:edu_app/widgets/generalField.dart';
import 'package:edu_app/widgets/buttonKsm.dart';

class RegisterStaff extends StatefulWidget {
  const RegisterStaff({super.key});

  @override
  State<RegisterStaff> createState() => _RegisterStaffState();
}

class _RegisterStaffState extends State<RegisterStaff> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk setiap field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedDivision = 'Pilih Divisi';
  final List<String> _divisions = [
    'Pilih Divisi',
    'Product Design',
    'Engineering',
    'Human Resources',
    'Marketing',
    'Finance',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Slate 50
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                // 1. Title & Description
                const Text(
                  'Registrasi Staff\nBaru',
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
                        controller: _nameController,
                        hint: 'Masukkan nama lengkap staff',
                        icon: Icons.person_outline_rounded,
                      ),

                      // Posisi
                      GeneralField(
                        label: 'POSISI',
                        controller: _positionController,
                        hint: 'Contoh: Senior Analyst',
                        icon: Icons.work_outline_rounded,
                      ),

                      // Divisi (Dropdown)
                      _buildLabel('DIVISI'),
                      _buildDivisionDropdown(),
                      const SizedBox(height: 16),

                      // Email Perusahaan
                      GeneralField(
                        label: 'EMAIL PERUSAHAAN',
                        controller: _emailController,
                        hint: 'nama@nexus.com',
                        icon: Icons.alternate_email_rounded,
                      ),

                      // Nomor Telepon
                      GeneralField(
                        label: 'NOMOR TELEPON',
                        controller: _phoneController,
                        hint: '+62 8xx xxxx xxxx',
                        icon: Icons.phone_android_rounded,
                      ),

                      const SizedBox(height: 24),

                     
                      CustomButton(
                      label: "Simpan Staff",
                      widthBtn: double.infinity,
                      onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Logic simpan data
                            print('Staff Berhasil Didaftarkan');
                          }
                        },
                    ),
                      
                      const SizedBox(height: 24),
                      const Center(
                        child: Text(
                          'JW MANAGEMENT SYSTEM',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF94A3B8),
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 3. Info Box
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBF3FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_rounded, color: Color(0xFF1A73E8), size: 24),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informasi Penting',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Akun staff baru akan secara otomatis mendapatkan kredensial login yang dikirimkan melalui email perusahaan yang didaftarkan.',
                              style: TextStyle(
                                color: Color(0xFF475569),
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
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


  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A73E8),
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildDivisionDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDivision,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B)),
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: 'IntroHeadR-Base',
          ),
          onChanged: (String? newValue) {
            setState(() {
              _selectedDivision = newValue!;
            });
          },
          items: _divisions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  
}

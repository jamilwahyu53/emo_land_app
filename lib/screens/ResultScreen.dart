import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../controllers/ResultController.dart';

class ResultScreen extends GetView<ResultController> {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.isLoading.value == true) {
          return const Center(child: CircularProgressIndicator());
        }

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg_select_menu.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ==== CARD PROFILE ====
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE1E4),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'PROFILE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Image.asset(
                            'assets/icon_emo_land.png',
                            height: 120,
                            width: 180,
                          ),

                          const SizedBox(height: 24),

                          Obx(() {
                            return Text(
                              'Nama : ${controller.fullName.value.isEmpty ? '-' : controller.fullName.value}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),

                          const SizedBox(height: 12),

                          Obx(() {
                            return Text(
                              'Bintang : ${controller.averageStars.value.isEmpty ? '-' : controller.averageStars.value}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),

                          const SizedBox(height: 18),

                          const Text(
                            'Teruslah belajar ekspresi hingga kamu memperoleh bintang yang lebih banyak lagi!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black54,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    Obx(() {
                      if (controller.stages.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 18,
                            headingTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            columns: const [
                              DataColumn(label: Text('Stage')),
                              DataColumn(label: Text('Mode')),
                              DataColumn(label: Text('Value')),
                              DataColumn(label: Text('Tanggal')),
                            ],
                            rows: controller.stages.map((stage) {
                              return DataRow(
                                cells: [
                                  DataCell(Text('${stage['stage'] ?? '-'}')),
                                  DataCell(Text('${stage['mode'] ?? '-'}')),
                                  DataCell(Text('${stage['value'] ?? '-'}')),
                                  DataCell(
                                    Text('${stage['created_at'] ?? '-'}'),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8A9B),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () {
                          context.go('/playForm');
                          Get.delete<ResultController>(force: true);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back),
                            SizedBox(width: 8),
                            Text(
                              'KEMBALI',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

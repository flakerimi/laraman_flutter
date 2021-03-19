import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/helpers/numeric_step_button.dart';
import 'package:laraman/modules/home/views/index.dart';
import 'package:laraman/modules/payment/models/payment.dart';
import 'package:laraman/partials/header.dart';

class SelectInstallment extends StatelessWidget {
  final Payment payment = Get.arguments;
  final installments = 0.obs;
  final installmentValue = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Obx(
        () => Column(
          children: [
            Text(
              'Zgjedh numrin e kesteve',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            NumericStepButton(
              minValue: 1,
              maxValue: 24,
              onChanged: (value) {
                installments.value = value;
                installmentValue.value =
                    (payment.amount / value) + ((payment.amount / value) * 0.2);
              },
            ),
            Text('Vlera Totale: ' + payment.amount.toString()),
            Text('Vlera e kestit: ' + installmentValue.value.toString()),
            Spacer(),
            ElevatedButton(
                onPressed: () => Get.to(() => HomeIndex()),
                child: Text('Merre me Keste')),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

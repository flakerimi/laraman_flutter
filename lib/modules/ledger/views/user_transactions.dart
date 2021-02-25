import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:laraman/modules/ledger/controllers/ledger_controller.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';

class UserTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Header(),
      drawer: LeftDrawer(),
      endDrawer: RightDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetX<LedgerController>(
              init: LedgerController(),
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.trans.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Number: ${controller.trans[index]}'),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}

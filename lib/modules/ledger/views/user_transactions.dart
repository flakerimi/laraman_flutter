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
            builder: (LedgerController controller) {
              if (controller != null) {
                return ListView.builder(
                    itemCount: controller.trans.value.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(
                            controller.trans.value[index].merchantLogo),
                        title: Text(
                          '${controller.trans.value[index].merchantName}',
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                            '${controller.trans.value[index].description}'),
                        trailing: Text(
                          "${controller.trans.value[index].fromAmount.toString()}€",
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

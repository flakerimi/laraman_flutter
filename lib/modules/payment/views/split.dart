import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/controllers/friendship_controller.dart';
import 'package:laraman/partials/header.dart';

class Split extends StatelessWidget {
  final FriendController controller =
      Get.put<FriendController>(FriendController());
  final TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GetX<FriendController>(
              init: FriendController(),
              initState: (_) {},
              builder: (controller) {
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children:
                      controller.checkedData.entries.map<Widget>((friend) {
                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(friend.value.firstName),
                          Spacer(),
                          Expanded(
                            child: TextField(
                              controller: text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(), labelText: '1'),
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

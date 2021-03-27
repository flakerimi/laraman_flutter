import 'package:cssgg/cssgg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/controllers/friendship_controller.dart';
import 'package:laraman/modules/friendship/models/friend.dart';
import 'package:laraman/modules/friendship/views/friend.dart';
import 'package:laraman/modules/friendship/views/requests.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';

class FriendsIndex extends StatelessWidget {
  final FriendController friendsController =
      Get.put<FriendController>(FriendController());

  final _phoneController = TextEditingController();
  final isSelected = RxList<bool>([false, true]);

  @override
  Widget build(BuildContext context) {
    print(isSelected.toList());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Header(),
      drawer: LeftDrawer(),
      endDrawer: RightDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  'Friends',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Get.defaultDialog(
                          actions: [
                            IconButton(
                                icon: Icon(Icons.check),
                                onPressed: () {
                                  friendsController
                                      .makeRequest(_phoneController.text);
                                })
                          ],
                          title: 'Add New Friend',
                          content: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: 'Enter friend phone',
                                hintText: '+38349000222'),
                          ));
                    }),
                IconButton(
                  icon: Icon(Icons.turned_in),
                  onPressed: () => Get.to(
                    () => FriendRequests(),
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Center(
            child: Obx(
              () => ToggleButtons(
                borderWidth: 1,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                selectedColor: Colors.white,
                selectedBorderColor: Colors.white,
                fillColor: Colors.indigo,
                children: <Widget>[
                  Text(
                    'All',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Requests',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
                onPressed: (int index) {
                  for (int buttonIndex = 0;
                      buttonIndex < isSelected.length;
                      buttonIndex++) {
                    print(isSelected[index]);

                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = true;
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                },
                isSelected: isSelected.length != 0 ? isSelected : [true, false],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: FutureBuilder<List<Friend>>(
              future: friendsController.getFriends(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: snapshot.data
                        .map(
                          (doc) => ListTile(
                            /* leading: SizedBox(
                              width: 50,
                              child: PrettyQr(
                                data: "laraman://" + doc.uid,
                                size: 100,
                                image: AssetImage('assets/images/l.png'),
                                typeNumber: 3,
                                errorCorrectLevel: QrErrorCorrectLevel.M,
                              ),
                            ), */
                            title: Text(doc.firstName + ' ' + doc.lastName),
                            subtitle: Text(doc.phoneNumber),
                            trailing: Icon(
                              CssGG.abstract_icon,
                              size: 30,
                            ),
                            onTap: () => Get.to(FriendView(),
                                transition: Transition.rightToLeft,
                                arguments: doc),
                          ),
                        )
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Its Error! Refresh');
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/helpers/global.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr/qr.dart';
import 'package:laraman/modules/friendship/controllers/friendship_controller.dart';
import 'package:laraman/modules/friendship/models/friend.dart';
import 'package:laraman/modules/friendship/views/friend.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class FriendsIndex extends StatelessWidget {
  final int selectedPage;
  FriendsIndex(this.selectedPage);
  final FriendController friendsController =
      Get.put<FriendController>(FriendController());

  final _phoneController = TextEditingController();

  scan() async {
    var status = await Permission.camera.status;
    print(status);
    if (status.isGranted) {
      var scanResults = await Helper().scan();
      //print(scanResults);
      var scanData = await Helper().stringToUri(scanResults);

      Friend user = await friendsController
          .getFriendByUid(scanData.queryParameters['id']);
      Get.to(() => FriendView(), arguments: user);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                }),
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
                    icon: Icon(Icons.qr_code),
                    onPressed: () {
                      scan();
                    })
              ],
            ),
          ),
          DefaultTabController(
            initialIndex: selectedPage,
            length: 2,
            child: Expanded(
              child: Column(
                children: <Widget>[
                  TabBar(
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          'All',
                          style: TextStyle(color: Colors.indigo),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Requests',
                          style: TextStyle(color: Colors.indigo),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: double.infinity,
                          ),
                          child: Padding(
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
                                            leading: SizedBox(
                                              width: 50,
                                              child: PrettyQr(
                                                data: "laraman://user?id=" +
                                                    doc.uid,
                                                size: 100,
                                                typeNumber: 5,
                                                elementColor: Colors.indigo,
                                                errorCorrectLevel:
                                                    QrErrorCorrectLevel.M,
                                              ),
                                            ),
                                            title: Text(doc.firstName +
                                                ' ' +
                                                doc.lastName),
                                            subtitle: doc.status == 'accepted'
                                                ? Text(doc.phoneNumber)
                                                : Text(doc.status),
                                            trailing: Icon(
                                              Icons
                                                  .keyboard_arrow_right_outlined,
                                              size: 30,
                                            ),
                                            onTap: () => Get.to(
                                                () => FriendView(),
                                                transition:
                                                    Transition.rightToLeft,
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
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: FutureBuilder<List<Friend>>(
                              future: friendsController.getFriendRequests(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Its Error! Refresh');
                                } else if (snapshot.data.length == 0) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('No friend Requests'),
                                    ],
                                  );
                                } else {
                                  return ListView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    children: snapshot.data
                                        .map(
                                          (doc) => ListTile(
                                            leading: SizedBox(
                                              width: 50,
                                              child: PrettyQr(
                                                data: "laraman://" + doc.uid,
                                                size: 100,
                                                elementColor: Colors.indigo,
                                                typeNumber: 3,
                                                errorCorrectLevel:
                                                    QrErrorCorrectLevel.M,
                                              ),
                                            ),
                                            title: Text(doc.firstName +
                                                ' ' +
                                                doc.lastName),
                                            subtitle: Text(doc.phoneNumber),
                                            trailing: Container(
                                              width: 114,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                      icon:
                                                          Icon(Icons.thumb_up),
                                                      color: Colors.green,
                                                      onPressed: () =>
                                                          FriendController
                                                              .acceptFriend(
                                                                  doc.uid)),
                                                  IconButton(
                                                      icon: Icon(
                                                          Icons.thumb_down),
                                                      color: Colors.red,
                                                      onPressed: () =>
                                                          FriendController
                                                              .rejectFriend(
                                                                  doc.uid)),
                                                ],
                                              ),
                                            ),
                                            onTap: () => Get.to(FriendView(),
                                                transition:
                                                    Transition.rightToLeft,
                                                arguments: doc),
                                          ),
                                        )
                                        .toList(),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

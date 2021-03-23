import 'package:flutter/material.dart';
import 'package:qr/qr.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/controllers/friendship_controller.dart';
import 'package:laraman/modules/friendship/models/friend.dart';
import 'package:laraman/modules/friendship/views/friend.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class FriendRequests extends StatelessWidget {
  final FriendController friendsController =
      Get.put<FriendController>(FriendController());

  Future<List<Friend>> _refreshData() async {
    return await friendsController.getFriendRequests();
    //_data.clear();
    //_data.addAll(FriendService().getFriendRequests());
  }

  final _phoneController = TextEditingController();

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
                  'Friend Requests',
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
                      ),
                    );
                  },
                ),
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
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: FutureBuilder<List<Friend>>(
              future: _refreshData(),
              builder: (context, snapshot) {
                print(snapshot.data.length);
                if (snapshot.data.length != 0) {
                  return RefreshIndicator(
                    color: Colors.green,
                    onRefresh: _refreshData,
                    child: ListView(
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
                                  image: AssetImage('assets/images/l.png'),
                                  typeNumber: 3,
                                  errorCorrectLevel: QrErrorCorrectLevel.M,
                                ),
                              ),
                              title: Text(doc.firstName + ' ' + doc.lastName),
                              subtitle: Text(doc.phoneNumber),
                              trailing: Container(
                                width: 114,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.thumb_up),
                                        color: Colors.green,
                                        onPressed: () =>
                                            FriendController.acceptFriend(
                                                doc.uid)),
                                    IconButton(
                                        icon: Icon(Icons.thumb_down),
                                        color: Colors.red,
                                        onPressed: () =>
                                            FriendController.rejectFriend(
                                                doc.uid)),
                                  ],
                                ),
                              ),
                              onTap: () => Get.to(FriendView(),
                                  transition: Transition.rightToLeft,
                                  arguments: doc),
                            ),
                          )
                          .toList(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Its Error! Refresh');
                } else if (snapshot.data.length == 0) {
                  return Center(
                      child: Column(
                    children: [
                      Text('No friend Requests'),
                      ElevatedButton(
                          onPressed: () => Get.back(), child: Text('Back'))
                    ],
                  ));
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

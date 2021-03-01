import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/controllers/friendship_controller.dart';
import 'package:laraman/modules/friendship/models/friendship.dart';
import 'package:laraman/modules/friendship/views/friend.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';

class FriendsView extends StatelessWidget {
  final FriendController controller =
      Get.put<FriendController>(FriendController());
  Future<List<Friend>> _refreshData() async {
    return await controller.getFriendRequests();
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
                                  FriendController.makeRequest(
                                      _phoneController.text);
                                })
                          ],
                          title: 'Add New Friend',
                          content: TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                                labelText: 'Enter friend phone',
                                hintText: '+38349000222'),
                          ));
                    })
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: FutureBuilder<List<Friend>>(
              future: _refreshData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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
                                child: SvgPicture.string(
                                  doc.qrSvg,
                                ),
                              ),
                              title: Text(doc.firstName + ' ' + doc.lastName),
                              subtitle: Text(doc.phoneNumber),
                              trailing: Icon(Icons.account_box),
                              onTap: () => Get.to(FriendView(),
                                  transition: Transition.rightToLeft,
                                  arguments: doc.toJson()),
                            ),
                          )
                          .toList(),
                    ),
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

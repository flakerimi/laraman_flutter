import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/controllers/friendship_controller.dart';
import 'package:laraman/modules/friendship/models/friendship.dart';
import 'package:laraman/partials/header.dart';
import 'package:laraman/partials/left_drawer.dart';
import 'package:laraman/partials/right_drawer.dart';

class FriendsView extends StatelessWidget {
  Future<List<Friend>> _refreshData() async {
    return await FriendController().getFriendRequests();
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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
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
            FutureBuilder<List<Friend>>(
              future: _refreshData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                    color: Colors.green,
                    onRefresh: _refreshData,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0.0),
                      children: snapshot.data
                          .map(
                            (doc) => ListTile(
                              leading: SvgPicture.string(
                                doc.qrSvg,
                                width: 50,
                                height: 50,
                              ),
                              title: Text(doc.firstName.toString() +
                                  ' ' +
                                  doc.lastName),
                              subtitle: Text(doc.phoneNumber),
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
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/controllers/friendship_controller.dart';
import 'package:laraman/modules/friendship/models/friendship.dart';
import 'package:laraman/modules/payment/views/split.dart';
import 'package:laraman/partials/header.dart';

class SelectFriends extends StatelessWidget {
  final FriendController controller =
      Get.put<FriendController>(FriendController());

  @override
  Widget build(BuildContext context) {
    TextEditingController scontroller = new TextEditingController();

    List<Friend> _searchResult = [];
    RxList _userDetails = [].obs;
    Future<List<Friend>> _refreshData() async {
      controller.getFriendRequests().then((value) => value);
      return await controller.getFriendRequests();
      //_data.clear();
    }

    controller.isChecked.clear();
    _refreshData();
    onSearchTextChanged(String text) async {
      _searchResult.clear();
      print('ud' + _userDetails.toString());
      if (text.isEmpty) {
        return _userDetails;
      }
      _userDetails.forEach((userDetail) {
        print(userDetail);
        if (userDetail.firstName.contains(text) ||
            userDetail.lastName.contains(text)) _searchResult.add(userDetail);
      });
      print('s' + _searchResult.toString());
    }

    print(controller.isChecked.isBlank);
    return Scaffold(
      appBar: Header(),
      floatingActionButton: addButton(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: scontroller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      scontroller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            child: FutureBuilder<List<Friend>>(
              future: _refreshData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(() => CheckboxListTile(
                              title: Text(snapshot.data[index].firstName +
                                  ' ' +
                                  snapshot.data[index].lastName),
                              subtitle: Text(snapshot.data[index].phoneNumber),
                              onChanged: (value) {
                                controller.setIsChecked(
                                    snapshot.data[index].uid, value);
                                controller.setCheckedData(
                                    snapshot.data[index].uid,
                                    snapshot.data[index]);
                                //print(controller.checkedData);
                              },
                              value: controller
                                      .isChecked[snapshot.data[index].uid] ??
                                  false,
                            ));
                      });
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

  Widget addButton() {
    // print(controller.isChecked.isBlank);
    return Obx(() => (!controller.isChecked.isBlank)
        ? FloatingActionButton(
            onPressed: () {
              print('super');
              print(controller.checkedData);
              Get.to(() => Split());
            },
            child: Text('ADDs'),
          )
        : Text(''));
  }
}

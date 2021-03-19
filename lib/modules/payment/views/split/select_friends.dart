import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/controllers/friendship_controller.dart';
import 'package:laraman/modules/friendship/models/friend.dart';
import 'package:laraman/modules/payment/models/payment.dart';
import 'package:laraman/modules/payment/views/split/split.dart';
import 'package:laraman/partials/header.dart';

class SelectFriends extends StatelessWidget {
  final FriendController controller =
      Get.put<FriendController>(FriendController());

  final Payment payment = Get.arguments;
  final RxMap<dynamic, dynamic> isChecked = {}.obs;
  final RxMap<dynamic, dynamic> checkedData = {}.obs;
  void setIsChecked(index, value) {
    (value == true) ? isChecked[index] = value : isChecked.remove(index);
  }

  void setCheckedData(index, value) {
    (value != null) ? checkedData[index] = value : checkedData.remove(index);
  }

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

    //controller.isChecked.clear();
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
                              if (value == true) {
                                setIsChecked(snapshot.data[index].uid, value);
                                setCheckedData(snapshot.data[index].uid,
                                    snapshot.data[index]);
                              } else {
                                setIsChecked(snapshot.data[index].uid, value);
                                setCheckedData(snapshot.data[index].uid, null);
                              }
                              print('ischecked" ' +
                                  isChecked[snapshot.data[index].uid]
                                      .toString());
                            },
                            value: isChecked[snapshot.data[index].uid] != null
                                ? true
                                : false,
                          ));
                    },
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

  Widget addButton() {
    return Obx(() {
      print('data blank: ' + checkedData.isBlank.toString());
      print('data : ' + checkedData.toString());
      return (!checkedData.isBlank)
          ? FloatingActionButton(
              onPressed: () {
                print('super');
                print(checkedData);
                Get.to(() => Split(),
                    arguments: {"friends": checkedData, "payment": payment});
              },
              child: Text('ADDs'),
            )
          : Text(checkedData.toString());
    });
  }
}

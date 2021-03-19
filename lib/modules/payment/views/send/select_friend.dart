import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/controllers/friendship_controller.dart';
import 'package:laraman/modules/friendship/models/friend.dart';
import 'package:laraman/modules/payment/models/payment.dart';
import 'package:laraman/modules/payment/views/send/send_request.dart';
import 'package:laraman/partials/header.dart';

class SelectFriend extends StatelessWidget {
  final FriendController controller =
      Get.put<FriendController>(FriendController());

  final Payment payment = Get.arguments;
  final isChecked = false.obs;
  final Rx<Friend> selectedUser = Friend().obs;

  setSelectedUser(Friend user) {
    selectedUser.value = user;
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
                      return Obx(
                        () => RadioListTile(
                          value: snapshot.data[index],
                          groupValue: selectedUser.value,
                          title: Text(snapshot.data[index].firstName),
                          subtitle: Text(snapshot.data[index].lastName),
                          onChanged: (currentUser) {
                            print("Current User ${currentUser.firstName}");
                            setSelectedUser(currentUser);
                          },
                          selected: selectedUser.value == snapshot.data[index],
                          activeColor: Colors.green,
                        ),
                      );
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
      print('data blank: ' + selectedUser.isBlank.toString());
      print('data : ' + selectedUser.toString());
      return (!selectedUser.isBlank)
          ? FloatingActionButton(
              onPressed: () {
                print('super');
                print(selectedUser);
                Get.to(() => SendPaymentRequest(), arguments: {
                  "friend": selectedUser.value,
                  "payment": payment
                });
              },
              child: Text('ADDs'),
            )
          : Text(selectedUser.toString());
    });
  }
}

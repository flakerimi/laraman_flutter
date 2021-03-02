import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/controllers/friendship_controller.dart';
import 'package:laraman/modules/friendship/models/friendship.dart';
import 'package:laraman/partials/header.dart';

class SplitPayment extends StatelessWidget {
  final FriendController controller = Get.find<FriendController>();

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
                        return CheckboxListTile(
                          title: Text(snapshot.data[index].firstName +
                              ' ' +
                              snapshot.data[index].lastName),
                          subtitle: Text(snapshot.data[index].phoneNumber),
                          onChanged: (value) {
                            controller.isChecked[index].value =
                                value.toString();
                          },
                          value: false,
                        );
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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RxString dropdownValue = 'en_US'.obs;
    TextEditingController limit = TextEditingController();
    TextEditingController timeZoneController = TextEditingController();
    TextEditingController accountTypeController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController countryController = TextEditingController();

    void saveAccount() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        "limit": limit.text,
        "language": dropdownValue.value,
        "timeZone": timeZoneController.text,
        "accountType": accountTypeController.text,
        "city": cityController.text,
        "country": countryController.text,
      });
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) => {
              limit.text = value.data()['limit'].toString(),
              dropdownValue.value = value.data()['language'].toString(),
              timeZoneController.text = value.data()['timeZone'].toString(),
              accountTypeController.text =
                  value.data()['accountType'].toString(),
              cityController.text = value.data()['city'].toString(),
              countryController.text = value.data()['country'].toString(),
            });
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InputDecorator(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                    labelText: 'Language',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: Obx(() => DropdownButton<String>(
                            value: dropdownValue.value,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            onChanged: (String newValue) {
                              print(newValue);
                              dropdownValue.value = newValue;
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: 'en_US',
                                child: Text('English'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'sq_XK',
                                child: Text('Shqip'),
                              ),
                            ])),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: timeZoneController,
                  decoration: InputDecoration(
                    labelText: 'Timezone',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    saveAccount();
                    Get.back();
                  },
                  child: Text('Done'))
            ],
          ),
        ),
      ),
    );
  }
}

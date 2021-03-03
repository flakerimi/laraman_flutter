import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/settings/views/index.dart';
import 'package:laraman/partials/header.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController countryController = TextEditingController();

    void saveAccount() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": emailController.text,
        "address": addressController.text,
        "city": cityController.text,
        "country": countryController.text,
      });
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) => {
              firstNameController.text = value.data()['firstName'].toString(),
              lastNameController.text = value.data()['lastName'].toString(),
              emailController.text = value.data()['email'].toString(),
              addressController.text = value.data()['address'].toString(),
              cityController.text = value.data()['city'].toString(),
              countryController.text = value.data()['country'].toString(),
            });
    return Scaffold(
      appBar: Header(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onChanged: (value) => saveAccount(),
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextFormField(
                  onChanged: (value) => saveAccount(),
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                TextFormField(
                  onChanged: (value) => saveAccount(),
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  onChanged: (value) => saveAccount(),
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                TextFormField(
                  onChanged: (value) => saveAccount(),
                  controller: cityController,
                  decoration: InputDecoration(labelText: 'City'),
                ),
                TextFormField(
                  onChanged: (value) => saveAccount(),
                  controller: countryController,
                  decoration: InputDecoration(labelText: 'Country'),
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.to(SettingsIndex());
                    },
                    child: Text('Done'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

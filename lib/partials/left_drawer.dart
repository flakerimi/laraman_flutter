import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/views/index.dart';
import 'package:laraman/modules/payment/views/user_payments.dart';
import 'package:laraman/modules/subscription/views/index.dart';

class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      decoration: BoxDecoration(
        color: Colors.indigo.shade900,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        /* gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo, Colors.indigoAccent.shade700]), */
        boxShadow: [BoxShadow(blurRadius: 20, color: Colors.indigo.shade400)],
      ),
      padding: EdgeInsets.only(left: 20),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade900,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  selectedTileColor: Colors.amberAccent,
                  onTap: () => Get.to(() => UserPaymentsIndex(),
                      transition: Transition.rightToLeft),
                  leading: Icon(
                    Icons.transform,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                  tileColor: Colors.indigo.shade900,
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    "Pagesat",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  subtitle: Text(
                    "Pagesat e fundit",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade900,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.date_range,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    "Abonimet",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  subtitle: Text(
                    "Abonimet automatike",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onTap: () => Get.to(() => SubscriptionIndex(),
                      transition: Transition.rightToLeft),
                ),
              ),
              /* Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade900,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.date_range,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    "Faturat",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  subtitle: Text(
                    "Kryesisht Mujore",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onTap: () {
                    Get.to(
                      () => {SubscriptionIndex()},
                    );
                  },
                ),
              ), */
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade900,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    "Shokët",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  subtitle: Text(
                    "qe te kerkojne eur",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onTap: () => Get.to(() => FriendsIndex(),
                      transition: Transition.rightToLeft),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade900,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.payments,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    "Kreditë",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  subtitle: Text(
                    "Pagesat me keste",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

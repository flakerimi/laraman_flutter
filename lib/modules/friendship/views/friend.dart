import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FriendView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(color: Colors.indigo),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.string(
              args['qrSvg'],
            ),
            Text(args['firstName'] + ' ' + args['lastName']),
            Text(args['phoneNumber'] + ' / ' + args['email']),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Send'),
                ),
                Spacer(),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 100.0,
                  child: ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () {},
                    child: Text('Request'),
                  ),
                ),
                Spacer(),
              ],
            ),
            Text('')
          ],
        ),
      ),
    );
  }
}

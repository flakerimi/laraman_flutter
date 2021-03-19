import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:laraman/modules/friendship/models/friend.dart';
import 'package:laraman/modules/friendship/views/send/request_money.dart';
import 'package:laraman/modules/friendship/views/send/send_money.dart';

class FriendView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Friend args = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(color: Colors.indigo),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.string(
                args.qrSvg,
                height: 150,
              ),
              Text(args.firstName + ' ' + args.lastName),
              Text(args.phoneNumber + ' / ' + args.email),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.to(() => SendMoney(),
                        arguments: args,
                        transition: Transition.rightToLeftWithFade),
                    child: Text('Send'),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.to(() => RequestMoney(),
                        arguments: args,
                        transition: Transition.rightToLeftWithFade),
                    child: Text('Request'),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

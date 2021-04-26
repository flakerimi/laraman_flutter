import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillDetailIndex extends StatelessWidget {
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
            Hero(
              tag: "logo" + args['index'].toString(),
              child: Image.network(
                args['data']['merchantLogo'],
                width: 200,
              ),
            ),
            Text(args['data']['merchantName']),
            Text(
              'Pagese',
              style: TextStyle(fontSize: 20, color: Colors.indigo),
            ),
            Hero(
              tag: "price" + args['index'].toString(),
              child: Text(
                args['data']['fromAmount'].toString() + '€',
                style: TextStyle(fontSize: 50, color: Colors.indigo),
              ),
            ),
            Text(args['data']['description']),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Rate Merchant'),
                ),
                Spacer(),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 100.0,
                  child: ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () {},
                    child: Text('Request dispute'),
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

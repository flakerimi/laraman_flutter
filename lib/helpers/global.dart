import 'package:qrscan/qrscan.dart' as scanner;

class Helper {
  scan() async {
    String results = await scanner.scan();
    print('Scan:' + results);

    if (results != null) {
      return results;
    } else {
      print('Scan: Empty');
      return results = 'Empty';
    }
  }

  stringToUri(String qrcode) {
    return Uri.parse(qrcode);
  }
}

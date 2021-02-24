import 'package:flutter/material.dart';

import 'partials/header.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: Header(), body: CircularProgressIndicator());
  }
}

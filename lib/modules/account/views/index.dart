import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';

class Login extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    //FocusScope.of(context).unfocus();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              VerticalDivider(),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/l.png',
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'LARAMAN',
                    style: GoogleFonts.rubik(
                      fontSize: 48,
                      color: Colors.indigo,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              VerticalDivider(),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'Shkruani numrin e telefonit dhe shtypeni buttonin login. Pas pak do te pranoni nje sms me kod, qe do ta shkruani ketu per tu loguar.',
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: TextFormField(
                      controller: _phoneController,
                      autofocus: true,
                      focusNode: myFocusNode,
                      decoration: new InputDecoration(
                        labelText: "Shkruaj numrin e telefonit",
                        hintText: '+38349123456',
                        fillColor: Colors.green,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.only(
                              bottomLeft: Radius.circular(30)),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: IconButton(
                      splashColor: Colors.green,
                      icon: Icon(Icons.keyboard_arrow_right_rounded),
                      onPressed: () {
                        AccountController()
                            .verifyPhone(_phoneController, _codeController);
                      },
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

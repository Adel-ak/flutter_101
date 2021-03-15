import 'package:flutter/material.dart';
import '../GStyle.dart';

// class Login extends StatefulWidget {
//   Login({Key key}) : super(key: key);

//   @override
//   _LoginState createState() => _LoginState();
// }

class SignUp extends StatelessWidget {
  final TextEditingController email =
      TextEditingController(text: 'adoolak@gmail.com');
  final TextEditingController password = TextEditingController(text: '123');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
      elevation: 5,
      backgroundColor: Gs().secondaryColor,
      flexibleSpace: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        width: 60,
        height: 60,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, 'profile');
          },
          child: Hero(
            tag: 'dp',
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i1.sndcdn.com/avatars-000587714706-vjdrog-t240x240.jpg'),
            ),
          ),
        ),
      ),
    ));
  }
}

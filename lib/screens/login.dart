import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../GStyle.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email =
      TextEditingController(text: 'adoolak@gmail.com');
  TextEditingController password = TextEditingController(text: 'adel123');
  Map _errors = {};
  bool _loading = false;

  void onLoginIn() async {
    String userEmail = email.text;
    String userPassword = password.text;
    setState(() {
      _errors = {};
      _loading = true;
    });
    try {
      var a = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPassword);
      print(a.user);
      // Navigator.popAndPushNamed(context, 'home');
    } on FirebaseAuthException catch (error) {
      print(error);
      if (error.code == 'wrong-password') {
        setState(() {
          _errors = {'password': 'invalid password'};
        });
      }

      if (error.code == 'user-not-found') {
        setState(() {
          _errors = {'email': 'User not found'};
        });
      }

      if (error.code == 'too-many-requests') {
        setState(() {
          _errors = {
            'other': 'Too many login attempts, try again after a short while'
          };
        });
      }
    } catch (error) {
      print('error ----- $error');
      setState(() {
        _errors = {
          'other': 'Opps! something went wrong, cant login at the momment'
        };
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
        // style: ,
        color: Colors.blue,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Gs().primaryColor,
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  _errors['other'] ?? '',
                  style: TextStyle(color: Colors.red),
                ),
                margin: EdgeInsets.only(bottom: 15),
              ),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: border,
                  border: border,
                  filled: true,
                  errorText: _errors['email'] ?? null,
                  labelText: "Email",
                  alignLabelWithHint: true,
                  fillColor: Colors.white,
                ),
                controller: email,
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        focusedBorder: border,
                        border: border,
                        filled: true,
                        errorText: _errors['password'] ?? null,
                        alignLabelWithHint: true,
                        fillColor: Colors.white,
                        labelText: 'Password'),
                    controller: password,
                    obscureText: true,
                  )),
              _loading
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Gs().secondaryColor),
                      ),
                    )
                  : TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Gs().secondaryColor)),
                      onPressed: () => onLoginIn(),
                      child: Container(
                          width: 100,
                          child: Center(
                              child: Text("Login",
                                  style: TextStyle(color: Gs().textColor)))))
            ],
          )),
    );
  }
}

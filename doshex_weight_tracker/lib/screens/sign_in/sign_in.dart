import 'package:bot_toast/bot_toast.dart';
import 'package:doshex_weight_tracker/components/custom_notification_container.dart';
import 'package:doshex_weight_tracker/models/user.dart';
import 'package:doshex_weight_tracker/provider/services.dart';
import 'package:doshex_weight_tracker/screens/home/home.dart';
import 'package:doshex_weight_tracker/screens/sign_in/sign_in.dart';
import 'package:doshex_weight_tracker/screens/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  static String routeName = "/sign_in";
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String? email;
  String? password;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? _validateEmail(String value) {}

  String? _validatePassword(String value) {
    if (value.length < 6) {
      return 'The Password must be at least 6 characters.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final _authData = Provider.of<ServicesProvider>(context);

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Sign Up'),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SignUp(),
              ),
            );
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        padding: new EdgeInsets.all(20.0),
        child: new Form(
          key: this._formKey,
          child: new ListView(
            children: [
              new TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                    hintText: 'you@example.com', labelText: 'E-mail Address'),
              ),
              new TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: new InputDecoration(
                    hintText: 'Password', labelText: 'Enter your password'),
              ),
              Container(
                color: Colors.blue,
                margin: new EdgeInsets.only(top: 20.0),
                width: screenSize.width,
                child: GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      User loginUser = await _authData.loginAccount(
                          emailController.text, passwordController.text);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    }
                  },
                  child: TextButton(
                    onPressed: null,
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont Have an Account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => SignUp(),
                        ),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

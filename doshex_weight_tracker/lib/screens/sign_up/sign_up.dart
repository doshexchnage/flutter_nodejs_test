import 'package:bot_toast/bot_toast.dart';
import 'package:doshex_weight_tracker/components/custom_notification_container.dart';
import 'package:doshex_weight_tracker/models/user.dart';
import 'package:doshex_weight_tracker/provider/services.dart';
import 'package:doshex_weight_tracker/screens/home/home.dart';
import 'package:doshex_weight_tracker/screens/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static String routeName = "/sign_up";
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String? name;
  String? email;
  String? password;
  String? confirmPassword;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? get _validatePassword {
    final passwordText = passwordController.value.text;
    if (passwordText.isEmpty) {
      return 'Can\'t be empty';
    }
    if (passwordText.length < 6) {
      return 'The Password must be at least 6 characters.';
    }
    return null;
  }

  String? get _validateConfirmPassword {
    final confirmPassText = confirmPasswordController.value.text;
    if (confirmPassText.isEmpty) {
      return 'Can\'t be empty';
    }
    if (confirmPassText.length < 6) {
      return 'The Password must be at least 6 characters.';
    }
    return null;
  }

  var _text = '';

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
                builder: (context) => SignIn(),
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
                controller: nameController,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                    hintText: 'John Doe', labelText: 'Name'),
              ),
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
                    errorText: _validatePassword,
                    hintText: 'Password',
                    labelText: 'Enter your password'),
                onChanged: (text) => setState(() => text),
              ),
              new TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: new InputDecoration(
                    errorText: _validateConfirmPassword,
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password'),
                onChanged: (text) => setState(() => text),
              ),
              Container(
                margin: new EdgeInsets.only(top: 20.0),
                color: Colors.blue,
                width: screenSize.width,
                child: GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }

                    User signUpUser = await _authData.signUp(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  child: const TextButton(
                    onPressed: null,
                    child: Text(
                      'Sign Up',
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
                      "Already Have an Account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => SignIn(),
                        ),
                      ),
                      child: Text(
                        "Sign In",
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

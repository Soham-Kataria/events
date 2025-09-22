import 'package:event_tracker/screens/auth/register.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../home/mainscreen.dart';

class AuthController with ChangeNotifier {

  //Login fields
  var txtLoginEmail = TextEditingController();
  var txtLoginPassword = TextEditingController();
  bool obscureLoginPassword = true;

  //Register fields
  var txtRegisterEmail = TextEditingController();
  var txtRegisterRole = TextEditingController();
  var txtRegisterPhone = TextEditingController();
  var txtRegisterPassword = TextEditingController();
  var txtRegisterConfirmPassword = TextEditingController();
  var txtRegisterName = TextEditingController();
  bool obscureRegisterPassword = true;
  bool obscureRegisterConfirmPassword = true;

  void toggleLoginPasswordVisibility() {
    obscureLoginPassword = !obscureLoginPassword;
    notifyListeners();
  }

  void toggleRegisterPasswordVisibility() {
    obscureRegisterPassword = !obscureRegisterPassword;
    notifyListeners();
  }

  void toggleRegisterConfirmPasswordVisibility() {
    obscureRegisterConfirmPassword = !obscureRegisterConfirmPassword;
    notifyListeners();
  }

  void clearLogin(){
    txtLoginEmail.clear();
    txtLoginPassword.clear();
  }

  void clearRegister(){
    txtRegisterEmail.clear();
    txtRegisterPassword.clear();
    txtRegisterConfirmPassword.clear();
    txtRegisterName.clear();
  }

  bool validateRegisterPassword(){
    return txtRegisterPassword.text == txtRegisterConfirmPassword.text;
  }

  void handleLogin(BuildContext context) {
    if (kDebugMode) {
      print("Login successful");
    }
    // TODO: Add API call here
    clearLogin();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
     );
  }


  void handleSubmit(BuildContext context){
    if (kDebugMode) {
      print('submit');
    }
    // TODO: Add API call here
    clearRegister();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Register(),
      ),
    );
  }

  void navigateToRegister(BuildContext context) {
    if (kDebugMode) {
      print("Going to Register");
    }
    // TODO: Add API call here
    clearRegister();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Register(),
      ),
    );


  }
}
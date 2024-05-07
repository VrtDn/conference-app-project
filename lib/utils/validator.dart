class AppValidator {
  // this class is a catalog for all methods for validation
  // for Sing up and Login

  String? titleController(String? value){
    if (value!.isEmpty) {
      return "please enter a title";
    }
    if (value.length > 15) {
      return "please enter a shorter title";
    }
    return null;
  }

  String? passwordValidate(String? value) {
    if (value!.isEmpty) {
      return "please enter a password";
    }
    if (value.length < 8) {
      return "please enter a 8-digit password";
    }
    return null;
  }

  String? usernameValidate(String? value) {
    if (value!.isEmpty) {
      return "please enter a username";
    }
    return null;
  }

  String? rePasswordValidate(String? value, String? password) {
    print("value : $value");
    print("password : $password");
    if (value!.isEmpty) {
      return "please enter a password";
    }
    if (value.length < 8) {
      return "please enter  8-digit password";
    }
    if ('$value' != '$password') {
      return  "please enter a same password";
    }
    return null;
  }

  String? emailValidate(String? value) {
    if (value!.isEmpty) {
      return "please enter a email";
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_ `{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(value)) {
      return "please enter a valid email";
    }
    return null;
  }

  String? phoneNumberValidator(String? value) {
    if (value!.isEmpty) {
      return "please enter a phone number";
    }
    if (value.length < 10) {
      return "please enter a 10-digit phone number";
    }
    RegExp phoneRexExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    if (!phoneRexExp.hasMatch(value)) {
      return "please enter a valid phone number";
    }
    return null;
  }
}
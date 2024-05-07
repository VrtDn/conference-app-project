import 'package:conference_app/services/auth_service.dart';
import 'package:conference_app/utils/validator.dart';
import 'package:flutter/material.dart';

import '../utils/consts.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  var isLoaded = false;
  var _passwordVisible = false;
  var _rePasswordVisible = false;
  final authService = AuthService();
  var validator = AppValidator();


  InputDecoration _buildInputDecoration(String label, IconData icon, bool needVisibilityOption, bool isRePassword) {
    return InputDecoration(
        labelStyle: const TextStyle(color: Colors.white),
        suffixStyle: const TextStyle(color: Colors.white),
        fillColor: Colors.white70!.withAlpha(150),
        filled: true,

        suffixIcon: IconButton(onPressed: (){
          if (needVisibilityOption) {
            if (isRePassword) {
              setState(() {
                _rePasswordVisible = !_rePasswordVisible;
              });
            } else {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            }
          }
        }, icon: Icon(
          needVisibilityOption
              ? isRePassword
                ? _rePasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined
                : _passwordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined
              : icon,

          color: Colors.white,
        ),),
        labelText: label,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.0)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 0.0, color: Colors.transparent),
        ));
  }


  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoaded = true;
      });
      var data = {
        "email": _emailController.text,
        "password": _passwordController.text,
        'directions':[],
        'bio' : '',
        'name' : '',
      };
      await authService.createNewUser(data, context);
      setState(() {
        isLoaded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: Consts.mainGradient
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Welcome to our conference!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _emailController,
                        decoration: _buildInputDecoration(
                            "Your email",
                            Icons.email_outlined,
                            false,
                          false
                        ),
                        validator: validator.emailValidate,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        obscureText: !_passwordVisible,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _passwordController,
                        decoration: _buildInputDecoration(
                            "Your password",
                            Icons.remove_red_eye_outlined,
                            true,
                          false
                        ),
                        validator: validator.passwordValidate,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        obscureText: !_rePasswordVisible,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _rePasswordController,
                        decoration: _buildInputDecoration(
                            "Your password",
                            Icons.remove_red_eye_outlined,
                            true,
                          true
                        ),
                        validator: (value){
                          return validator.rePasswordValidate(value, _passwordController.value.text);
                        },
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {isLoaded ? print("Loading") : _submitForm();},
                          child: isLoaded
                              ? const CircularProgressIndicator()
                              :const Center(
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "forgot password?",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {Navigator.of(context).pop();},
                    child: Text(
                      "enter account?",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

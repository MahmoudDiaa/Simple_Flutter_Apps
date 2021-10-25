import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var passwordVisibilityIcon = Icons.visibility;
  var passwordIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultTextFormField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      label: 'Email Address',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'email must nit not be empty';
                        }
                        return null;
                      },
                      prefix: Icons.email),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultTextFormField(
                    obscure: passwordIsVisible,
                    label: 'password',
                    textInputType: TextInputType.visiblePassword,
                    controller: passwordController,
                    prefix: Icons.lock,
                    suffixIcon: passwordIsVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onPressSuffix: () {
                      setState(() {
                        passwordIsVisible = !passwordIsVisible;
                      });
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'password must not not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          print('${emailController.text}');
                        }
                      },
                      text: "Login"),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ?"),
                      TextButton(onPressed: () {}, child: Text("Register Now"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

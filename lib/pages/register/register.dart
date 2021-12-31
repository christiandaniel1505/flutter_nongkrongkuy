import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nongkrongkuy/pages/home/home.dart';
import 'package:flutter_nongkrongkuy/pages/login/login.dart';
import 'package:flutter_nongkrongkuy/services/auth.dart';
import 'package:provider/provider.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';

class RegisterMain extends StatefulWidget {
  RegisterMain({Key? key}) : super(key: key);

  @override
  _RegisterMainState createState() => _RegisterMainState();
}

class _RegisterMainState extends State<RegisterMain> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  String _errorMessage = "";
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF282726),
      body: SingleChildScrollView(
        child: Container(
            child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text("Register Page",
                    style: TextStyle(color: Color(0xFFc79c60), fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Image(
                  width: 250,
                  image: AssetImage('images/light.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image(
                  width: 250,
                  image: AssetImage('images/nongkrong.png'),
                ),
              ),
              Stack(children: [
                Stack(children: [
                  Image(
                    image: AssetImage('images/padding.jpg'),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE4E4E4),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 20, left: 20),
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: emailController,
                                cursorColor: Color(0xFF282726),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF282726),
                                  ),
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.redAccent,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.teal,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Color(0xFF282726),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFF282726), width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 20, left: 20),
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: nameController,
                                cursorColor: Color(0xFF282726),
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF282726),
                                  ),
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.redAccent,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.teal,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.account_box,
                                    color: Color(0xFF282726),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFF282726), width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 20, left: 20),
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: passwordController,
                                cursorColor: Color(0xFF282726),
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF282726),
                                  ),
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.redAccent,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.teal,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.vpn_key,
                                    color: Color(0xFF282726),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFF282726), width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        loading == true
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 55),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Color(0xFF1C1313),
                                )),
                              )
                            : InkWell(
                                onTap: () async {
                                  if (emailController.text == '' ||
                                      nameController.text == '' ||
                                      passwordController.text == '') {
                                    setState(() {
                                      _errorMessage =
                                          "Form not allowed to be null";
                                    });
                                  } else if (!EmailValidator.validate(
                                      emailController.text)) {
                                    setState(() {
                                      _errorMessage = "Email not valid";
                                    });
                                  } else if (nameController.text.length < 4) {
                                    setState(() {
                                      _errorMessage = "Name must more than 4";
                                    });
                                  } else if (passwordController.text.length <
                                      8) {
                                    setState(() {
                                      _errorMessage =
                                          "Password must more than 8";
                                    });
                                  } else {
                                    setState(() {
                                      loading = true;
                                    });
                                    bool result =
                                        await Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .register(
                                                emailController.text,
                                                passwordController.text,
                                                nameController.text);
                                    if (result == true) {
                                      bool login =
                                          await Provider.of<AuthProvider>(
                                                  context,
                                                  listen: false)
                                              .login(emailController.text,
                                                  passwordController.text);
                                      if (login == true) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 30, right: 20, left: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1C1313),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          left: 30,
                                          right: 30),
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                            color: Color(0xFFE4E4E4),
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Image(
                    image: AssetImage('images/table-set.png'),
                    width: 350,
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  child: Text("Have an account?",
                      style: TextStyle(
                        color: Color(0xFFE4E4E4),
                      )),
                ),
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return LoginMain();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 5, right: 20, left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE4E4E4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 15, right: 15),
                      child: Text(
                        "Login",
                        style:
                            TextStyle(color: Color(0xFF1C1313), fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image(
                  width: 100,
                  image: AssetImage('images/nongkrong.png'),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

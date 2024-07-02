import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();

  bool pass = true;
  Icon ico = const Icon(Icons.visibility_off);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/login.jpg')),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Signup",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: controller1,
                      decoration: InputDecoration(
                        hintText: 'Enter your UserName ',
                        label: const Text('UserName'),
                        fillColor: const Color(0xffD8D8DD),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: controller2,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email),
                        hintText: 'Enter your Email Address',
                        label: const Text('Email Address'),
                        fillColor: const Color(0xffD8D8DD),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: controller3,
                      obscureText: pass,
                      decoration: InputDecoration(
                        hintText: 'Enter your Password',
                        label: const Text('Password'),
                        suffixIcon: IconButton(
                          icon: ico,
                          onPressed: () {
                            setState(() {
                              pass = !pass; // opposite of pass
                              if (pass == false) {
                                ico = const Icon(Icons.visibility);
                              } else {
                                ico = const Icon(Icons.visibility_off);
                              }
                            });
                          },
                        ),
                        fillColor: const Color(0xffD8D8DD),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: TextField(
                  //     obscureText: pass,
                  //     decoration: InputDecoration(
                  //       hintText: 'Enter your Conform Password',
                  //       label: const Text('Conform Password'),
                  //       suffixIcon: IconButton(
                  //         icon: ico,
                  //         onPressed: () {
                  //           setState(() {
                  //             pass = !pass; // opposite of pass
                  //             if (pass == false) {
                  //               ico = const Icon(Icons.visibility);
                  //             } else {
                  //               ico = const Icon(Icons.visibility_off);
                  //             }
                  //           });
                  //         },
                  //       ),
                  //       fillColor: const Color(0xffD8D8DD),
                  //       filled: true,
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: controller4,
                      decoration: InputDecoration(
                          hintText: 'Enter your PhoneNumber ',
                          label: const Text('PhoneNumber'),
                          fillColor: const Color(0xffD8D8DD),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: Icon(Icons.phone)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: controller5,
                      decoration: InputDecoration(
                          hintText: 'Enter your address ',
                          label: const Text('address'),
                          fillColor: const Color(0xffD8D8DD),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: Icon(Icons.phone)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: Colors.cyanAccent,
                          minWidth: 150,
                          height: 80,
                          onPressed: () async {
                            await Sign_up_presenter().signUp(
                                controller1,
                                controller2,
                                controller5,
                                controller4,
                                controller3,
                                context);
                          },
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (v) {
                              return LoginScreen();
                            }),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sign_up_presenter {
  final String apiUrl = 'http://depolyapi.runasp.net/api/Account/Register';

  Future<bool> signUp(
      TextEditingController userName,
      TextEditingController email,
      TextEditingController address,
      TextEditingController phone,
      TextEditingController passwordController,
      BuildContext context) async {
    print(passwordController.text);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "firstName": userName.text,
        "lastName": userName.text,
        "userName": userName.text,
        "email": email.text,
        "phone": phone.text,
        "password": passwordController.text,
        "gender": "male",
        "address": address.text,
        "government": "government",
        "birthday": "2024-06-30T20:43:49.0742"
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return HomePage();
      }));

      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }
}


import 'package:flutter/material.dart';
import 'package:hotels/screen/sign_up_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'home_page.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller1= TextEditingController();
  TextEditingController controller2 = TextEditingController();

  bool pass = true;
  Icon ico = const Icon(Icons.visibility_off);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: controller1,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.email),
                      hintText: 'Enter user name 1234m',
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
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: controller2,
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
                const SizedBox(
                  height: 20,
                ),
                // Container(
                //   height: 50,
                //   width: 350,
                //   decoration: const BoxDecoration(
                //     color: Color(0xff0ACF83),
                //   ),
                //   child: const Center(
                //       child: Text(
                //         "Login",
                //         style: TextStyle(
                //             color: Colors.white, fontWeight: FontWeight.bold),
                //       ),
                //   ),
                // ),
                Container(
                  height: 50,
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const SizedBox(width: 5,),
                      MaterialButton(
                        color: Colors.cyanAccent,
                        minWidth: 150,
                        height: 80,
                        onPressed: () async{

                          // here remove three next lines and uncomment fourth line after fix login
                          Navigator.push(context, MaterialPageRoute(builder: (c){
                            return HomePage();
                          }));

                         // await AuthService().login(controller1,controller2, context);
                        },
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                          "Login",
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
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (v) {
                            return const SignupScreen();
                          }),
                        );
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                            // color: Colors.cyanAccent,
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
    );
  }
}

class AuthService {
  final String apiUrl = 'http://depolyapi.runasp.net/api/Account/Login';

  Future<bool> login(TextEditingController username , TextEditingController password , BuildContext context) async {


    final response = await http.post(
      Uri.parse(apiUrl),

      headers: <String, String>{

        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username.text,
        "password": password.text,
      }),
    );
    print(jsonEncode(<String, String>{
      "username": username.text,
      "password": password.text,
    }),);

    if (response.statusCode == 200) {
      print(response.body);

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
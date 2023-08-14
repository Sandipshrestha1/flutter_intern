import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phase1/model/userModel.dart';
import 'package:phase1/screens/dash_board.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/widget_formtext.dart';
import 'sign_up_screen.dart';

List<userModel> usersData = [];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isVisible = true;
  bool value = false;
  late SharedPreferences logindata;
  late bool newuser;

  Future<void> initLogindata() async {
    logindata = await SharedPreferences.getInstance();
  }

  Future<void> removeDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('dataList');
    });
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);

    // print(newuser);
    // if (newuser == false) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    // }
  }

  Future<void> fetchUserData() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final jsonData = sharedPreferences.getString('dataList');
      log(jsonData.toString());

      if (jsonData == null) {
        String jsonData = await rootBundle.loadString('lib/services/user.json');
        final jsonList = json.decode(jsonData);
        //print(jsonList);
        if (jsonList is List<dynamic>) {
          usersData = jsonList.map((json) => userModel.fromJson(json)).toList();
        } else if (jsonList is Map<String, dynamic>) {
          usersData.add(userModel.fromJson(jsonList));
        }
        List<Map<String, dynamic>> jsonDataList =
            usersData.map((cv) => cv.toJson()).toList();

        String jsonDataString = json.encode(jsonDataList);
        sharedPreferences.setString('dataList', jsonDataString);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    (jsonData);
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          usersData = decodedData.map((e) => userModel.fromJson(e)).toList();
        });
      } catch (e) {
        rethrow;
      }
    } else {
      usersData = [];
    }
    return [];
  }

  Future<void> performLogin(String emaill, String passwordd) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (usersData.isNotEmpty) {
        userModel? users = usersData.firstWhere(
          (user) => user.email == emaill && user.password == passwordd,
        );

        prefs.setString('userID', users.id.toString());

        prefs.setString('email', emaill); // Add this line

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } // Return true here for successful login
    } catch (e) {
      //rethrow;

      // showDialog(
      //   context: context,
      //   builder: (ctx) => AlertDialog(
      //     title: const Text("Alert Dialog Box"),
      //     content: const Text("Please enter the correct email id and password"),
      //     actions: <Widget>[
      //       TextButton(
      //         onPressed: () {
      //           Navigator.of(ctx).pop();
      //         },
      //         child: Container(
      //           color: Colors.red,
      //           padding: const EdgeInsets.all(14),
      //           child: const Text("okay"),
      //         ),
      //       ),
      //     ],
      //   ),
      // );
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController pswdController = TextEditingController();

  // SharedPreferences logindata;
  // bool newuser;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    initLogindata(); // Initialize logindata here
    getUserData();

    check_if_already_login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Form"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(29),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.zero),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                    // height: MediaQuery.of(context).size.height,
                    // child: Column(
                    // children: [
                    // ClipPath(
                    //   clipper: CurveClipper(),
                    //   child: Image(
                    //     height: MediaQuery.of(context).size.height / 2.5,
                    //     width: double.infinity,
                    //     image: AssetImage("assets/img/img1.jpg"),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // Text(
                    //   "Frenzy".toUpperCase(),

                    //   style: const TextStyle(
                    //       fontSize: 35,
                    //       fontWeight: FontWeight.bold,
                    //       letterSpacing: 10.0,
                    //       color: Colors.blue), // TextStyle
                    // ),
                    //     ],
                    //   ),
                    ),
                formtext(
                    controller: emailController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email address';
                      }
                      return null;
                    },
                    labeltext: 'Email',
                    hinttext: 'Enter Your Email',
                    prefixIcon: const Icon(Icons.email)),
                const SizedBox(
                  height: 20,
                ),

                //for password
                TextFormField(
                  controller: pswdController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: _isVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: _isVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    labelText: 'Password',
                    hintText: 'Enter Your password',
                    disabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    border: const OutlineInputBorder(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Forget Password"),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // ElevatedButton(
                //   onPressed: () async {
                //     final SharedPreferences sharedPreferences =
                //         await SharedPreferences.getInstance();
                //     SharedPreferences.setString('email ', emailController.text);
                //     Get.to(const HomePage());

                //     if (_formKey.currentState!.validate()) {
                //       //     // setState(() {
                //       performLogin(emailController.text, pswdController.text);
                //       // });
                //     }
                //   },
                //   child: const Text("Login"),
                // ),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await performLogin(
                          emailController.text, pswdController.text);

                      logindata.setBool('login', false);
                    }
                  },
                  child: const Text("Login"),
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text("Do'nt have account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Screen1()),
                        );
                      },
                      child: const Text("SignUp"),
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: () {
                    removeDataFromSharedPreferences();
                  },
                  child: const Text("Clear Data"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:phase1/json/signup_details.dart';
import 'package:phase1/widgets/login_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../model/userModel.dart';
import 'login_screen.dart';
import 'package:uuid/uuid.dart';

Map<String, dynamic> signUpEmptyList = {};
Map<String, dynamic> loginEmptyList = {};

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);
  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final _formKey = GlobalKey<FormState>();
  String _gender = '';
  // File? profileimage;
  // File? coverimage;

  File? profileimage; // Initialize profile image
  File? coverimage; // Initialize cover image
  List<Usermodel> user = [];
  final ImagePicker picker = ImagePicker();
  String selectValue = 'Married';
  List<String> dropdownItem = [
    'Married',
    'Unmarried',
  ];
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedprofileImage = await picker.pickImage(source: source);

      if (pickedprofileImage == null) return;

      setState(() {
        profileimage = File(pickedprofileImage.path);
      });
      print("Image is comming");
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  //// cover image
  Future<void> pickcoverImage(ImageSource source) async {
    try {
      final pickedcoverImage = await picker.pickImage(source: source);

      if (pickedcoverImage == null) return;

      setState(() {
        coverimage = File(pickedcoverImage.path);
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Future<void> signUp(int id) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   final jsonString = sharedPreferences.getString('user ');
  //   if (jsonString != null) {
  //     try {
  //       final jsonData = jsonDecode(jsonString);
  //       if (jsonData is List<dynamic>) {
  //         user = jsonData.map((json) => Usermodel.fromJson(json)).toList();
  //       } else if (jsonData is Map<String, dynamic>) {
  //         user.add(Usermodel.fromJson(jsonData));
  //       }
  //     } catch (e) {
  //       print("Error data : $e");
  //     }
  //   }
  // }

  void signUp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('dataList');
    print(jsonString);
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);

        if (jsonData is List<dynamic>) {
          signupList =
              jsonData.map((json) => userModel.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          loginEmptyList
              .addAll(userModel.fromJson(jsonData) as Map<String, dynamic>);
        }
      } catch (e) {
        rethrow;
      }
    }
    if (signupList.any((user) => user.email == emailController.text)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('User Already Exists'),
            content: Text(
                'The user with email ${emailController.text} already exists.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Do not proceed further
    }

    // Shared preference

    signupList.add(userModel(
      fullName: fullNameController.text,
      email: emailController.text,
      mobileNumber: phoneNumberController.text,
      dob: dateController.text,
      password: passwordController.text,
      gender: _gender,
      maritialStatus: selectValue,
      id: const Uuid().v4().toString(),
      profileimage: profileimage!,
      coverimage: coverimage!,
    ));
    List<Map<String, dynamic>> jsonDataList =
        signupList.map((cv) => cv.toJson()).toList();
    loginEmptyList[emailController.text] = jsonDataList;
    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('dataList', jsonData);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));

    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Center(
    //       child: Text(
    //     'Data Added Sucessfully',
    //   )),
    //   backgroundColor: Colors.green,
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SignUp Form"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(29),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.zero),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: Center(
                            child: profileimage == null
                                ? const Text('No Image selected')
                                : CircleAvatar(
                                    backgroundColor: const Color.fromARGB(
                                        255, 203, 202, 202),
                                    radius: 60,
                                    backgroundImage: FileImage(profileimage!),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Center(
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Pick an image'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading:
                                                const Icon(Icons.photo_library),
                                            title:
                                                const Text('Pick from gallery'),
                                            onTap: () {
                                              _pickImage(ImageSource.gallery);
                                              Navigator.of(context).pop();
                                              print("Image is comming");
                                            },
                                          ),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.camera_alt),
                                            title: const Text('Take a photo'),
                                            onTap: () {
                                              _pickImage(ImageSource.camera);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    formtext(
                      controller: fullNameController,
                      hinttext: "Eg: Ambition Guru",
                      labeltext: "Enter your Full name",
                      validate: (validateFullName) {
                        final regex =
                            RegExp(r'^[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}$');
                        if (validateFullName == null ||
                            validateFullName.isEmpty) {
                          return "Name cannot be empty";
                          // } else if (validateFullName.length > 15) {
                          //   return 'Text must not exceed 10 characters';
                        } else if (!regex.hasMatch(validateFullName)) {
                          return 'Only alphabetic characters are allowed';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    formtext(
                      controller: emailController,
                      hinttext: "Eg: ambitionguru@gmail.com",
                      labeltext: "Enter your Email",
                      validate: (value) {
                        final regex = RegExp(r'\S+@\S+\.\S+');
                        if (value == null || value.isEmpty) {
                          return "Email Cannot be empty";
                        } else if (!regex.hasMatch(value)) {
                          return 'Only correct  email id is validate ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    formtext(
                        controller: passwordController,
                        hinttext: "Enter your Password",
                        labeltext: "Your Password",
                        validate: (value) {
                          final regex = RegExp(
                              "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*])(?=.{8,})");
                          if (value == null || value.isEmpty) {
                            return "Password cannot be empty";
                          } else if (!regex.hasMatch(value)) {
                            return "Enter validate  password";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    formtext(
                        controller: phoneNumberController,
                        //keyType: ,
                        hinttext: "Eg: 98XXXXXXX",
                        labeltext: "Enter your Phone Number",
                        validate: (value) {
                          final regex = RegExp("[0-9]+");
                          if (value == null || value.isEmpty) {
                            return "Your phone number cannot be empty";
                          } else if (!regex.hasMatch(value)) {
                            return "Enter your correct phone number";
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Choose Date';
                          }
                          return null;
                        },
                        controller: dateController,
                        decoration: InputDecoration(
                            hintText: 'Select your correct date of birth',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: const Icon(
                              Icons.calendar_today,
                              color: Colors.red,
                            ),
                            labelText: "Date Of Birth",
                            labelStyle: const TextStyle(color: Colors.purple)),
                        readOnly: true,
                        onTap: () async {
                          //when click we have to show the datepicker
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              dateController.text = formattedDate;
                            });
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text("Gender: "),
                        Radio<String>(
                          value: 'male',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value ?? '';
                            });
                          },
                        ),
                        const Text('Male'),
                        Radio<String>(
                          value: 'female',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value ?? '';
                            });
                          },
                        ),
                        const Text("female"),
                        Radio<String>(
                          value: 'Other',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value ?? '';
                            });
                          },
                        ),
                        const Text("other"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Are you ',
                        ),
                        const SizedBox(width: 30),
                        DropdownButton<String>(
                          focusColor: Colors.amberAccent,
                          value: selectValue,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.green,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectValue = newValue!;
                            });
                          },
                          items: dropdownItem.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

//cover image

                    const SizedBox(height: 20),

                    Container(
                        height: 100,
                        width: 300,
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromARGB(255, 96, 169, 230)),
                        child: Center(
                            child: coverimage == null
                                ? const Text('No Image selected')
                                : Image.file(
                                    coverimage!,
                                    height: 100,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ))),
                    Positioned(
                        bottom: 1,
                        right: 125,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Pick an image'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading:
                                            const Icon(Icons.photo_library),
                                        title: const Text('Pick from gallery'),
                                        onTap: () {
                                          pickcoverImage(ImageSource.gallery);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.camera_alt),
                                        title: const Text('Take a photo'),
                                        onTap: () {
                                          pickcoverImage(ImageSource.camera);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.camera_alt),
                        )),

//cover image

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            signUp();
                          });
                          // setState(() {
                          //   try {
                          //     // ignore: unused_local_variable
                          //     userModel user = usersData.firstWhere(
                          //         (user) => user.email == emailController.text);
                          //     ScaffoldMessenger.of(context)
                          //         .showSnackBar(const SnackBar(
                          //       content:
                          //           Center(child: Text('Email already use')),
                          //       backgroundColor: Colors.red,
                          //     ));

                          //     return;
                          //   } catch (e) {
                          //     signUp();
                          //     return;
                          //   }
                          //  });
                        }

                        //_submitForm();
                      },
                      child: const Text("Signup Form"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account "),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text("Login In "),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

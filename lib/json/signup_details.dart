import 'dart:io';

class Usermodel {
  File? profilepic;
  String fullname;
  String email;
  String password;
  String phonenumber;
  String dateofbirth;
  String gender;
  String maritalstatus;

  Usermodel({
    this.profilepic,
    required this.fullname,
    required this.email,
    required this.password,
    required this.phonenumber,
    required this.dateofbirth,
    required this.gender,
    required this.maritalstatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'profilepic': profilepic,
      'fullname': fullname,
      'email': email,
      'password': password,
      'phonenumber': phonenumber,
      'gender': gender,
      'maritalstatus': maritalstatus,
    };
  }

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      profilepic: json['profilepic'],
      fullname: json['fullname '],
      email: json['email'],
      password: json['password'],
      phonenumber: json['phonenumber'],
      dateofbirth: json['dateofbirth'],
      gender: json['gender'],
      maritalstatus: json['maritalstatus'],
    );
  }
}

List<Usermodel> usermodellist = [];

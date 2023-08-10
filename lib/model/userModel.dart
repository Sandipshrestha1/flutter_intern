import 'dart:io';

class userModel {
  String? id;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? gender;
  String? dob;
  String? password;
  String? maritialStatus;
  File profileimage;
  File coverimage;

  userModel(
      {this.id,
      this.fullName,
      this.email,
      this.mobileNumber,
      this.gender,
      this.dob,
      this.password,
      this.maritialStatus,
      required this.profileimage,
      required this.coverimage});

  factory userModel.fromJson(Map<String, dynamic> json) {
    // File? profileimage;
    // if (json["profileimage"] != "") {
    //   profileimage = File(json["profileimage"]);
    // }

    // File? coverimage;
    // if (json["coverimage"] != "") {
    //   coverimage = File(json["coverimage"]);
    // }

    String profilepath = json["profileimage"] ?? "";
    String coverpath = json["coverimage"] ?? "";
    return userModel(
      id: json["id"],
      fullName: json["fullName"],
      email: json["email"],
      mobileNumber: json["mobileNumber"],
      gender: json["gender"],
      dob: json["dob"],
      password: json["password"],
      maritialStatus: json["maritialStatus"],
      profileimage: File(profilepath),
      coverimage: File(coverpath),
    );
  }
  Map<String, dynamic> toJson() {
    String profileimagePath = profileimage.path;
    String coverimagePath = coverimage.path;

    return {
      "id": id,
      "fullName": fullName,
      "email": email,
      "mobileNumber": mobileNumber,
      "gender": gender,
      "dob": dob,
      "password": password,
      "maritialStatus": maritialStatus,
      "image": profileimagePath,
      "coverimage": coverimagePath,
    };
  }
}

List<userModel> signupList = [];

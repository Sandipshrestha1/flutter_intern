import 'dart:convert';
import 'package:flutter/services.dart';

Future<void> loadUserFriendList() async {
  final String data =
      await rootBundle.loadString('assets/user_friend_list.json');
  final List<dynamic> userFriendList = json.decode(data);

  // Now you can work with the user friend list data
  // For example:
  for (var entry in userFriendList) {
    print('User List ID: ${entry['user_list_id']}');
    print('User ID: ${entry['user_id']}');
    // ... and so on for other fields
  }
}

void main() {
  loadUserFriendList();
}

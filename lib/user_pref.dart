// ignore_for_file: file_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class UserPref {
  static guardaID(id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("userID", id);
  }

  static getID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userID");
  }
}

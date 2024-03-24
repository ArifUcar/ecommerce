import 'package:flutter/material.dart';

class UserData with ChangeNotifier{

   String email="example@gmail.com";

   void newEmail(String newEmail){
    email=newEmail;
    notifyListeners();
   }
}
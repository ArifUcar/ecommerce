
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/services/firebaseAuth.dart';
import 'package:provider/provider.dart';

import '../../services/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email, passwd;
    final formKey = GlobalKey<FormState>();
  final firebaseauth = FirebaseAuth.instance;
  final FirebaseHelper firebaseHelper = FirebaseHelper();
  @override
  Widget build(BuildContext context) {
    
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      body: Center(
        child: Column(
          children: [
            Container(
              height: height * 0.25,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/top_login.png"))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSizedBox(),
                    CustomSizedBox(),
                    Text(
                      "Merhaba, \nHoşgeldin",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    CustomSizedBox(),
                    mailTextField(),
                    CustomSizedBox(),
                    passwdTextField(),
                    CustomSizedBox(),
                    forgotPaswdBtn(),
                    CustomSizedBox(),
                    CustomSizedBox(),
                    loginButton(),
                    CustomSizedBox(),
                    signUpButton(context),
                
                
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Center signUpButton(BuildContext context) {
    return Center(
                  child: TextButton(onPressed: (){
                    Navigator.pushNamed(context, "/signUp");
                  },child: Text("Hesap Oluştur",style:TextStyle(color: Colors.pink[200]),),),
                );
  }

  Center loginButton() {
    return Center(
      child: Container(
        width: 120,
        margin: EdgeInsets.symmetric(horizontal: 60),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Color(0xff31274F)),
        height: 50,
        child: TextButton(
          onPressed: () async {
  if (formKey.currentState!.validate()) {
    formKey.currentState!.save();
    UserCredential? userCredential = await firebaseHelper.signIn(email, passwd);
    if (userCredential != null) {
      Provider.of<UserData>(context,listen: false).newEmail(email);
      // E-posta adresini depolayın
      Navigator.pushNamed(context, "/homeScreen");
    } else {
      // Giriş başarısız ise kullanıcıyı bilgilendirme
    }
  }
},

          child: Text(
            "Giriş Yap",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Center forgotPaswdBtn() {
    return Center(
                  child: TextButton(onPressed: (){},child: Text("Şifremi Unuttum",style:TextStyle(color: Colors.pink[200]),),),
                );
  }

  Container passwdTextField() {
    return Container(
      width: 350,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Bilgileri Eksiksiz Doldurunuz";
          }
        },
        onSaved: (value) {
          passwd = value!;
        },
        obscureText: true,
        style: TextStyle(color: Colors.white),
        decoration: customInputDeceration("Şifre"),
      ),
    );
  }

  Container mailTextField() {
    return Container(
      width: 350,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Bilgileri Eksiksiz Doldurunuz";
          }
        },
        onSaved: (value) {
          email = value!;

        },
        style: TextStyle(color: Colors.white),
        decoration: customInputDeceration("E-mail"),
      ),
    );
  }
  Widget CustomSizedBox()=>SizedBox(
    height: 20,
  );

  InputDecoration customInputDeceration(String hintText) {
    return InputDecoration(
                  hintText: hintText ,
                  hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey,)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey,)));
  }
}

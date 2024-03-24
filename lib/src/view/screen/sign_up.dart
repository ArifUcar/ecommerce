import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../services/firebaseAuth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var email, passwd,name,fname;
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
                    titleText(),
                    CustomSizedBox(),
                    nameTextField(),
                    CustomSizedBox(),
                    familierNameTextField(),
                    CustomSizedBox(),
                    e_mailTextField(),
                    CustomSizedBox(),
                    passwordTextField(),
                    CustomSizedBox(),
                    signUpButton(),
                    CustomSizedBox(),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/loginPage");
                        },
                        child: Text(
                          "Zaten bir hesabın var mı?",
                          style: TextStyle(color: Colors.pink[200]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Center signUpButton() {
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
              
              UserCredential? userCredential = await firebaseHelper.signUp(
                  email, passwd); // FirebaseHelper kullanarak kayıt işlemi
             if (userCredential != null) {
                await firebaseHelper.userCollection.add({
                  'email': email,
                  'name': name,
                  'fname': fname,
                   // name, soyad gibi diğer bilgilerinizi ekleyin
                  // diğer alanları ekleyin
                });
                
                formKey.currentState!.reset();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Kaydınız başarılı bir şekilde oluşturuldu. Giriş sayfasına yönlendiriliyorsunuz."),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 3),
                  ),
                );
                Navigator.pushReplacementNamed(context, "/loginPage");
              } else {
                // Kayıt başarısız ise kullanıcıyı bilgilendirme
              }
            }
          },
          child: Text(
            "Kayıt Ol",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Container familierNameTextField() {
    return Container(
      width: 350,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Bilgileri Eksiksiz Doldurunuz";
          }
        },
        onSaved: (value) {
          fname = value!;
        },
        style: TextStyle(color: Colors.white),
        decoration: customInputDeceration("Soyad"),
      ),
    );
  }

  Container nameTextField() {
    return Container(
      width: 350,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Bilgileri Eksiksiz Doldurunuz";
          }
        },
        onSaved: (value) {
          name = value!;
        },
        style: TextStyle(color: Colors.white),
        decoration: customInputDeceration("İsim"),
      ),
    );
  }

  Container passwordTextField() {
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

  Container e_mailTextField() {
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

  Text titleText() {
    return Text(
      "Merhaba, \nHoşgeldin",
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget CustomSizedBox() => SizedBox(
        height: 20,
      );

  InputDecoration customInputDeceration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.grey,
        )),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.grey,
        )));
  }
}

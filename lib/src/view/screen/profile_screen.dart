import 'package:e_commerce_flutter/src/services/firebaseAuth.dart';
import 'package:e_commerce_flutter/src/services/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseHelper fire = FirebaseHelper();
  String? email;
  String? username;

  @override
  void initState() {
    super.initState();
    email = Provider.of<UserData>(context, listen: false).email;
    loadName("$email");
  }

  Future<void> loadName(String email) async {
    String? name = await fire.getUsernameByEmail(email);
    setState(() {
      username = name;
    });
  }

 Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Image.asset('assets/images/logo.png'),
          width: 200,
        ),
        SizedBox(height: 20),
        Text(
          "Merhaba  ${username ?? 'loading...'}!",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "🛍️ Hakkımızda",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Hoş Geldiniz! TechMart olarak, teknoloji tutkunlarına en yeni ürünleri ve trendleri sunmak için buradayız. Misyonumuz, müşterilerimize benzersiz alışveriş deneyimleri yaşatmak ve teknoloji ihtiyaçlarını en iyi şekilde karşılamaktır.",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Tüm siparişler sayfasına git
          },
          child: Text(
            "Tüm Siparişler",
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Ürünlerim sayfasına git
          },
          child: Text(
            "Ürünlerim",
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Satıcı yorumları sayfasına git
          },
          child: Text(
            "Satıcı Yorumları",
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Tekrar satın al sayfasına git
          },
          child: Text(
            "Tekrar Satın Al",
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    ),
  );
}


}


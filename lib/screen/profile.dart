import 'package:flutter/material.dart';
import 'package:powereact/screen/loginpage.dart';
import '../ressources/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double coverHeight = MediaQuery.of(context).size.height / 3;
    double profileHeight = MediaQuery.of(context).size.height / 6;
    double top = coverHeight - profileHeight / 2;
    double bottom = profileHeight / 1.6;

    // Cover Image
    Widget buildCoverImage() => Image.asset(
          'images/projet.png',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        );

    // Profile Image
    Widget buildProfileImage() => CircleAvatar(
          radius: profileHeight / 2,
          backgroundImage: const AssetImage('images/pp.png'),
          backgroundColor: Colors.white,
        );

    // Top Image
    Widget buildTop() => Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: bottom),
              child: buildCoverImage(),
            ),
            Positioned(
              top: top,
              child: buildProfileImage(),
            ),
          ],
        );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: ListView(
          children: [
            buildTop(),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Fabien'),
            ),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text('abc@gmail.com'),
            ),
            const ListTile(
              leading: Icon(Icons.location_city_outlined),
              title: Text('France'),
            ),
            SizedBox(
              height: screenWidth * 0.12,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  AuthMethods().logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ));
  }
}

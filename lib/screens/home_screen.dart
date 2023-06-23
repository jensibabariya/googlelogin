import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin/screens/users_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String Name="",Email="",pass="";
 signInWithGoogle() async {

    await InternetAddress.lookup('Google.com');
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  final user=  FirebaseAuth.instance.currentUser;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google login"),
      ),
      body: Center(child: ElevatedButton(onPressed: () {

        signInWithGoogle().then((value) {

          Name=value.user!.displayName.toString();
          Email=value.user!.email.toString();

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Users(Name,Email);
          },));
        });
      }, child: Text("Login with Google")),),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:instagram_clone/data/join_or_login.dart';
import 'package:instagram_clone/pages/login/login.dart';
import 'package:instagram_clone/pages/tab_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return ChangeNotifierProvider<JoinOrLogin>.value(
              value: JoinOrLogin(), child: AuthPage());
        } else {
          if (snapshot.hasData) {
            return TabPage(snapshot.data);
          } else {
            return AuthPage();
          }
        }
      }
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return StreamBuilder<FirebaseUser>(
  //     stream: FirebaseAuth.instance.onAuthStateChanged,
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //       if (snapshot.hasData) {
  //         return TabPage(snapshot.data);
  //       } else {
  //         return LoginPage();
  //       }
  //     },
  //   );
  // }
}
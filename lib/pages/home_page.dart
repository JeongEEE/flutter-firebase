import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final FirebaseUser user;

  HomePage(this.user);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram Clone',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
              Text('Instagram에 오신 것을 환영합니다',
                style: TextStyle(fontSize: 24.0),),
              Padding(padding: EdgeInsets.all(8.0),),
              Text('자유롭게 사진을 올려보세요',),
              Padding(padding: EdgeInsets.all(8.0),),
              SizedBox(
                width: 260.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4.0,
                    child: Column(children: <Widget>[
                      Padding(padding: EdgeInsets.all(8.0),),
                      SizedBox(
                        width: 80.0,
                        height: 80.0,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user.photoUrl??
                            "https://firebasestorage.googleapis.com/v0/b/instagram-clone-39bfa.appspot.com/o/post%2F1585040012318.png?alt=media&token=1dd499d7-c4a0-4b56-b127-94d2fab19906"),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0),),
                      Text(user.email??'', style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(user.displayName??''),
                      // Padding(padding: EdgeInsets.all(8.0),),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //   SizedBox(
                      //     width: 70.0,
                      //     height: 70.0,
                      //     child: Image.network('',fit: BoxFit.cover,),
                      //   ),
                      //   Padding(padding: EdgeInsets.all(1.0),),
                      // ],),
                      // Padding(padding: EdgeInsets.all(4.0),),
                      // Text('Facebook 친구'),
                      // Padding(padding: EdgeInsets.all(4.0),),
                      // RaisedButton(
                      //   child: Text('팔로우'),
                      //   color: Colors.blueAccent,
                      //   textColor: Colors.white,
                      //   onPressed: () {},
                      // ),
                      Padding(padding: EdgeInsets.all(4.0),),
                    ],),
                  ),
                ),
              )],
            ),
          ),
        ),
      ),
    );
  }
}
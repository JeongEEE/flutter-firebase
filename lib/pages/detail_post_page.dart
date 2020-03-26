import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/dialogs.dart';
import 'package:instagram_clone/components/modal.dart';
import 'package:instagram_clone/pages/modify_page.dart';

class DetailPostPage extends StatefulWidget {
  final dynamic document;
  final FirebaseUser user;
  
  DetailPostPage(this.document, this.user);

  @override
  _DetailPostPageState createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  final CollectionReference _postCollectionReference = 
    Firestore.instance.collection('post');
  final StorageReference _firebaseStorageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('둘러보기'),
        actions: <Widget>[
          //로그인한 계정이 작성한 게시글이 아니면 수정버튼이 안보임
          widget.user.email == widget.document['email'] ?
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              //게시글 수정
              Navigator.push(context, MaterialPageRoute(builder: (context) => ModifyPage(widget.user, widget.document)));
            },
          )
          : Container(height: 0,width: 0,),
          //로그인한 계정이 작성한 게시글이 아니면 삭제버튼이 안보임
          widget.user.email == widget.document['email'] ?
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              //게시글 삭제
              showAppModal(
                title: '삭제',
                content: '게시글을 삭제 하시겠습니까?',
                onConfirm: () async {
                  showLoading(text: '삭제중');
                  await _postCollectionReference.document(widget.document['id']).delete();
                  await _firebaseStorageRef.child("post/${widget.document['fileName']}.png").delete();
                  hideLoading();
                  Navigator.pop(context);
                }
              );
            },
          )
          : Container(height: 0,width: 0,),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.document['userPhotoUrl']??
                      "https://firebasestorage.googleapis.com/v0/b/instagram-clone-39bfa.appspot.com/o/post%2F1585040012318.png?alt=media&token=1dd499d7-c4a0-4b56-b127-94d2fab19906"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.document['email'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.document['displayName']??''),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Hero(
              tag: widget.document['photoUrl']??'',
              child: Center(child: Image.network(widget.document['photoUrl']??''))
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(widget.document['contents']),
            ),
          ],
        ),
      ),
    );
  }
}
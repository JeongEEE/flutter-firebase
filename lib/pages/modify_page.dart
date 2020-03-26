import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/components/dialogs.dart';
import 'dart:io';

class ModifyPage extends StatefulWidget {
  final FirebaseUser user;
  final dynamic document;

  ModifyPage(this.user, this.document);

  @override
  _ModifyPageState createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  final textEditingController = TextEditingController();

  File _image;

  @override
  void dispose() {
    textEditingController.dispose(); //메모리 해제가 필요함
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //text수정을 위해서 기존 text 초기값으로 설정하기
    textEditingController.text ='${widget.document['contents']}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        child: Icon(Icons.add_a_photo
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('게시글 수정'),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            showLoading(text: '업로드 중');
            if (_image != null) { // 수정할 이미지를 첨부하엿을때
              final fileName = DateTime.now().millisecondsSinceEpoch.toString();
              final firebaseStorageRef = FirebaseStorage.instance
                .ref()
                .child('post')
                .child('$fileName.png');

              final task = firebaseStorageRef.putFile(
                _image, StorageMetadata(contentType: 'image/png')
              );

              task.onComplete.then((value) {
                var downloadUrl = value.ref.getDownloadURL();

                downloadUrl.then((uri) {
                  var doc = Firestore.instance.collection('post').document(widget.document['id']);
                  doc.updateData({
                    'id': widget.document['id'],
                    'photoUrl': uri.toString(),
                    'contents': textEditingController.text,
                    'email': widget.user.email,
                    'displayName': widget.user.displayName,
                    'userPhotoUrl': widget.user.photoUrl,
                    'fileName': fileName
                  }).then((onValue) {
                    hideLoading();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                });
              });
            } else { // 수정할 이미지가 없을때
              var doc = Firestore.instance.collection('post').document(widget.document['id']);
              doc.updateData({
                'id': widget.document['id'],
                'photoUrl': widget.document['photoUrl'],
                'contents': textEditingController.text,
                'email': widget.user.email,
                'displayName': widget.user.displayName,
                'userPhotoUrl': widget.user.photoUrl,
                'fileName': widget.document['fileName']
              }).then((onValue) {
                hideLoading();
                Navigator.pop(context);
                Navigator.pop(context);
              });
            }            
          },
          icon: Icon(Icons.send),
        )
      ],
    );
  }

  Widget _buildBody() {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              height: size.height * 0.02,
            ),
          _image == null ? Image.network(widget.document['photoUrl']) : Image.file(_image),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              maxLines: 3,
              decoration: InputDecoration(hintText: '내용을 입력하세요'),
              controller: textEditingController,
            ),
          )
        ],
      ),
    );
  }

  Future _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    
  }
}
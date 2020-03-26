import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/account_page.dart';
import 'package:instagram_clone/pages/home_page.dart';
import 'package:instagram_clone/pages/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/store/global_data.dart' as global;

class TabPage extends StatefulWidget {
  final FirebaseUser user;

  TabPage(this.user);
  
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;
  List _pages;

  @override
  void initState() { //생성자 다음에 호출되는 부분
    super.initState();
    _pages = [
      HomePage(widget.user),
      SearchPage(widget.user),
      AccountPage(widget.user)
    ];
  }

  @override
  Widget build(BuildContext context) {
    global.appContext = context;
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Search')),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Account')),
      ]),
    );
  }

  void _onItemTapped(int index) {
    setState((){
      _selectedIndex = index;
    });
  }
}
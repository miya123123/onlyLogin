import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import './main.dart';

class NextPage extends StatelessWidget {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        automaticallyImplyLeading: false,
      ),
      // body: Container(
      body: Padding(
        padding: EdgeInsets.all(20),
        // color: Colors.red,
        child: Center(
          child: Column(
            children: [
              Form(
                child: Text(
                  'Logged in!',
                  style: TextStyle(
                      // color:Colors.black,
                      color: Colors.red,
                      // color:Colors.green,
                      // color:Colors.blue,
                      fontSize: 20),
                ),
              ),
              Form(
                child: Container(
                  child: ElevatedButton(
                      // onPressed: () => Navigator.of(context).pop(),
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          ),
                      child: Text('Logout')),
                  // width: double.infinity,
                  width: 400,
                  // margin: EdgeInsets.only(top: 30),
                  margin: EdgeInsets.only(top: 20),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (_selectedIndex) {
          print(context);
          if (_selectedIndex == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NextPage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          }
        },
      ),
    );
  }
}

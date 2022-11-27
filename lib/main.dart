import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import './next_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email Validation Sample',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  bool _isPasswordMatched = false;
  int _selectedIndex = 0;
  bool _isObscure = true;

  void _onBottomItemTapped(int index) {
    print(context);
    if (index == 0) {
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
  }

  void _onLoginButtonPressed() {
    print(context);
    if (!_key.currentState!.validate()) {
      return;
    }
    if (!_isPasswordMatched) {
      return;
    }
    _key.currentState!.save();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NextPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        automaticallyImplyLeading: false,
        leadingWidth: 400,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 400,
                // alignment: Alignment(0.0, 0.0),
                child: Form(
                  key: _key,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if ((value == null) || !EmailValidator.validate(value)) {
                        return 'Invalid email';
                      }
                    },
                    onSaved: (value) => null,
                  ),
                ),
              ),
              Container(
                width: 400,
                child: Form(
                  child: TextFormField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        // 文字の表示・非表示でアイコンを変える
                        icon: Icon(_isObscure
                            ? Icons.visibility_off
                            : Icons.visibility),
                        // アイコンがタップされたら現在と反対の状態をセットする
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    controller: _passwordController,
                  ),
                ),
              ),
              Form(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: FlutterPwValidator(
                    controller: _passwordController,
                    minLength: 10,
                    uppercaseCharCount: 3,
                    numericCharCount: 3,
                    specialCharCount: 1,
                    width: 400,
                    height: 150,
                    defaultColor: Colors.grey,
                    // successColor: Colors.blue,
                    successColor: Colors.green,
                    failureColor: Colors.red,
                    onSuccess: () {
                      _isPasswordMatched = true;
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          content: new Text("Password condition matched")));
                    },
                    onFail: () {
                      _isPasswordMatched = false;
                    },
                  ),
                ),
              ),
              Form(
                child: Container(
                  child: ElevatedButton(
                      onPressed: () => _onLoginButtonPressed(),
                      child: Text('Login')),
                  // width: double.infinity,
                  width: 400,
                  margin: EdgeInsets.only(top: 30),
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
        onTap: _onBottomItemTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'home_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'DTR admin login';
    var usr = TextEditingController();
    var pwd = TextEditingController();

    bool authenticate(TextEditingController usr, TextEditingController pwd) {
      bool success = false;

      if (usr.text.trim() == 'admin' && pwd.text.trim() == 'admin@dtr') {
        success = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      }

      return success;
    }

    const snackBar = SnackBar(
      content: Text('Login failed'),
      duration: Duration(seconds: 3),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Center(
        child: SizedBox(
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: usr,
                style: const TextStyle(fontSize: 14.0),
                decoration: const InputDecoration(
                  label: Text('username'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                ),
              ),
              const SizedBox(height: 5.0),
              TextField(
                controller: pwd,
                style: const TextStyle(fontSize: 14.0),
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('password'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                ),
                onSubmitted: (value) {
                  bool auth = authenticate(usr, pwd);
                  if (!auth) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
              const SizedBox(height: 10.0),
              Container(
                color: Colors.green[300],
                height: 40.0,
                width: 300.0,
                child: TextButton(
                  onPressed: () {
                    bool auth = authenticate(usr, pwd);
                    if (!auth) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GithubLoginWidget extends StatefulWidget {
  const GithubLoginWidget({Key? key, required this.builder}) : super(key: key);
  final WidgetBuilder builder;
  
  @override
  _GithubLoginWidgetState createState() => _GithubLoginWidgetState();
}

class _GithubLoginWidgetState extends State<GithubLoginWidget> {
  bool _isLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return widget.builder(context);
    }
    return ElevatedButton(
          onPressed: () {
            setState(() {
              _isLoggedIn = true;
            });
          },
          child: Text('Log in to fake Github'));
  }
}

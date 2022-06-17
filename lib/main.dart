import 'package:github_client/github_oauth_credentials.dart';

import 'github_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:github_client/github_login_widget.dart';
import 'package:github/github.dart';
import 'package:window_to_front/window_to_front.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String title = 'Fake Github';

  @override
  Widget build(BuildContext context, ) {
    return GithubLoginWidget(
        githubClientId: githubClientId,
        githubClientSecret: githubClientSecret,
        githubScopes: githubScopes,
        builder: (context, httpClient) {
          WindowToFront.activate();
          return FutureBuilder<CurrentUser>(
            future: viewerDetail(httpClient.credentials.accessToken),
              builder: (context, snapshot) {
              String text = snapshot.hasData ? 'Hello ${snapshot.data!.login}' : 'Retrieving viewer login details...';
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Center(
                child: Text(text)
            ),
          );
        },
          );
  }
    );
  }

  Future<CurrentUser> viewerDetail(accessToken) {
    final github = GitHub(auth: Authentication.withToken(accessToken));
    return github.users.getCurrentUser();
  }
}


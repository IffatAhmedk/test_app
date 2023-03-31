import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/authentication/bloc/authentication_bloc.dart';
import 'package:test_app/authentication/bloc/authentication_state.dart';
import 'package:test_app/authentication/model/auth.dart';
import 'package:test_app/authentication/views/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: "XXX",
    appId: "XXX",
    messagingSenderId: "XXX",
    projectId: "XXX",
  ),);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Auth(),
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          auth: RepositoryProvider.of<Auth>(context),
        ),
        child: MaterialApp(
          title: 'Test',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Loading) {
              // show a loading spinner or progress bar
              return Container();
            } else if (state is Success) {
              // navigate to the dashboard or home screen
              return Container();
            } else if (state is Failure) {
              // display an error message
              return Container();
            } else {
              return Home();
            }
          },
        ),
      ),
    );
  }
}

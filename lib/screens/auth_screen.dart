import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_pokedex/screens/home.dart';
import 'package:my_pokedex/services/firebase_auth_service.dart';
import 'package:my_pokedex/services/firebase_database_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    autocorrect: false,
                    decoration:
                        const InputDecoration(hintText: 'Enter user email'),
                    onChanged: ((value) {
                      this.email = value;
                    }),
                  ),
                  TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration:
                        const InputDecoration(hintText: 'Enter user password'),
                    onChanged: ((value) {
                      this.password = value;
                    }),
                  ),
                  ElevatedButton(
                    child: Text("Sign In"),
                    onPressed: () {
                      try {
                        FireBaseAuthService.signInUser(email, password)
                            .then((value) {
                          if (value != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const Home(title: "My Pokedex")));
                          }
                        });
                      } on Exception catch (exception) {
                        print(exception.toString());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(exception.toString()),
                        ));
                      } catch (error) {
                        print(error);
                      }
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      try {
                        FireBaseAuthService.registerUser(email, password)
                            .then((value) {
                          if (value != null) {
                            FirebaseDatabaseService.saveUserToDatabase(email);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const Home(title: "My Pokedex")));
                          }
                        });
                      } on Exception catch (exception) {
                        print(exception.toString());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(exception.toString()),
                        ));
                      } catch (error) {
                        print(error);
                      }
                    },
                    child: Text("Register"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

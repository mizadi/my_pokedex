import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_pokedex/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_pokedex/services/firebase_auth_service.dart';
import 'firebase_options.dart';

void main() {
  initFirebase();
  runApp(const MyApp());
}

Future<void> initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  FireBaseAuthService.initFireBaseAuthStateListener();
  FireBaseAuthService.initFirebaseIdTokenChangesListener();
  FireBaseAuthService.initFirebaseUseChangesListener();
  FirebaseAuth.instanceFor(app: Firebase.app(), persistence: Persistence.LOCAL);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

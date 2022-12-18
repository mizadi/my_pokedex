import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  static void saveUserToDatabase(String email) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");
    await ref.set({"email": email, "createdAt": DateTime.now().toString()});
  }
}

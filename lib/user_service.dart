// user_service.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app_state.dart';

Future<void> loadUserDataFromFirebase() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final userType = FFAppState().selectedUserType;

  if (uid == null || userType.isEmpty) {
    print("UID or userType is missing.");
    return;
  }

  final userRef = FirebaseDatabase.instance.ref('users/$userType/$uid');
  final snapshot = await userRef.get();

  if (snapshot.exists) {
    final data = snapshot.value as Map;

    FFAppState().update(() {
      FFAppState().name = data['name'] ?? '';
      FFAppState().address = data['address'] ?? '';
      FFAppState().phoneNumber = data['phone'] ?? '';
      FFAppState().emailAddress = data['email'] ?? '';
      FFAppState().about = data['description'] ?? '';
    });

    print('✅ Loaded data: ${FFAppState().name},}');
  } else {
    print("User data not found.");
  }
}

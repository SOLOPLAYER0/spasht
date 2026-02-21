import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/customnavbar/customnavbar_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'profile_farmer_widget.dart' show ProfileFarmerWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Firebase packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileFarmerModel extends FlutterFlowModel<ProfileFarmerWidget> {
  ///  State fields for stateful widgets in this page.
  late CustomnavbarModel customnavbarModel;

  // Profile data
  String name = '';
  String email = '';
  String phone = '';
  String address = '';
  String description = '';

  bool isLoading = true;

  @override
  void initState(BuildContext context) {
    customnavbarModel = createModel(context, () => CustomnavbarModel());

    // Fetch user profile
    fetchFarmerProfile();
  }

  Future<void> fetchFarmerProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        name = data['name'] ?? '';
        email = data['email'] ?? '';
        phone = data['phone'] ?? '';
        address = data['address'] ?? '';
        description = data['description'] ?? '';
      }
    } catch (e) {
      print('Error fetching farmer profile: $e');
    }

    isLoading = false;

  }

  @override
  void dispose() {
    customnavbarModel.dispose();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'form_model.dart';
export 'form_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  static String routeName = 'form';
  static String routePath = '/form';

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  late FormModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FormModel());

    _model.nameTextController ??= TextEditingController();
    _model.nameFocusNode ??= FocusNode();

    _model.addressTextController ??= TextEditingController();
    _model.addressFocusNode ??= FocusNode();

    _model.phoneTextController ??= TextEditingController();
    _model.phoneFocusNode ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  Future<void> saveUserDetailsToFirebase() async {
    final name = _model.nameTextController?.text.trim();
    final address = _model.addressTextController?.text.trim();
    final phone = _model.phoneTextController?.text.trim();
    final description = _model.descriptionTextController?.text.trim();


    final uid = FirebaseAuth.instance.currentUser?.uid;
    final userType = FFAppState().selectedUserType;

    if (uid == null || name == null || address == null || phone == null || description == null) {
      print("❌ Invalid input or user not signed in");
      return;
    }

    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

    await userRef.set({
      'name': name,
      'address': address,
      'phone': phone,
      'description': description,
      'userType': userType,
      'email': FirebaseAuth.instance.currentUser?.email ?? '',
      'uid': uid,
    }).then((_) {
      print(" Data saved successfully!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User info saved!")),
      );
    }).catchError((error) {
      print("Failed to save data: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Color(0xFFB7E4C7),
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 0.0, 0.0),
              child: Text(
                'Complete Your Profile',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'Inter Tight',
                      color: Colors.black,
                      fontSize: 24.0,
                      letterSpacing: 0.0,
                    ),
              ),
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Almost there! Help us serve you better.',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'Inter',
                              color: Colors.black,
                              letterSpacing: 0.0,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextFormField(
                                  controller: _model.nameTextController,
                                  focusNode: _model.nameFocusNode,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16.0, 12.0, 16.0, 12.0),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                      ),
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primary,
                                  validator: _model.nameTextControllerValidator
                                      .asValidator(context),
                                ),
                              ],
                            ),
                            Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextFormField(
                                  controller: _model.addressTextController,
                                  focusNode: _model.addressFocusNode,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16.0, 12.0, 16.0, 12.0),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                      ),
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primary,
                                  validator: _model
                                      .addressTextControllerValidator
                                      .asValidator(context),
                                ),
                              ],
                            ),
                            Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextFormField(
                                  controller: _model.phoneTextController,
                                  focusNode: _model.phoneFocusNode,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Phone',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Colors.black,
                                          letterSpacing: 0.0,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16.0, 12.0, 16.0, 12.0),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                      ),
                                  keyboardType: TextInputType.number,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primary,
                                  validator: _model.phoneTextControllerValidator
                                      .asValidator(context),
                                ),
                              ],
                            ),
                            Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextFormField(
                                  controller: _model.descriptionTextController,
                                  focusNode: _model.descriptionFocusNode,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Colors.black,
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Short Description of farm',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16.0, 24.0, 16.0, 12.0),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                      ),
                                  maxLines: 16,
                                  minLines: 6,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primary,
                                  validator: _model
                                      .descriptionTextControllerValidator
                                      .asValidator(context),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 12.0)),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 24.0, 0.0, 12.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await saveUserDetailsToFirebase();

                                  if (FFAppState().selectedUserType == 'Farmer') {
                                    // ✅ Assign shared wallet from .env (hardcode here in frontend)
                                    FFAppState().walletAddress = "0x40636c40693F6Da10278E8033c37747B8e6323bE"; // Replace with .env address
                                    FFAppState().privateKey =
                                    "e8ad78282d4d6b75c4ae2d7b701a3ce9dd475875e705d3f499276e10bc43c54a"; // Replace with .env private key

                                    print("✅ Assigned shared wallet to Farmer: ${FFAppState().walletAddress}");

                                    context.pushNamed(HomeWidget.routeName);
                                  } else if (FFAppState().selectedUserType == 'ShopKeeper') {
                                    context.pushNamed(HomeShopWidget.routeName);
                                  } else if (FFAppState().selectedUserType == 'Customer') {
                                    context.pushNamed(HomeCustomerWidget.routeName);
                                  }
                                },

                                text: 'Submit',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 48.0,
                                  padding: EdgeInsets.all(0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Color(0xFFB7E4C7),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Inter Tight',
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 4.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

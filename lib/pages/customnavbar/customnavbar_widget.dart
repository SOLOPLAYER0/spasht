import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'customnavbar_model.dart';
export 'customnavbar_model.dart';

class CustomnavbarWidget extends StatefulWidget {
  const CustomnavbarWidget({
    super.key,
    required this.page,
  });

  final String? page;

  @override
  State<CustomnavbarWidget> createState() => _CustomnavbarWidgetState();
}

class _CustomnavbarWidgetState extends State<CustomnavbarWidget> {
  late CustomnavbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomnavbarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional(0.0, 1.0),
          child: Container(
            width: double.infinity,
            height: 100.0,
            decoration: BoxDecoration(
              color: Color(0xFFB7E4C7),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderRadius: 8.0,
                                  buttonSize: 48.0,
                                  fillColor: Color(0x00F8F8F8),
                                  icon: Icon(
                                    Icons.home,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                  onPressed: () async {
                                    if (FFAppState().selectedUserType == 'Farmer') {
                                      context.pushNamed(HomeWidget.routeName);
                                    } else if (FFAppState().selectedUserType == 'ShopKeeper') {
                                      context.pushNamed(HomeShopWidget.routeName);
                                    } else if (FFAppState().selectedUserType == 'Customer') {
                                      context.pushNamed(HomeCustomerWidget.routeName);
                                    }
                                  },
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Text(
                                    'Home',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Inter',
                                      color: Colors.black,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 48.0,
                                fillColor: Color(0x00FFFFFF),
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 30.0,
                                ),
                                onPressed: () async {
                                  final userId = FirebaseAuth.instance.currentUser?.uid;

                                  if (FFAppState().selectedUserType == 'Farmer') {
                                    context.pushNamed(
                                      ProfileFarmerWidget.routeName,
                                      queryParameters: {
                                        'userId': serializeParam(userId, ParamType.String),
                                      },
                                    );
                                  } else if (FFAppState().selectedUserType == 'ShopKeeper') {
                                    context.pushNamed(
                                      ProfileShopWidget.routeName,
                                      queryParameters: {
                                        'userId': serializeParam(userId, ParamType.String),
                                      },
                                    );
                                  } else if (FFAppState().selectedUserType == 'Customer') {
                                    context.pushNamed(
                                      ProfileCustomerWidget.routeName,
                                      queryParameters: {
                                        'userId': serializeParam(userId, ParamType.String),
                                      },
                                    );
                                  }
                                },
                              ),
                              Text(
                                'Profile',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 8.0,
                                    buttonSize: 48.0,
                                    fillColor: Color(0x00FFFFFF),
                                    icon: Icon(
                                      Icons.logout_rounded,
                                      color: Colors.black,
                                      size: 35.0,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ),
                                Text(
                                  'Log Out',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    color: Colors.black,
                                    letterSpacing: 0.0,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

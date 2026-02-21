import  '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_type_model.dart';
export 'user_type_model.dart';

class UserTypeWidget extends StatefulWidget {
  const UserTypeWidget({super.key});

  static String routeName = 'UserType';
  static String routePath = '/userType';

  @override
  State<UserTypeWidget> createState() => _UserTypeWidgetState();
}

class _UserTypeWidgetState extends State<UserTypeWidget> {
  late UserTypeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserTypeModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Color(0xFFF8F9FA),
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Text(
              'Who are you?',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Outfit',
                    color: Colors.black,
                    fontSize: 32.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional(-0.3, 0.0),
                child: Text(
                  'Select your role to continue creating your account.',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: Colors.black,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/5105270.jpg',
                          width: 371.5,
                          height: 242.9,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flex(
                      direction: Axis.vertical,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              FFAppState().selectedUserType = 'Farmer';
                              safeSetState(() {});

                              context.pushNamed(
                                CreateAccountWidget.routeName,
                                queryParameters: {
                                  'useType': serializeParam(
                                    'Farmer',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            text: 'Farmer',
                            options: FFButtonOptions(
                              width: 350.0,
                              height: 60.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
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
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Flex(
                      direction: Axis.vertical,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              FFAppState().selectedUserType = 'ShopKeeper';
                              safeSetState(() {});

                              context.pushNamed(
                                CreateAccountWidget.routeName,
                                queryParameters: {
                                  'useType': serializeParam(
                                    'ShopKeeper',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            text: 'ShopKeeper',
                            options: FFButtonOptions(
                              width: 350.0,
                              height: 60.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
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
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Flex(
                      direction: Axis.vertical,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              FFAppState().selectedUserType = 'Customer';
                              safeSetState(() {});

                              context.pushNamed(
                                CreateAccountWidget.routeName,
                                queryParameters: {
                                  'useType': serializeParam(
                                    'Customer',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            text: 'Customer',
                            options: FFButtonOptions(
                              width: 350.0,
                              height: 60.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
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
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

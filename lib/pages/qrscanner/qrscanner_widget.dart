import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'qrscanner_model.dart';
export 'qrscanner_model.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:spasht/pages/tracking/tracking_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';



class QrscannerWidget extends StatefulWidget {
  const QrscannerWidget({super.key});


  static String routeName = 'qrscanner';
  static String routePath = '/qrscanner';

@override
  State<QrscannerWidget> createState() => _QrscannerWidgetState();
}

class _QrscannerWidgetState extends State<QrscannerWidget> {
  late QrscannerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _scanned = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QrscannerModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<Position> _getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, cannot request.');
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Drawer(
          elevation: 16.0,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF8F9FA),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 35.0, 20.0, 35.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0),
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0),
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0),
                            ),
                            child: Image.network(
                              'https://picsum.photos/seed/199/600',
                              width: 150.0,
                              height: 150.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Text(
                                  FFAppState().name,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  FFAppState().selectedUserType,
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: Container(
                        width: 266.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (FFAppState().selectedUserType == 'Farmer') {
                            context.pushNamed(ProfileFarmerWidget.routeName);
                          } else {
                            if (FFAppState().selectedUserType == 'ShopKeeper') {
                              context.pushNamed(ProfileShopWidget.routeName);
                            } else {
                              if (FFAppState().selectedUserType == 'Customer') {
                                context
                                    .pushNamed(ProfileCustomerWidget.routeName);
                              }
                            }
                          }
                        },
                        child: Container(
                          height: 55.0,
                          decoration: BoxDecoration(
                            color: Color(0x1A2F80ED),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 24.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'View Profile',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
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
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: Container(
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Color(0x1A2F80ED),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (FFAppState().selectedUserType == 'Farmer') {
                              context.pushNamed(HomeWidget.routeName);
                            } else {
                              if (FFAppState().selectedUserType ==
                                  'ShopKeeper') {
                                context.pushNamed(HomeShopWidget.routeName);
                              } else {
                                if (FFAppState().selectedUserType ==
                                    'Customer') {
                                  context
                                      .pushNamed(HomeCustomerWidget.routeName);
                                }
                              }
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  Icons.home,
                                  color: Colors.black,
                                  size: 24.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Home',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
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
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: Container(
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Color(0x1A2F80ED),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Icon(
                                Icons.reviews,
                                color: Colors.black,
                                size: 24.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Reviews / Feedback',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: Container(
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Color(0x1A2F80ED),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Icon(
                                Icons.menu_book_rounded,
                                color: Colors.black,
                                size: 24.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'About',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: Container(
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Color(0x1A2F80ED),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Icon(
                                Icons.help_center,
                                color: Colors.black,
                                size: 24.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Help & Support',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: Container(
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Color(0x1A2F80ED),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Icon(
                                Icons.settings_rounded,
                                color: Colors.black,
                                size: 24.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Settings',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 170.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'Log Out',
                        options: FFButtonOptions(
                          width: 260.0,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFF2F80ED),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Inter Tight',
                                    color: Colors.black,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFFB7E4C7),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.menu,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () async {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Text(
            'QR Scanner',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: Colors.black,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: MobileScanner(
          onDetect: (capture) async {
            if (_scanned) return; // prevent double scan
            final List<Barcode> barcodes = capture.barcodes;
            if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
              _scanned = true;
              final String qrHash = barcodes.first.rawValue!;
              try {
                // 🔹 Get GPS location
                final position = await _getCurrentLocation();
                final locationString =
                    "${position.latitude}, ${position.longitude}";

                // ✅ Call FastAPI /scan-qr (shared wallet handled in backend)
                final response = await http.post(
                  Uri.parse("https://6f9117714359.ngrok-free.app/scan-qr"),
                  headers: {"Content-Type": "application/json"},
                  body: jsonEncode({
                    "qr_hash": qrHash,
                    "location": locationString,
                    "scanner_name": FFAppState().name, // 👈 store which user scanned
                  }),
                );

                if (response.statusCode == 200) {
                  final result = jsonDecode(response.body);

                  // ✅ Navigate to Tracking screen with blockchain + Firebase data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackingWidget(
                        productName: qrHash,
                        blockchainData: result,
                      ),
                    ),
                  ).then((_) {
                    _scanned = false; // reset after coming back
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed: ${response.body}")),
                  );
                  _scanned = false;
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: $e")),
                );
              _scanned = false;
            }
            }
          },
        ),
      ),
    );
  }
}

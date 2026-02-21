import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'generate_q_r_model.dart';
export 'generate_q_r_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data'; // for base64 decode
import 'package:geolocator/geolocator.dart';
class GenerateQRWidget extends StatefulWidget {
  const GenerateQRWidget({super.key});

  static String routeName = 'GenerateQR';
  static String routePath = '/generateQR';

  @override
  State<GenerateQRWidget> createState() => _GenerateQRWidgetState();
}

class _GenerateQRWidgetState extends State<GenerateQRWidget> {
  late GenerateQRModel _model;
  bool isLoading = false;
  String? errorMessage;
  String? txHash;
  Uint8List? qrImageBytes;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GenerateQRModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // ✅ Get current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> generateQR() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      txHash = null;
      qrImageBytes = null;
    });

    final url = Uri.parse("https://6f9117714359.ngrok-free.app/register-qr");

    try {
      // 🔹 Get GPS location
      final position = await _getCurrentLocation();
      final locationString = "${position.latitude}, ${position.longitude}";

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "farmer_name": FFAppState().name,   // 👈 match FastAPI model
          "location": locationString,         // 👈 now sending location
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          txHash = data["transaction"];
          qrImageBytes = base64Decode(data["qr_image_base64"]);
        });
      } else {
        setState(() {
          errorMessage = "Error: ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Exception: $e";
      });
    } finally {
      setState(() => isLoading = false);
    }
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
          // your existing drawer content here...
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFFB7E4C7),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () async {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Text(
            'Generate QR',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: Colors.black,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: isLoading ? null : generateQR,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Generate QR"),
                ),
                const SizedBox(height: 20),
                if (errorMessage != null) ...[
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                if (txHash != null) ...[
                  Text("Transaction Hash:",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  SelectableText(txHash!),
                ],
                const SizedBox(height: 20),
                if (qrImageBytes != null)
                  Image.memory(qrImageBytes!, height: 200, width: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

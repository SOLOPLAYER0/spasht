import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'tracking_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TrackingWidget extends StatefulWidget {
  const TrackingWidget({
    super.key,
    this.productName,
    String? price,
    this.blockchainData,
    this.qrId,
  }) : price = price ?? '';

  final String? productName;
  final String price;
  final String? qrId;

  /// Example shape of blockchainData:
  /// {
  ///   "qr_id": "...",
  ///   "farmer_name": "Akash",
  ///   "registered_at": 1732100000,
  ///   "entry_time": 1732100000,
  ///   "exit_time": 1732180000,
  ///   "seller_name": "Rohan",
  ///   "scan_count": 3,
  ///   "journey": [
  ///      {"location":"Farm A","scanner_name":"Akash","scanTime":...,"scanType":"Farmer Registration"},
  ///      {"location":"Shop 24","scanner_name":"Rohan","scanTime":...,"scanType":"Seller Entry"},
  ///      ...
  ///   ]
  /// }
  final Map<String, dynamic>? blockchainData;

  static String routeName = 'tracking';
  static String routePath = '/tracking';

  @override
  State<TrackingWidget> createState() => _TrackingWidgetState();
}

class _TrackingWidgetState extends State<TrackingWidget> {
  late TrackingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // --------- helpers ---------

  String _formatDateFromSeconds(dynamic ts) {
    if (ts == null) return 'N/A';
    if (ts is! num) return 'N/A';
    final intSeconds = ts.toInt();
    if (intSeconds == 0) return 'N/A';
    final dt =
    DateTime.fromMillisecondsSinceEpoch(intSeconds * 1000, isUtc: false);
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final y = dt.year.toString();
    return '$d/$m/$y';
  }

  String _formatDateTimeFromSeconds(dynamic ts) {
    if (ts == null) return 'N/A';
    if (ts is! num) return 'N/A';
    final intSeconds = ts.toInt();
    if (intSeconds == 0) return 'N/A';
    final dt =
    DateTime.fromMillisecondsSinceEpoch(intSeconds * 1000, isUtc: false);
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final y = dt.year.toString();
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    return '$d/$m/$y  $hh:$mm';
  }

  List<dynamic> _extractJourney(dynamic raw) {
    if (raw == null) return [];
    if (raw is List) return raw;
    return [];
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TrackingModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    final data = widget.blockchainData ?? <String, dynamic>{};

    // --------- parse incoming data safely ---------

    // IDs
    final qrId = widget.qrId ?? data['qr_id']?.toString();

    // Names
    final farmerName =
        data['farmer_name'] ?? data['farmerName'] ?? 'Unknown Farmer';

    String sellerName =
        data['seller_name'] ?? data['sellerName'] ?? 'Not assigned yet';

    // Times
    final registeredAt =
        data['registered_at'] ?? data['entry_time'] ?? data['entryTime'];
    final exitTime = data['exit_time'] ?? data['exitTime'];

    // Journey + scans
    final journey = _extractJourney(data['journey']);
    final scanCount = (data['scan_count'] ??
        data['scanCount'] ??
        (journey.isNotEmpty ? journey.length : 0)) as int;

    // If sellerName not provided but there are journey steps, infer from last scan
    if (sellerName == 'Not assigned yet' && journey.isNotEmpty) {
      final last = journey.last;
      if (last is Map && last['scanner_name'] != null) {
        sellerName = last['scanner_name'].toString();
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFB7E4C7),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 28.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Align(
            alignment: const AlignmentDirectional(-1.0, 0.0),
            child: Text(
              'Tracking Journey',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Top intro text
              Padding(
                padding:
                const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Here is the tracking journey of your product',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (qrId != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          qrId,
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              if (widget.productName != null || widget.price.isNotEmpty)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 4.0, 16.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.productName != null)
                        Text(
                          widget.productName!,
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      if (widget.price.isNotEmpty)
                        Text(
                          widget.price,
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    ],
                  ),
                ),

              // Farmer card
              Padding(
                padding:
                const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF52B788),
                          size: 24,
                        ),
                        Container(
                          width: 3,
                          height: 64,
                          color: const Color(0xFFB7E4C7),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC7CBD6),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFC7CBD6),
                          width: 3,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          'assets/images/istockphoto-1363571533-612x612.jpg',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Farmer : $farmerName',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Inter',
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Harvested on : ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _formatDateFromSeconds(registeredAt),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                'Dispatched on : ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _formatDateFromSeconds(exitTime),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
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

              // Seller summary card
              Padding(
                padding:
                const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF52B788),
                          size: 24,
                        ),
                        Container(
                          width: 3,
                          height: 64,
                          color: const Color(0xFFB7E4C7),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC7CBD6),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFC7CBD6),
                          width: 3,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          'assets/images/3919113.jpg',
                          width: 90,
                          height: 90,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Seller : $sellerName',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Inter',
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Total scans : ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                scanCount.toString(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
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

              // Journey Timeline
              Padding(
                padding:
                const EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Journey Timeline',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (journey.isEmpty)
                      Text(
                        'No journey data yet. Scan the QR to start tracking.',
                        style:
                        FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      )
                    else
                      Column(
                        children: List.generate(journey.length, (index) {
                          final step = journey[index];
                          String title;
                          String subtitle;
                          if (step is Map) {
                            final location = step['location']?.toString() ?? '';
                            final scanType =
                                step['scanType']?.toString() ?? 'Scan';
                            final scannerName =
                                step['scanner_name']?.toString() ??
                                    'Unknown person';
                            final ts = step['scanTime'];
                            final timeStr = _formatDateTimeFromSeconds(ts);
                            title =
                            '$scanType at $location'; // main line
                            subtitle =
                            'Scanned by: $scannerName\nTime: $timeStr';
                          } else {
                            title = step.toString();
                            subtitle = '';
                          }

                          final isLast = index == journey.length - 1;

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.radio_button_checked,
                                    color: isLast
                                        ? const Color(0xFF2F80ED)
                                        : const Color(0xFF52B788),
                                    size: 18,
                                  ),
                                  if (!isLast)
                                    Container(
                                      width: 2,
                                      height: 40,
                                      color: const Color(0xFFB7E4C7),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Inter',
                                          color: Colors.black87,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if (subtitle.isNotEmpty)
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 2.0),
                                          child: Text(
                                            subtitle,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Inter',
                                              color: Colors.black54,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
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

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/customnavbar/customnavbar_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for customnavbar component.
  late CustomnavbarModel customnavbarModel;

  @override
  void initState(BuildContext context) {
    customnavbarModel = createModel(context, () => CustomnavbarModel());
  }

  @override
  void dispose() {
    customnavbarModel.dispose();
  }
}

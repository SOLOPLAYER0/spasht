import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _address = '';
  String get address => _address;
  set address(String value) {
    _address = value;
  }

  DateTime? _HarvestDate = DateTime.fromMillisecondsSinceEpoch(1743921300000);
  DateTime? get HarvestDate => _HarvestDate;
  set HarvestDate(DateTime? value) {
    _HarvestDate = value;
  }

  String _Status = '';
  String get Status => _Status;
  set Status(String value) {
    _Status = value;
  }

  String _selectedUserType = '';
  String get selectedUserType => _selectedUserType;
  set selectedUserType(String value) {
    _selectedUserType = value;
  }

  String _name = '';
  String get name => _name;
  set name(String value) {
    _name = value;
  }

  String _emailAddress = '';
  String get emailAddress => _emailAddress;
  set emailAddress(String value) {
    _emailAddress = value;
  }

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String _about = '';
  String get about => _about;
  set about(String value) {
    _about = value;
  }

  DateTime? _receiveDate = DateTime.fromMillisecondsSinceEpoch(1744181520000);
  DateTime? get receiveDate => _receiveDate;
  set receiveDate(DateTime? value) {
    _receiveDate = value;
  }

  DateTime? _dispatchDate = DateTime.fromMillisecondsSinceEpoch(1744181580000);
  DateTime? get dispatchDate => _dispatchDate;

  String _walletAddress = '';
  String get walletAddress => _walletAddress;
  set walletAddress(String value) {
    _walletAddress = value;
    notifyListeners();
  }

  String _privateKey = '';
  String get privateKey => _privateKey;
  set privateKey(String value) {
    _privateKey = value;
    notifyListeners();
  }
}


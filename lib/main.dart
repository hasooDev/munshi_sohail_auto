import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sohail_auto/munshi_sohail_auto.dart';
import 'package:sohail_auto/utility/request_permission_handler.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await requestStoragePermission();
  /*await Supabase.initialize(
    url: 'https://zumfijdevomrcetniemn.supabase.co', // Replace this
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1bWZpamRldm9tcmNldG5pZW1uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM0Mzk3NzIsImV4cCI6MjA2OTAxNTc3Mn0.aTJq8naDqprPChJ0DPWsMvqLTM-KNy8TPKRvWVlzXJE', // Replace this
  );*/
  /*Status Bar Colors*/
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,

  ));


  runApp( MunshiSohailAuto());
}


import 'package:flutter/material.dart';
import 'package:reefy/app/app.dart';
import 'package:reefy/shared/shared_preference_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  CacheNetwork.cacheInitialization();
  runApp( MyApp());
}

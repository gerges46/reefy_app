import 'package:checkin/app/app.dart';
import 'package:checkin/shared/server_locator.dart';
import 'package:checkin/shared/shared_preference_helper.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  CacheNetwork.cacheInitialization();
  //final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

   setupLocator();
  runApp( MyApp());
}

import 'package:checkin/app/app.dart';
import 'package:checkin/shared/bloc_observer.dart';
import 'package:checkin/shared/server_locator.dart';
import 'package:checkin/shared/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheInitialization();
    Bloc.observer = MyBlocObserver();
  setupLocator();
  runApp(MyApp());
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/core/di/di.dart';
import 'package:i_pharaoh/core/observer/bloc_observer.dart';

import 'i_pharo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();
  Bloc.observer = IPharoeBlocObserver();
  runApp(const IPharo());
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_navigator/application/bloc_observer.dart';
import 'package:simple_navigator/presentation/app_root.dart';
import 'package:bloc/bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(AppRoot());
}

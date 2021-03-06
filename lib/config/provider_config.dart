import 'package:flutter/material.dart';
import 'package:mobile_code_challenge_solution/core/providers/controller/provider.dart';
import 'package:mobile_code_challenge_solution/core/providers/get_repos/provider.dart';
import 'package:mobile_code_challenge_solution/core/providers/theme_provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
      create: (BuildContext context) => RepositoryProvider()),
  ChangeNotifierProvider(
      create: (BuildContext context) => ControllerProvider()),
  ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider()),
];

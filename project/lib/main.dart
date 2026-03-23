import 'package:flutter/material.dart';
import 'package:project/presentation-view/providers/appProvider.dart';
import 'package:project/presentation-view/ui/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AppProvider(
    child: MaterialApp(home: HomePage()),
  ));
}

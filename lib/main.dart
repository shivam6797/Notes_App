import 'package:flutter/material.dart';
import 'package:notes_app/app_routes.dart';
import 'package:notes_app/db/db_helper.dart';
import 'package:notes_app/provider/db_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (context) => DbProvider(dbHelper: DbHelper.getInstance())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.ROUTE_SPLASH,
      routes: AppRoutes.getRoutes(),
    );
  }
}

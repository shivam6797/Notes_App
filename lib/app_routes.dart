import 'package:flutter/material.dart';
import 'package:notes_app/splash_screen.dart';
import 'package:notes_app/ui/add_note_screen.dart';
import 'package:notes_app/ui/edit_note_screen.dart';
import 'package:notes_app/ui/note_screen.dart';

class AppRoutes {
  static const String ROUTE_SPLASH = "/";
  static const String ROUTE_HOME = "/home";
  static const String ROUTE_ADD_NOTE = "/add_note";
  static const String ROUTE_EDIT_NOTE = "/edit_note";

  static Map<String, WidgetBuilder> getRoutes() => {
        ROUTE_SPLASH: (context) => SplashScreen(),
        ROUTE_HOME: (context) => NotesScreen(),
        ROUTE_ADD_NOTE: (context) => NoteDetailScreen(),
        ROUTE_EDIT_NOTE: (context) => NoteEditScreen(),
      };
}

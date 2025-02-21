import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/app_routes.dart';

class EditNoteScreen extends StatelessWidget {
  const EditNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 35,
                      width: 45,
                      margin: EdgeInsets.only(right: 15, top: 10, bottom: 5),
                      decoration: BoxDecoration(
                        color: Color(0xff3b3b3b),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(FontAwesomeIcons.chevronLeft,
                          size: 16, color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.ROUTE_EDIT_NOTE);
                    },
                    child: Container(
                      height: 35,
                      width: 45,
                      margin: EdgeInsets.only(right: 15, top: 10, bottom: 5),
                      decoration: BoxDecoration(
                        color: Color(0xff3b3b3b),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(FontAwesomeIcons.penToSquare,
                          size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Text(
                "Beautiful weather app UI concepts we wish existed",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Nunito',
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "May 21, 2020",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[400],
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal
                ),
              ),

              const SizedBox(height: 15),

              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    "Who would have thought there could be so many creative ways to tell the temperature? "
                    "Today's daily dose of design inspiration is all about the weather. In this collection "
                    "of UI designs, we're sharing a handful of beautiful mobile weather app concepts that we "
                    "wish existed in real life.\n\n"
                    "Weather apps are quite the popular interface theme for designers to explore. But don’t "
                    "let these effortlessly clean designs fool you. When it comes to the weather, there’s a lot "
                    "of data designers have to arrange which can be quite a challenge. Regardless, it’s a great "
                    "way to practice your UI skills.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      height: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

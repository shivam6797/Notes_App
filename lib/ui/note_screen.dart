import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/app_routes.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});

  final List<Map<String, String>> notes = [
    {"title": "How to make your personal brand stand out online", "date": "May 21, 2020", "color": "FFEF9A9A"},
    {"title": "Beautiful weather app UI concepts we wish existed", "date": "Mar 18, 2020", "color": "FFFFE082"},
    {"title": "10 excellent font pairing tools for designers", "date": "Feb 01, 2020", "color": "FFDCE775"},
    {"title": "Spotify’s Reema Bhagat on product design, music, and career", "date": "Feb 01, 2020", "color": "FF80DEEA"},
    {"title": "12 eye-catching mobile wallpaper", "date": "Feb 01, 2020", "color": "FFCE93D8"},
    {"title": "Design For Good: Join The Face Mask Challenge", "date": "Feb 01, 2020", "color": "FFE57373"},
    {"title": "Hello Daily Challenges: Join The Face Mask Challenge", "date": "Feb 01, 2020", "color": "FF7fcbc3"},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Notes", style: TextStyle(fontSize: 28, color: Colors.white,fontFamily:"Poppins")),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          Container(
                height: 35,
                width: 45,
                margin: EdgeInsets.only(right:15,top:10,bottom:5),
                decoration: BoxDecoration(
                    color: Color(0xff3b3b3b),
                    borderRadius: BorderRadius.circular(10),
                  ),
                child: const Icon(FontAwesomeIcons.search,
                    size: 18, color: Colors.white),
                    ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:10.0,left:10,right:10),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing:12,
            children: [
              NoteCard(title: notes[0]["title"]!, date: notes[0]["date"]!, color: Color(int.parse("0x${notes[0]["color"]}")), crossAxisCount: 1, mainAxisCount: 1,titleFontSize: 17,),
              NoteCard(title: notes[1]["title"]!, date: notes[1]["date"]!, color: Color(int.parse("0x${notes[1]["color"]}")), crossAxisCount: 1, mainAxisCount: 1,),
              NoteCard(title: notes[2]["title"]!, date: notes[2]["date"]!, color: Color(int.parse("0x${notes[2]["color"]}")), crossAxisCount: 2, mainAxisCount: 1,titleFontSize: 25,),
              IntrinsicHeight(child: NoteCard(title: notes[3]["title"]!, date: notes[3]["date"]!, color: Color(int.parse("0x${notes[3]["color"]}")), crossAxisCount: 1, mainAxisCount: 2,titleFontSize:20,)),
              NoteCard(title: notes[4]["title"]!, date: notes[4]["date"]!, color: Color(int.parse("0x${notes[4]["color"]}")), crossAxisCount: 1, mainAxisCount: 1,titleFontSize: 18,),
              NoteCard(title: notes[5]["title"]!, date: notes[5]["date"]!, color: Color(int.parse("0x${notes[5]["color"]}")), crossAxisCount: 1, mainAxisCount: 1,),
              NoteCard(title: notes[6]["title"]!, date: notes[6]["date"]!, color: Color(int.parse("0x${notes[6]["color"]}")), crossAxisCount: 1, mainAxisCount: 1,titleFontSize:15,),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.ROUTE_ADD_NOTE);
        },
        backgroundColor: Color(0xff252525),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final String title;
  final String date;
  final Color color;
  final int crossAxisCount;
  final int mainAxisCount;
  final double titleFontSize;

  const NoteCard({
    super.key,
    required this.title,
    required this.date,
    required this.color,
    required this.crossAxisCount,
    required this.mainAxisCount,
    this.titleFontSize = 16,

  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: crossAxisCount,
      mainAxisCellCount: mainAxisCount,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
                fontFamily: 'Nunito',
              ),
            ),
            const SizedBox(height: 8),
             if (crossAxisCount == 2 && mainAxisCount == 1)
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    fontFamily: 'Poppins',
                  ),
                ),
              )
            else
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                  fontFamily: 'Poppins',
                ),
              ),
          ],
        ),
      ),
    );
  }
}


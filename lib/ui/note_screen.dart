import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:notes_app/app_routes.dart';
import 'package:notes_app/db/db_helper.dart';
import 'package:notes_app/model/note_model.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  DbHelper? mDb;
  DateFormat df = DateFormat.yMMMEd();
  List<NoteModel> mData = [];

  final List<Color> noteColors = [
    Color(0xFFee999c),
    Color(0xFFffe083),
    Color(0xFFdee676),
    Color(0xFFA5D6A7),
    Color(0xFF80ddec),
    Color(0xFFCF93D9),
    Color(0xFFe77273),
    Color(0xFFe57373),
  ];

  @override
  void initState() {
    super.initState();
    mDb = DbHelper.getInstance();
    getAllNotes();
  }

  void getAllNotes() async {
    mData = await mDb!.fetchAllNotes();
    setState(() {});
  }

  void deleteNote(int index) async {
    await mDb!.deleteNote(mData[index].nId!);
    mData.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Notes",
            style: TextStyle(
                fontSize: 28, color: Colors.white, fontFamily: "Poppins")),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          Container(
            height: 35,
            width: 45,
            margin: EdgeInsets.only(right: 15, top: 10, bottom: 5),
            decoration: BoxDecoration(
              color: Color(0xff1c2834),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(FontAwesomeIcons.search,
                size: 18, color: Colors.white),
          ),
        ],
      ),
      body: mData.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: List.generate(mData.length, (index) {
                  var eachDate = DateTime.fromMillisecondsSinceEpoch(
                      int.parse(mData[index].nCreatedAt));

                  return GestureDetector(
                    onLongPress: () => showDeleteBottomSheet(index),
                    child: NoteCard(
                      title: mData[index].nTitle,
                      desc: mData[index].nDesc,
                      date: df.format(eachDate),
                      color: noteColors[index % noteColors.length],
                      isLarge: index == 2,
                    ),
                  );
                }),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.black.withOpacity(0.6),
                strokeWidth: 2,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? isUpdated = await Navigator.pushNamed(
              context, AppRoutes.ROUTE_ADD_NOTE,
              arguments: mDb) as bool?;
          if (isUpdated == true) {
            getAllNotes();
          }
        },
        backgroundColor: Color(0xff1c2834),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void showDeleteBottomSheet(int index) {
    showModalBottomSheet(
      backgroundColor: Color(0xff1c2834),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xff1c2834),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 70,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Delete Note?",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins"),
              ),
              SizedBox(height: 8),
              Text(
                "Are you sure you want to delete this note?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        deleteNote(index);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        minimumSize: Size(100, 40),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.white, width: 1.0)),
                      ),
                      child: Text("Delete",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        minimumSize: Size(100, 40),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.white, width: 1.0)),
                      ),
                      child: Text("Cancel",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class NoteCard extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  final Color color;
  final bool isLarge;

  const NoteCard({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
    required this.color,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: isLarge ? 2 : 1,
      mainAxisCellCount: isLarge ? 1.1 : 1,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Text(
                title,
                style: TextStyle(
                  fontSize: isLarge ? 18 : 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Nunito',
                  color: Colors.black,
                ),
                maxLines: isLarge ? 3 : 2,
                overflow: TextOverflow.ellipsis,
              ),
            if (title.isNotEmpty) SizedBox(height: 5),
            Text(
              desc,
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.9),
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

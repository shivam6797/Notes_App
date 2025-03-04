import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/app_routes.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:provider/provider.dart';
import '../provider/db_provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  DateFormat df = DateFormat.yMMMEd();
  List<NoteModel> mData = [];

  final List<Color> noteColors = [
    Color(0xFFFFAB91),
    Color(0xFFFFCC80),
    Color(0xFFE6EE9B),
    Color(0xFFA5D6A7),
    Color(0xFF80DEEA),
    Color(0xFFCF93D9),
    Color(0xFFF48FB1),
    Color(0xFFB0BEC5),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<DbProvider>(context, listen: false).fetchInitialData();
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
          IconButton(
            icon: Icon(FontAwesomeIcons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<DbProvider>(builder: (_, provider, __) {
        mData = provider.getAllNotes();
        return Padding(
          padding: const EdgeInsets.all(10),
          child: MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemCount: mData.length,
            itemBuilder: (context, index) {
              var eachDate = DateTime.fromMillisecondsSinceEpoch(
                  int.parse(mData[index].nCreatedAt));

              bool isLarge = (index % 4 == 0 || index == 1);

              return GestureDetector(
                onLongPress: () => showDeleteBottomSheet(index),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.ROUTE_EDIT_NOTE,
                    arguments: {
                      "id": mData[index].nId.toString(),
                      "title": mData[index].nTitle,
                      "desc": mData[index].nDesc,
                       'date': mData[index].nCreatedAt,
                    },
                  );
                },
                child: NoteCard(
                  title: mData[index].nTitle,
                  desc: mData[index].nDesc,
                  date: df.format(eachDate),
                  color: noteColors[index % noteColors.length],
                  isLarge: isLarge,
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, AppRoutes.ROUTE_ADD_NOTE);
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
                        context
                            .read<DbProvider>()
                            .deleteNote(mData[index].nId!);
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
    return Container(
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          if (title.isNotEmpty) SizedBox(height: 5),
          Text(
            desc,
            style: TextStyle(
              fontSize: isLarge ? 15 : 13,
              color: Colors.black.withOpacity(0.8),
              fontFamily: 'Poppins',
            ),
            maxLines: isLarge ? 5 : 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          Text(
            date,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.7),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

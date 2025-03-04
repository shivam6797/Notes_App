import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/app_routes.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/provider/db_provider.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  int? noteId;
  String formattedDate = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    if (args != null) {
      noteId = int.tryParse(args['id'].toString());
      titleController.text = args['title'] ?? '';
      descController.text = args['desc'] ?? '';

      // Convert date from milliseconds to readable format
      if (args['date'] != null) {
        int timestamp = int.tryParse(args['date'].toString()) ?? 0;
        if (timestamp > 0) {
          formattedDate = DateFormat.yMMMEd().format(
            DateTime.fromMillisecondsSinceEpoch(timestamp),
          );
        }
      }
    }
  }

  void updateNote() {
    if (noteId == null ||
        titleController.text.isEmpty ||
        descController.text.isEmpty) return;

    final updatedNote = NoteModel(
      nId: noteId!, // Int id
      nTitle: titleController.text,
      nDesc: descController.text,
      nCreatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    Provider.of<DbProvider>(context, listen: false).updateNote(updatedNote);
    Navigator.pop(context);
  }

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
                      updateNote();
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
              TextField(
                controller: titleController,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontSize: 24,
                    color: Color(0xff939393),
                    fontFamily: 'Nunito',
                  ),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                formattedDate.isNotEmpty ? formattedDate : "No Date Available",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[400],
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: TextField(
                  controller: descController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Type something...",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                    ),
                    border: InputBorder.none,
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

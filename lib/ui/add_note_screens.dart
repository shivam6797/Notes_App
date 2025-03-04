import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:provider/provider.dart';
import '../provider/db_provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
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
                      height: 40,
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
                  GestureDetector(
                    onTap: () async {
                      // Add New Note
                      if (titleController.text.isNotEmpty &&
                          descController.text.isNotEmpty) {
                        context.read<DbProvider>().addNote(
                              NoteModel(
                                nTitle: titleController.text,
                                nDesc: descController.text,
                                nCreatedAt: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                              ),
                            );
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 70,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 5, top: 10, bottom: 5),
                      decoration: BoxDecoration(
                        color: Color(0xff3b3b3b),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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

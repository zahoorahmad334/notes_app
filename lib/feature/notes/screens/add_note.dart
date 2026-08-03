import 'package:flutter/material.dart';
import 'package:notes_app/customs/button_widget.dart';
import 'package:notes_app/feature/notes/services/notes_firebase_services.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Add Notes",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 190,
                child: Center(
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: "title",
                      hintText: 'Note title',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),

              TextFormField(
                controller: desController,
                keyboardType: TextInputType.multiline,
                maxLines: 18,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Enter note description...",
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              SizedBox(height: 60),

              ButtonWidget(
                text: "Add Note",
                onPressed: () async {
                  NotesServices notesServices = NotesServices();
                  await notesServices.addNote(
                    titleController.text,
                    desController.text,
                  );
                  Navigator.pop(context);
                },
                width: double.infinity,
                height: 70,
                backgroundColor: Colors.blueAccent,
                textColor: Colors.white,
                borderRadius: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

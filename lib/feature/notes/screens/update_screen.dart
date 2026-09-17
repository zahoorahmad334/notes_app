import 'package:flutter/material.dart';
import 'package:notes_app/customs/button_widget.dart';
import 'package:notes_app/feature/notes/services/notes_firebase_services.dart';

class UpdateScreen extends StatefulWidget {
  final String title;
  final String description;
  final String id;
  UpdateScreen({
    super.key,
    required this.title,
    required this.description,
    required this.id,
  });

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController titleController;
  late TextEditingController desController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.title);
    desController = TextEditingController(text: widget.description);
    super.initState();
  }

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
                decoration: InputDecoration(
                  hintText: 'description',
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "description",
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
                  notesServices.updateNote(
                    titleController.text,
                    desController.text,
                    widget.id,
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/feature/notes/screens/add_note.dart';
import 'package:notes_app/feature/notes/screens/update_screen.dart';
import 'package:notes_app/feature/notes/services/notes_firebase_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Notes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Field
            TextFormField(
              decoration: InputDecoration(
                hintText: "Search notes...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Notes List
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("notes")
                  .snapshots(),
              builder: (context, snapshot) {
                final notes = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    itemCount: notes.length,

                    itemBuilder: (context, index) {
                      final item = notes[index];

                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(blurRadius: 2, offset: Offset(0, 2)),
                          ],
                        ),
                        child: ListTile(
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => UpdateScreen(
                                        title: item["title"],
                                        description: item["description"],
                                        id: item.id,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit, color: Colors.blue),
                              ),
                              IconButton(
                                onPressed: () {
                                  NotesServices notesServices = NotesServices();
                                  notesServices.deleteNote(item.id);
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                          title: Text(
                            item["title"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            item["description"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddNote()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

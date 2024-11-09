import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodels/note_provider.dart';
import '../models/note.dart';
import 'note_edit_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NoteProvider>(context).notes;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MySimpleNote',
          style: TextStyle(fontSize: 24.sp), // Responsive font size
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: notes.isEmpty
          ? Center(
        child: Text(
          'No notes yet. Start adding!',
          style: TextStyle(fontSize: 18.sp, color: Colors.grey), // Responsive font size
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(8.0.w), // Responsive padding
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 6.h), // Responsive margin
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r), // Responsive radius
              border: Border.all(color: Colors.blueAccent, width: 2.w), // Responsive border
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                note.title,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                note.timestamp,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NoteEditScreen(note: note)),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NoteEditScreen()),
        ),
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

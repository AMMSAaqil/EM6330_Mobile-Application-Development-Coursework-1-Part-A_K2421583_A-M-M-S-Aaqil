import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/note.dart';
import '../viewmodels/note_provider.dart';

class NoteEditScreen extends StatefulWidget {
  final Note? note;

  const NoteEditScreen({Key? key, this.note}) : super(key: key);

  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    final timestamp = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title and content cannot be empty')),
      );
      return;
    }

    final newNote = Note(
      id: widget.note?.id,
      title: title,
      content: content,
      timestamp: timestamp,
    );

    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    if (widget.note == null) {
      noteProvider.addNote(newNote);
    } else {
      noteProvider.updateNote(newNote);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<NoteProvider>(context, listen: false)
                    .deleteNote(widget.note!.id!);
                Navigator.pop(context);
              },
            ),
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Responsive padding
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(fontSize: 18.sp), // Responsive font size
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.w),
                ),
              ),
            ),
            SizedBox(height: 16.h), // Responsive spacing
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  labelStyle: TextStyle(fontSize: 18.sp), // Responsive font size
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r), // Responsive border radius
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.w),
                  ),
                ),
                maxLines: null,
                expands: true,
              ),
            ),
            SizedBox(height: 16.h), // Responsive spacing
            ElevatedButton(
              onPressed: _saveNote,
              child: Text('Save', style: TextStyle(fontSize: 16.sp)), // Responsive font size
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: Size(double.infinity, 50.h), // Responsive height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r), // Responsive radius
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'coastal_beaches.dart';
import 'hillcountry_scenic_page.dart';  // Your existing Hill Country page
// New Coastal & Beaches page import

class TravelNote {
  String note;
  String date;
  bool isLikedNote;

  TravelNote({
    required this.note,
    required this.date,
    this.isLikedNote = false,
  });

  Map<String, dynamic> toJson() => {
    'note': note,
    'date': date,
    'isLikedNote': isLikedNote,
  };

  factory TravelNote.fromJson(Map<String, dynamic> json) => TravelNote(
    note: json['note'],
    date: json['date'],
    isLikedNote: json['isLikedNote'] ?? false,
  );
}

class TravelNotePage extends StatefulWidget {
  const TravelNotePage({super.key});

  static const String _storageKey = 'travel_notes';

  static Future<List<TravelNote>> _loadNotesStatic() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesJson = prefs.getString(_storageKey);
    if (notesJson != null) {
      final List<dynamic> notesList = jsonDecode(notesJson);
      return notesList.map((e) => TravelNote.fromJson(e)).toList();
    }
    return [];
  }

  static Future<void> _saveNotesStatic(List<TravelNote> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonNotes = notes.map((e) => e.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(jsonNotes));
  }

  static Future<bool> isParkLiked(String parkTitle) async {
    final notes = await _loadNotesStatic();
    return notes.any((note) => note.note.contains(parkTitle) && note.isLikedNote);
  }

  static Future<void> addLikedPark(String parkTitle, String temp) async {
    final notes = await _loadNotesStatic();
    final noteText = '❤️ $parkTitle\nWeather: $temp°C';
    if (!notes.any((note) => note.note.contains(parkTitle) && note.isLikedNote)) {
      notes.add(TravelNote(
          note: noteText,
          date: DateTime.now().toString().split('.')[0],
          isLikedNote: true));
      await _saveNotesStatic(notes);
    }
  }

  static Future<void> removeLikedPark(String parkTitle) async {
    final notes = await _loadNotesStatic();
    notes.removeWhere(
            (note) => note.note.contains(parkTitle) && note.isLikedNote == true);
    await _saveNotesStatic(notes);
  }

  @override
  State<TravelNotePage> createState() => _TravelNotePageState();
}

class _TravelNotePageState extends State<TravelNotePage> {
  final TextEditingController _noteController = TextEditingController();
  List<TravelNote> _notes = [];

  final Color _primaryGreen = Colors.green.shade300;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final loadedNotes = await TravelNotePage._loadNotesStatic();
    setState(() {
      _notes = loadedNotes;
    });
  }

  Future<void> _addNote() async {
    if (_noteController.text.trim().isEmpty) return;
    final newNote = TravelNote(
      note: _noteController.text.trim(),
      date: DateTime.now().toString().split('.')[0],
      isLikedNote: false,
    );
    setState(() {
      _notes.add(newNote);
    });
    await TravelNotePage._saveNotesStatic(_notes);
    _noteController.clear();
  }

  Future<void> _deleteNote(int index) async {
    setState(() {
      _notes.removeAt(index);
    });
    await TravelNotePage._saveNotesStatic(_notes);
  }

  Future<void> _editNoteDialog(int index) async {
    final editController = TextEditingController(text: _notes[index].note);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Edit Note'),
        content: TextField(
          controller: editController,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              final newText = editController.text.trim();
              if (newText.isNotEmpty) {
                setState(() {
                  _notes[index].note = newText;
                  _notes[index].date = DateTime.now().toString().split('.')[0];
                });
                TravelNotePage._saveNotesStatic(_notes);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _navigateToCategoryPage(String parkTitle, String category) {
    if (category == 'HillCountry') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HillCountryScenicPage()),
      );
    } else if (category == 'CoastalBeaches') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CoastalBeachesPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade50,
        title: const Text('Travel Notes'),
        centerTitle: true,
        elevation: 3,
        shadowColor: _primaryGreen.withOpacity(0.5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _noteController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Add a new note...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                  shadowColor: Colors.greenAccent,
                ),
                onPressed: _addNote,
                child: const Text(
                  'Add Note',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _notes.isEmpty
                  ? Center(
                child: Text(
                  'No notes yet',
                  style: TextStyle(
                    color: _primaryGreen.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  final note = _notes[index];

                  String? parkTitle;
                  String? category; // To track category for navigation

                  if (note.isLikedNote) {
                    final lines = note.note.split('\n');
                    if (lines.isNotEmpty) {
                      parkTitle = lines[0].replaceAll('❤️ ', '').trim();

                      // Simple keyword check to categorize the note
                      if (parkTitle.toLowerCase().contains('hill') ||
                          parkTitle.toLowerCase().contains('scenic') ||
                          parkTitle.toLowerCase().contains('mountain') ||
                          parkTitle.toLowerCase().contains('country')) {
                        category = 'HillCountry';
                      } else if (parkTitle.toLowerCase().contains('beach') ||
                          parkTitle.toLowerCase().contains('coastal') ||
                          parkTitle.toLowerCase().contains('bay') ||
                          parkTitle.toLowerCase().contains('island')) {
                        category = 'CoastalBeaches';
                      }
                    }
                  }

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 4),
                    shadowColor: _primaryGreen.withOpacity(0.4),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      leading: Icon(
                        note.isLikedNote ? Icons.favorite : Icons.note,
                        color: note.isLikedNote
                            ? Colors.redAccent
                            : _primaryGreen,
                        size: 32,
                      ),
                      title: Text(
                        note.note,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          note.date,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      onTap: (note.isLikedNote && parkTitle != null && category != null)
                          ? () => _navigateToCategoryPage(parkTitle!, category!)
                          : null,
                      trailing: SizedBox(
                        width: 96,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Tooltip(
                              message: 'Edit Note',
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () => _editNoteDialog(index),
                                child: const Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            Tooltip(
                              message: 'Delete Note',
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () => _deleteNote(index),
                                child: const Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

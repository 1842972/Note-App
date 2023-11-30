import 'package:flutter/material.dart';
import 'package:note_app/notes_Model/notesModel.dart';

class Mynote extends StatelessWidget {


const Mynote({required this.notes});
final Notes notes;
  @override
  Widget build(BuildContext context) {
    return
      Text(notes.notes,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),);

  }
}

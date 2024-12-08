import 'dart:convert';

import 'dart:developer';

import '../../model/notes_model.dart';
import '../../screen/create_note_screen.dart';
import '../provider_data/notes_provider.dart';

class NotesRepo {
  final NotesProvider notesProvider;
  NotesRepo(this.notesProvider);
  Future<List<NotesModel>> getData() async {
    String apiData = await notesProvider.getApiData();
    List list = await jsonDecode(apiData);
    // List<Map<String, dynamic>> list =
    //     List<Map<String, dynamic>>.from(jsonDecode(apiData));
    List<NotesModel> notesmodelList =
        list.map((item) => NotesModel.fromMap(item)).toList();
    notesList = notesmodelList;

    return notesmodelList;
  }
}

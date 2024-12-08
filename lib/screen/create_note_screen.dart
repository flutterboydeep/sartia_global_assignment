import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../bloc/notes_bloc.dart';
import '../model/notes_model.dart';

List<NotesModel> notesList = [];

class CreateNoteScreen extends StatefulWidget {
  final bool isUpdate;
  final NotesModel? notes;
  CreateNoteScreen({required this.isUpdate, this.notes, super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  @override
  void initState() {
    updatetitleData();
    super.initState();
  }

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();
  FocusNode focusNode = FocusNode();

  updatetitleData() {
    if (widget.isUpdate) {
      titleCtrl.text = widget.notes!.title.toString();
      contentCtrl.text = widget.notes!.content.toString();
    } else {
      return null;
    }
  }

  updateNote() {
    NotesModel notesModel = NotesModel(
      id: widget.notes!.id.toString(),
      userid: widget.notes!.userid.toString(),
      title: titleCtrl.text.trim(),
      content: contentCtrl.text.trim(),
      date: DateTime.now(),
    );

    BlocProvider.of<NotesBloc>(context)
        .add(UpdateNotesEvent(notesModel: notesModel));
    // var data = notesList
    //     .where((element) => element.userId == widget.notes!.userId)
    //     .indexed;
    // log("this is updated data message $data");
  }

  addNote() {
    NotesModel notesModel = NotesModel(
      id: const Uuid().v1(),
      userid: "deep34@gmail.com",
      title: titleCtrl.text.trim(),
      content: contentCtrl.text.trim(),
      date: DateTime.now(),
    );

    BlocProvider.of<NotesBloc>(context)
        .add(AddNotesEvent(addNotes: notesModel));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextField(
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              controller: titleCtrl,
              onSubmitted: (newTitle) {
                setState(() {});
                focusNode.requestFocus();
              },
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context
                      .read<NotesBloc>()
                      .add(AddFloationgButtionEvent(istitle: true));
                } else {
                  context
                      .read<NotesBloc>()
                      .add(AddFloationgButtionEvent(istitle: false));
                }
              },
              decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontSize: 22,
                  ),
                  border: InputBorder.none),
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                focusNode: focusNode,
                controller: contentCtrl,
                decoration: const InputDecoration(
                    hintText: "Description",
                    hintStyle: TextStyle(
                      fontSize: 12,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ]),
        ),
        BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            double bottomInset = MediaQuery.of(context).viewInsets.bottom;
            if (state.isTitle) {
              return Positioned(
                bottom: bottomInset > 0 ? bottomInset + 10 : 10,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    log("This is issocketException $isSocketException");
                    if (isSocketException) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 100,
                              right: 20,
                              left: 20),
                          content: const Text("Please turn on Your data")));
                    } else {
                      if (widget.isUpdate) {
                        updateNote();
                        Navigator.pop(context);
                      } else {
                        addNote();
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Icon(Icons.done),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartia_global_assignment/screen/create_note_screen.dart';
import 'package:sartia_global_assignment/utils/textHelper.dart';

import '../bloc/notes_bloc.dart';
import '../model/notes_model.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  showNotes(context) {
    BlocProvider.of<NotesBloc>(context).add(ShowAllNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    showNotes(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
            log(" this is the all data screeen ${state.notesList.toString()}");
            // if (state.status != Status.loaded) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            return state.error != ""
                ? Center(
                    child: TextHelper(
                      text: state.error,
                    ),
                  )
                : state.status != Status.loaded
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemBuilder: ((context, index) {
                          return
                              // decoration: BoxDecoration(border: Border.all(width: 2)),
                              Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Card(
                              color: Colors.blue.shade100,
                              child: ListTile(
                                  title: Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    state.notesList[index].title.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 53, 51, 51)),
                                  ),
                                  subtitle: Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    state.notesList[index].content.toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 53, 51, 51)),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            var onTapNotesDataModel =
                                                state.notesList[index];
                                            bottomSheet(context, true,
                                                onTapNotesDataModel);
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            if (isSocketException) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      margin: EdgeInsets.only(
                                                          bottom: 100,
                                                          right: 20,
                                                          left: 20),
                                                      content: Text(
                                                          "Please turn on Your data")));
                                            } else {
                                              var onTapNotesDataModel =
                                                  notesList[index];

                                              BlocProvider.of<NotesBloc>(
                                                      context)
                                                  .add(DeleteNotesEvent(
                                                      notesModel:
                                                          onTapNotesDataModel));
                                            }
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ],
                                  )),
                            ),
                          );
                        }),
                        itemCount: state.notesList.length,
                      );
          }),
        ),
        Positioned(
          bottom: 100,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              if (isSocketException) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    // behavior: SnackBarBehavior.floating,
                    // margin: EdgeInsets.only(bottom: 130, right: 20, left: 20),
                    content: const Text("Please turn on Your data")));
              } else {
                bottomSheet(context, false, null);
              }
              // Navigator.push(
              //     context,
              //     CupertinoPageRoute(
              //         fullscreenDialog: true,
              //         builder: ((context) => CreateNoteScreen(
              //               isUpdate: false,
              //             ))));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  bottomSheet(context, bool isUpdate, NotesModel? updateNotesModel) {
    return showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: double.infinity,
              child: CreateNoteScreen(
                isUpdate: isUpdate,
                notes: updateNotesModel,
              ),
            ));
  }
}

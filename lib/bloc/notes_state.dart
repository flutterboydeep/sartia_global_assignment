// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notes_bloc.dart';

enum Status { initial, loading, loaded, error }

@immutable
class NotesState {
  final Status status;
  final bool isTitle;
  final bool isConnectivity;
  final String content;
  final NotesModel? notesModel;
  final List<NotesModel> notesList;
  final String error;

  NotesState(
      {this.status = Status.initial,
      this.isTitle = false,
      this.isConnectivity = false,
      this.content = "",
      this.notesModel,
      // this.notesModel= const NotesModel(content: "",title: "",date: null),
      this.notesList = const [],
      this.error = ""});

  NotesState copyWith({
    Status? status,
    bool? isTitle,
    bool? isConnectivity,
    String? content,
    List<NotesModel>? notesList,
    NotesModel? notesModel,
    String? error,
  }) {
    return NotesState(
      status: status ?? this.status,
      isTitle: isTitle ?? this.isTitle,
      isConnectivity: isConnectivity ?? this.isConnectivity,
      content: content ?? this.content,
      notesList: notesList ?? this.notesList,
      notesModel: notesModel ?? this.notesModel,
      error: error ?? this.error,
    );
  }
}

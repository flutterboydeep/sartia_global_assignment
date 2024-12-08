import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../data/repo/notes_repo.dart';
import '../model/notes_model.dart';
import '../screen/create_note_screen.dart';
import '../services/api_services.dart';

part 'notes_event.dart';
part 'notes_state.dart';

bool isSocketException = false;

var box = Hive.box('myBox');

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscripiton;
  final NotesRepo notesRepo;
  NotesBloc(this.notesRepo) : super(NotesState()) {
    connectivitySubscripiton =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result[0] == ConnectivityResult.mobile ||
          result[0] == ConnectivityResult.wifi ||
          result[0] == ConnectivityResult.ethernet ||
          result[0] == ConnectivityResult.bluetooth) {
        isSocketException = false;
      } else {
        isSocketException = true;
      }
    });

    // on<CheckConnectivityEvnet>(_checkConnectivityEvnet);
    on<AddNotesEvent>(addNoteEvent);
    on<ShowAllNotesEvent>(showAllNotesEvent);
    on<AddFloationgButtionEvent>(addFloationgButtionEvent);
    on<UpdateNotesEvent>(updateNotesEvent);
    on<DeleteNotesEvent>(deleteNotesEvent);
  }

  // _checkConnectivityEvnet(
  //     CheckConnectivityEvnet event, Emitter<NotesState> emit) {
  //   if (event.isConnectedEvent == true) {
  //     isSocketException = false;
  //     log('Your net is on');
  //     // emit(state.copyWith(allData: data));
  //     emit(state.copyWith(
  //       isConnectivity: true,
  //     ));
  //   } else {
  //     isSocketException = true;
  //     log('Your net is off');
  //     // emit(state.copyWith(allData: data));
  //     emit(state.copyWith(
  //       isConnectivity: false,
  //     ));
  //   }
  // }

  addNoteEvent(AddNotesEvent event, Emitter<NotesState> emit) {
    emit(state.copyWith(status: Status.loading));
    try {
      ApiServices.addDataApi(event.addNotes);
      notesList.add(event.addNotes);
      emit(state.copyWith(notesList: notesList, status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
    // emit(state.copyWith(notesList: notesList, status: Status.loaded));
  }

  updateNotesEvent(UpdateNotesEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      ApiServices.updateDataApi(event.notesModel);
      log(event.notesModel.toMap().toString());
      var index =
          notesList.indexWhere((element) => element.id == event.notesModel.id);
      notesList[index] = event.notesModel;

      emit(state.copyWith(notesList: notesList, status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  deleteNotesEvent(DeleteNotesEvent event, Emitter<NotesState> emit) {
    emit(state.copyWith(status: Status.loading));
    try {
      var index =
          notesList.indexWhere((element) => element.id == event.notesModel.id);

      var data = state.notesList.removeAt(index);
      ApiServices.deleteDataApi(event.notesModel);
      emit(state.copyWith(notesList: notesList, status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  addFloationgButtionEvent(
      AddFloationgButtionEvent event, Emitter<NotesState> emit) {
    emit(state.copyWith(isTitle: event.istitle, status: Status.loaded));
  }

  showAllNotesEvent(ShowAllNotesEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    // log("noteslis is = ${notesRepo.getData()}");
    try {
      isSocketException = false;
      List<NotesModel> list = await notesRepo.getData();
      box.clear();
      box.add(list);
      // for (var note in list) {
      //   box.add(note);
      // }

      emit(state.copyWith(notesList: list, status: Status.loaded));
    } catch (e) {
      if (e == "SocKetException") {
        isSocketException = true;
        log("-------------------------");
        var boxData = box.getAt(0);
        if (boxData.isEmpty) {
          log("Box ");
          emit(state.copyWith(error: "No Internet Connection!"));
        } else {
          List<NotesModel> boxlistData = List<NotesModel>.from(boxData);
          notesList = boxlistData;
          emit(state.copyWith(notesList: boxlistData, status: Status.loaded));
        }
        return;
      }
      log("Error in show allNotes event is $e");
      emit(state.copyWith(error: e.toString()));
    }
  }
}

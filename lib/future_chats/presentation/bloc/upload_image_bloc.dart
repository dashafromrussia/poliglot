import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:io' as io;

import 'package:image_picker/image_picker.dart';
abstract class UploadEvent extends Equatable{
  const UploadEvent();
  @override
  List<Object> get props => [];
}

class BeginUploadEvent extends UploadEvent{

  const BeginUploadEvent();
}




abstract class UploadState extends Equatable{
  const UploadState();
  @override
  List<Object> get props => [];
}

class DataUploadState extends UploadState{
  final String dateMess;
  const DataUploadState({required this.dateMess});
}
class UploadNotState extends UploadState{

}




class UploadBloc extends Bloc<UploadEvent,UploadState> {
  final storage = FirebaseStorage.instance;
  UploadBloc() : super(UploadNotState()) {
    print('time converter');
    on<UploadEvent>((event, emit) async {
      if (event is BeginUploadEvent) {

      //  emit(TimeDataState(dateMess: resultime));
      }
    });
    //add(const LoadArticlesEvent());
  }

  Future<UploadTask?> uploadFile(XFile? file) async {
    if (file == null) {

      return null;
    }

    UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('/some-image.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }

    return Future.value(uploadTask);
  }


  Future<void> handleUploadType() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    UploadTask? task = await uploadFile(file);
  }
}
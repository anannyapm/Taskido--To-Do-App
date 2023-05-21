import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:todoapp/features/presentation/bloc/photobloc/photo_event.dart';
import 'package:todoapp/features/presentation/bloc/photobloc/photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoIntial()) {
    on<PhotoSelectedEvent>((event, emit) async {
      final photo = event.photo.isEmpty ? "" : event.photo;
      emit(PhotoLoaded(photo: photo));
    });

    on<PhotoResetEvent>((event, emit) {
      emit(PhotoIntial());
    });
  }
}

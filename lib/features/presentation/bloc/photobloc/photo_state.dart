import 'dart:io';


abstract class PhotoState {}

class PhotoIntial extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final String photo;
  PhotoLoaded({required this.photo});
}

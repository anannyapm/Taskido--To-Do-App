abstract class PhotoEvent {}

class PhotoSelectedEvent extends PhotoEvent {
  String photo;
  PhotoSelectedEvent({required this.photo});
}

class PhotoResetEvent extends PhotoEvent {}

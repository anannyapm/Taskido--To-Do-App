abstract class PageNavEvent {}

class PageNavActivateEvent extends PageNavEvent {
  int newIndex;
  PageNavActivateEvent({required this.newIndex});
}

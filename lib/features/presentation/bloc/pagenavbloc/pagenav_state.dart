abstract class PageNavState {
  int selectedIndexNotifier;
  PageNavState({required this.selectedIndexNotifier});
}

class PageNavInitialState extends PageNavState {
  PageNavInitialState() : super(selectedIndexNotifier: 0);
}

class PageNavActiveState extends PageNavState {
  PageNavActiveState(int selectedIndexNotifier) :super(selectedIndexNotifier:selectedIndexNotifier );
}

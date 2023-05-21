import 'package:bloc/bloc.dart';
import 'package:todoapp/features/presentation/bloc/pagenavbloc/pagenav_event.dart';
import 'package:todoapp/features/presentation/bloc/pagenavbloc/pagenav_state.dart';

class PageNavBloc extends Bloc<PageNavEvent, PageNavState> {
  PageNavBloc() : super(PageNavInitialState()) {
    on<PageNavActivateEvent>(
      (event, emit) {
        int newIndex = event.newIndex;
        emit(PageNavActiveState(newIndex));
      },
    );
  }
}

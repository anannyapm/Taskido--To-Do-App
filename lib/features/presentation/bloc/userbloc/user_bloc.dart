import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/features/presentation/bloc/userbloc/user_event.dart';
import 'package:todoapp/features/presentation/bloc/userbloc/user_state.dart';

import '../../../../main.dart';
import '../../../data/datasources/dbfunctions/repository.dart';
import '../../../data/models/usermodel.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      List<Map<String, dynamic>> out = await Repository.fetchData(event.email);
      if (out.isNotEmpty) {
        Map val = out[0];
        await Repository.setCurrentUser(
            val['uid'], val['name'], val['email'], val['photo']);
        //setting value of savekeyname to true when credentials are correct.
        final sharedpref = await SharedPreferences.getInstance();

        await sharedpref.setString(SAVE_KEY_NAME, event.email);

        //await Repository.getAllUser();

        emit(LoginSucess());
      } else {
        emit(LoginFailure(
            "Oops!!Looks like you are not registered. Sign Up to continue :)"));
      }
    });
    on<SignUpEvent>((event, emit) async {
      String photo = 'assets/images/stacked-steps-haikei.png';
        final userphoto = event.photo == "" ? photo : event.photo;
      final userObject =
          UserModel(name: event.name, email: event.email, photo:userphoto);

      dynamic out = await Repository.saveData(userObject);
      if (out == true) {
        final List<Map<String, dynamic>> uidFetchOutput =
            await Repository.fetchID(event.email);
        final currentUserId = uidFetchOutput[0]['uid'];
        

        await Repository.setCurrentUser(
            currentUserId, event.name, event.email, userphoto);

        final sharedPrefs = await SharedPreferences.getInstance();
        await sharedPrefs.setString(SAVE_KEY_NAME, event.email);

        emit(SignupSuccess());
      } else {
        emit(SignupFailure("User already exists. Please Login back to continue!"));
      }
    });
  }
}



abstract class UserEvent {}

class SignUpEvent extends UserEvent {
  String name;
  String email;
  String photo;

  SignUpEvent({
    required this.name,
    required this.email,
    required this.photo
  });
}

class LoginEvent extends UserEvent {

  String email;


  LoginEvent({
  
    required this.email
  });
}

class LogoutOutEvent extends UserEvent {
}
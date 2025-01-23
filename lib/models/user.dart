class UserModel {

  UserModel._internal();
  static final UserModel _instance = UserModel._internal();
  factory UserModel() => _instance;

  String? _userEmail;
  String? _username;
  String? _userImage;
  String? _userId;

  void setUser({required userId, required email, required username, required userImage}) {
    _userId = userId;
    _userEmail = email;
    _username = username;
    _userImage = userImage;
  }

  String? get getUserId {
    return _userId;
  }

  String? get getUserEmail {
    return _userEmail;
  }

  String? get getUsername {
    return _username;
  }

  String? get getUserImage {
    return _userImage;
  }
}
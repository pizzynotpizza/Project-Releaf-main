// lib/providers/user_provider.dart
import 'dart:async';

import 'package:flutter/foundation.dart';
import '../models/app_user.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService;
  AppUser? _user;
  StreamSubscription<AppUser?>? _sub;

  UserProvider(this._userService);

  AppUser? get user => _user;
  bool get isLoggedIn => _user != null;

  void listenToUser(String uid) {
    _sub?.cancel();
    _sub = _userService.streamUser(uid).listen((appUser) {
      _user = appUser;
      notifyListeners();
    });
  }

  void clear() {
    _sub?.cancel();
    _user = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

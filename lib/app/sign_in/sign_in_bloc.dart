import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_time_app/services/auth.dart';

class SignInBloc {
  SignInBloc({@required this.auth});
  final AuthBase auth;
  final StreamController<bool> _isLoadingController = StreamController();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;
  void dispose() {
    _isLoadingController.close();
  }

  void setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);
  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<User> signInWithFacebook() async =>
      await _signIn(auth.signInWithFacebook);
  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
}

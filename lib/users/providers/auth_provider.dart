import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:synq/users/repository/auth_repository.dart';

import '../../helpers/utils/strings.dart';

final googleSignInProvider = FutureProvider((ref) async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    serverClientId: Strings.webClientId,
  );

  final googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser!.authentication;
  final accessToken = googleAuth.accessToken;
  final idToken = googleAuth.idToken;

  if (accessToken == null) {
    throw 'No Access Token Found';
  }
  if (idToken == null) {
    throw 'No Id Token Found';
  }

  ref.read(authRepositoryProvider).signInWithIdToken(idToken);
});


final adminLoginProvider = FutureProvider((ref){
  try{
    
  }catch(e){
    log('message');
  }
});




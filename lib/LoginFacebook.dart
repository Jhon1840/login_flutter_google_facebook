import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [Text("buen dia")],
            ),
            ElevatedButton(
              onPressed: () async {
                await signInWithFacebook();
              },
              child: Text('Iniciar sesión con Facebook'),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final AccessToken? result =
          (await FacebookAuth.instance.login()) as AccessToken?;

      // Create a credential from the access token
      final facebookAuthCredential =
          FacebookAuthProvider.credential(result!.token);

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.code}');
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widget/login_page.dart';
import '../widget/signin_page.dart';

final passwordController = TextEditingController();
final emailController = TextEditingController();
final comformPassController = TextEditingController();
const height10 = SizedBox(
  height: 10,
);
const height20 = SizedBox(
  height: 20,
);
const height30 = SizedBox(
  height: 30,
);


class AuthRoute extends StatefulWidget {
  const AuthRoute({super.key,this.appbar});
  final bool? appbar;

  @override
  State<AuthRoute> createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
  bool isLogin = true;
  void togglePages() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginPage(ontap: togglePages,isBuyingPage: widget.appbar,);
    } else {
      return SigninPage(ontap: togglePages,isBuyingPage: widget.appbar,);
    }
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
      if(!snapshot.hasData)
      {
        return const AuthRoute();
      }else{
        Navigator.pop(context);
        return SizedBox();
      }
    },);
  }
}
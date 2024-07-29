import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../bloc/bloc/auth_bloc.dart';

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

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    required this.ontap,
    this.appbar,
  }) : super(key: key);
  final void Function() ontap;
  final bool? appbar;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey _form = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            state.error,
            style: TextStyle(color: Colors.black),
          )));
        }
      },
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if(widget.appbar!=null)
        {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    height30,
                    Lottie.asset("assets/login.json"),
                    height30,
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          hintText: "Email"),
                    ),
                    height10,
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          hintText: "Password"),
                    ),
                    height20,
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(Login(
                            email: emailController.text,
                            password: passwordController.text));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text("SignIn"),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Your not a Member"),
                        TextButton(
                          onPressed: widget.ontap,
                          child: const Text("Ragister"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
                    ),
          );
        }
        return SingleChildScrollView(
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  height30,
                  Lottie.asset("assets/login.json"),
                  height30,
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)),
                        hintText: "Email"),
                  ),
                  height10,
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)),
                        hintText: "Password"),
                  ),
                  height20,
                  GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(Login(
                          email: emailController.text,
                          password: passwordController.text));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 65,
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text("SignIn"),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Your not a Member"),
                      TextButton(
                        onPressed: widget.ontap,
                        child: const Text("Ragister"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SigninPage extends StatefulWidget {
  const SigninPage({
    Key? key,
    required this.ontap,
    this.appBar,
  }) : super(key: key);
  final void Function() ontap;
  final bool? appBar;

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  GlobalKey _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is Error)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error,style: TextStyle(color: Colors.black),)));
        }
      },
      builder: (context, state) {
        if(widget.appBar!=null)
        {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/welcome.json"),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          hintText: "Email"),
                    ),
                    height10,
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          hintText: "Password"),
                    ),
                    height10,
                    TextFormField(
                      controller: comformPassController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          hintText: "Conform Password"),
                    ),
                    height20,
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(SignIn(
                            email: emailController.text,
                            password: passwordController.text,
                            cornformPass: comformPassController.text));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Your Already a Member"),
                        TextButton(
                          onPressed: widget.ontap,
                          child: const Text("Login"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
                    ),
          );
        }
        return SingleChildScrollView(
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/welcome.json"),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)),
                        hintText: "Email"),
                  ),
                  height10,
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)),
                        hintText: "Password"),
                  ),
                  height10,
                  TextFormField(
                    controller: comformPassController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)),
                        hintText: "Conform Password"),
                  ),
                  height20,
                  GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(SignIn(
                          email: emailController.text,
                          password: passwordController.text,
                          cornformPass: comformPassController.text));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Your Already a Member"),
                      TextButton(
                        onPressed: widget.ontap,
                        child: const Text("Login"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

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
      return LoginPage(ontap: togglePages,appbar: widget.appbar,);
    } else {
      return SigninPage(ontap: togglePages,appBar: widget.appbar,);
    }
  }
}

// class AuthGate extends StatelessWidget {
//   const AuthGate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
//       if(snapshot.hasData)
//       {
//         return 
//       }
//     },);
//   }
// }
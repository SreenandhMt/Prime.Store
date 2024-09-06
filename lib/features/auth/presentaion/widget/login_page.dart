import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../bloc/bloc/auth_bloc.dart';
import '../page/auth_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    required this.ontap,
    this.isBuyingPage,
  }) : super(key: key);
  final void Function() ontap;
  final bool? isBuyingPage;

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
            style: const TextStyle(color: Colors.black),
          )));
        }
      },
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
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
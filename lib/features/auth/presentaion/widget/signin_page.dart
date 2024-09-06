import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:main_work/features/account/presentaion/bloc/bloc/account_bloc.dart';

import '../../../buying/presentaion/blocs/bloc/confrom_bloc.dart';
import '../bloc/bloc/auth_bloc.dart';
import '../page/auth_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({
    Key? key,
    required this.ontap,
    this.isBuyingPage,
  }) : super(key: key);
  final void Function() ontap;
  final bool? isBuyingPage;

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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error,style: const TextStyle(color: Colors.black),)));
        }
      },
      builder: (context, state) {
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
                      context.read<AccountBloc>().add(EditProfile(name: emailController.text.split("@").first, phoneNumber: "", email: emailController.text, birthday: "", gender: ""));
                      context.read<AuthBloc>().add(SignIn(
                          email: emailController.text,
                          password: passwordController.text,
                          cornformPass: comformPassController.text));
                          if (widget.isBuyingPage != null && widget.isBuyingPage!) {
                      context.read<ConfromBloc>().add(CheckRequest());
                    }
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:main_work/core/theme/themes.dart';

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
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is Error)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Color.fromARGB(255, 238, 195, 181),margin: EdgeInsets.all(15),behavior: SnackBarBehavior.floating,content: Text(state.error,style: const TextStyle(color: Colors.black),)));
        }
        if(state is Success)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            margin: EdgeInsets.all(15),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green.shade300,
              content: Text(
            "Account creation successful!",
            style: const TextStyle(color: Colors.black),
          )));
        }
      },
      builder: (context, state) {
        return Form(
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
                  validator: validateEmail,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                          label: Text("Email",style: TextStyle(fontWeight: FontWeight.w700),),
                      hintText: "Email"),
                ),
                height10,
                TextFormField(
                  controller: passwordController,
                  validator: validatePassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                          label: Text("Password",style: TextStyle(fontWeight: FontWeight.w700),),
                      hintText: "Password"),
                ),
                height10,
                TextFormField(
                  controller: comformPassController,
                  validator: validatePassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                          label: Text("Conform Password",style: TextStyle(fontWeight: FontWeight.w700),),
                      hintText: "Conform Password"),
                ),
                height20,
                GestureDetector(
                  onTap: () {
                    if(!_form.currentState!.validate())return;
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
                        child: state is Loading? const Center(child: CircularProgressIndicator()): Center(child: Text("SignIn",style: textTheme(17, Colors.black),)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Your are already a member"),
                    TextButton(
                      onPressed: widget.ontap,
                      child: const Text("SignUp"),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            margin: EdgeInsets.all(15),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromARGB(255, 238, 195, 181),
              content: Text(
            state.error,
            style: const TextStyle(),
          )));
        }
        if(state is Success)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            margin: EdgeInsets.all(15),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green.shade300,
              content: Text(
            "Login successful!",
            style: const TextStyle(color: Colors.black),
          )));
        }
      },
      builder: (context, state) {
        return Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                height20,
                GestureDetector(
                  onTap: () {
                    if(!_form.currentState!.validate())return;
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
                    child:state is Loading? const Center(child: CircularProgressIndicator(strokeWidth: 4)): Center(
                      child: Text("SignUp",style: GoogleFonts.aDLaMDisplay(),),
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
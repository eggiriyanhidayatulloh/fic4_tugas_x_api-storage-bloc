import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc_tugas/bloc/register/register_bloc.dart';
import 'package:flutter_auth_bloc_tugas/constans.dart';
import 'package:flutter_auth_bloc_tugas/data/models/request/register_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create Account",
              style: textTextStyle.copyWith(fontSize: 30, fontWeight: bold),
            ),
            const SizedBox(height: 5),
            Text(
              "Your Must Register before login in this aplication",
              style: secondaryTextStyle.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 64),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Full name",
                  style: textTextStyle.copyWith(fontSize: 15, fontWeight: bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Eggiriyan",
                        hintStyle: textTextStyle.copyWith(
                            fontSize: 12, color: textColor.withOpacity(0.6)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 17)),
                    controller: nameController,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Email",
                  style: textTextStyle.copyWith(fontSize: 15, fontWeight: bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "eggiriyan@gmail.com",
                        hintStyle: textTextStyle.copyWith(
                            fontSize: 12, color: textColor.withOpacity(0.6)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 17)),
                    controller: emailController,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Password",
                  style: textTextStyle.copyWith(fontSize: 15, fontWeight: bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor),
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                        suffixIcon: Icon(Icons.visibility_off)),
                    controller: passwordController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterLoaded) {
                  nameController!.clear();
                  emailController!.clear();
                  passwordController!.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Success Register with id : ${state.model.id}")));
                }
              },
              builder: (context, state) {
                if (state is RegisterLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // ignore: sized_box_for_whitespace
                return Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: buttonColor,
                      ),
                      onPressed: () {
                        final requestModel = RegisterModel(
                            name: nameController!.text,
                            email: emailController!.text,
                            password: passwordController!.text);
                        context
                            .read<RegisterBloc>()
                            .add(SaveRegisterEvent(request: requestModel));
                      },
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

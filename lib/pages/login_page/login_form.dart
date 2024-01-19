import 'package:fazwalls/pages/forgot_page/forgot_screen.dart';

import 'package:fazwalls/utils/bottom_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fazwalls/constants/textstring.dart';
import 'package:fazwalls/firebase/auth/auth_provider.dart';
import 'package:fazwalls/pages/sign_up_page/singup_screen.dart';
import 'package:fazwalls/utils/validator/validator.dart';

class LoginForm extends StatefulWidget {
  

  const LoginForm(
      {super.key,
      required this.emailController,
      required this.passwordController});
      final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    
    final AuthProviderr authProvider =
        Provider.of<AuthProviderr>(context, listen: false);
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.emailController,
              validator: TValidator.validateEmail,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: enteremail,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              obscureText: _obscureText,
              controller: widget.passwordController,
              validator: TValidator.validatePassword,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: enterpswrd,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                suffixIcon: IconButton(
                  onPressed: () {

                    setState(() {
                       _obscureText = !_obscureText;
                    });


                    
                  },
                  icon:  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotScreen(),
                    ),
                  ); 
                },
                child: Text(
                  forgtpswrd,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: const Color(0xfff615DB4)),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await authProvider.signIn(
                      context,
                      widget.emailController.text,
                      widget.passwordController.text,
                    );

                    if (authProvider.user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GnavigationBar(),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  login,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.center,
              child: Text(
                withsocial,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () async {
                    await authProvider.signInWithGoogle(context);
                     
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GnavigationBar(),
                          ),
                        );
                },
                icon: const Image(
                  image: AssetImage('assets/images/google.png'),
                  width: 20,
                ),
                label: Text(
                  signingoogle,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(width: 1, color: Colors.yellow),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Image(
                  image: AssetImage('assets/images/facebook.png'),
                  height: 35,
                ),
                label: Text(
                  signinfb,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    text: donthaveacount,
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: signup,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: const Color(0xfff615DB4)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

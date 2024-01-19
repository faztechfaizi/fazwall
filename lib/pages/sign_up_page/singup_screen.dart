import 'package:fazwalls/constants/textstring.dart';
import 'package:fazwalls/firebase/auth/auth_provider.dart';
import 'package:fazwalls/pages/homescreen/home_screen.dart';
import 'package:fazwalls/pages/login_page/login_screen.dart';
import 'package:fazwalls/pages/sign_up_page/signup_form.dart';
import 'package:fazwalls/pages/sign_up_page/signup_header.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProviderr authProvider =
        Provider.of<AuthProviderr>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 30,
          ),
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SignupHeader(),
              const SizedBox(
                height: 20,
              ),
              const SignUpForm(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  withsocial,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          await authProvider.signInWithGoogle(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        icon: const Image(
                          image: AssetImage('assets/images/google.png'),
                          width: 20,
                        ),
                        label: Text('Google',
                            style: Theme.of(context).textTheme.bodyMedium),
                        style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(width: 1, color: Colors.yellow),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Image(
                          image: AssetImage(
                            'assets/images/facebook.png',
                          ),
                          height: 35,
                        ),
                        label: Text(
                          'Facebook',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: Text.rich(
                    TextSpan(
                        text: haveaccount,
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(
                            text: signin,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: const Color(0xfff615DB4)),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

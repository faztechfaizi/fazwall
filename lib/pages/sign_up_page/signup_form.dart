import 'package:fazwalls/constants/textstring.dart';
import 'package:fazwalls/firebase/auth/auth_provider.dart';

import 'package:fazwalls/pages/login_page/login_screen.dart';


import 'package:fazwalls/utils/validator/validator.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
 

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

   

  @override
  
  Widget build(BuildContext context) {
    
    final authProvider = Provider.of<AuthProviderr>(context);
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                hintText: username,
                hintStyle: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _emailController,
              validator: TValidator.validateEmail,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                hintText: enteremail,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              obscureText: _obscureText,
              controller: _passwordController,
              validator: TValidator.validatePassword,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
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
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await authProvider
                        .signUp(
                          context,
                          _emailController.text,
                          _passwordController.text,
                        )
                        .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen())));
                  }
                },
                child: Text(
                  register,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

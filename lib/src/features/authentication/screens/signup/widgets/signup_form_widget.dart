import 'package:flutter/material.dart';
import 'package:fyp/src/constants/sizes.dart';
import 'package:fyp/src/constants/text_strings.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: gFormHeight - 10),
      child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text(gFullname),
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
              ),
              const SizedBox(height: gFormHeight-20),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text(gEmail),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: gFormHeight-20),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text(gPhoneNo),
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
              const SizedBox(height: gFormHeight-20),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text(gPassword),
                  prefixIcon: Icon(Icons.fingerprint),
                ),
              ),
              const SizedBox(height: gFormHeight-10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){},
                  child: Text(gSignup.toUpperCase()),),
              )
            ],
          )),
    );
  }
}

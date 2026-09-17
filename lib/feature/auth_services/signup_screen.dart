import 'package:flutter/material.dart';
import 'package:notes_app/feature/auth_services/auth_services.dart';
import 'package:notes_app/customs/button_widget.dart';
import 'package:notes_app/feature/auth_services/login_screen.dart';
import 'package:notes_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build the whole UI");
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Icon(Icons.person_add_alt_1, size: 100, color: Colors.blue),

              const SizedBox(height: 30),

              // Name
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  hintText: "Enter your full name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Email
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Password
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return TextFormField(
                    controller: passwordController,
                    obscureText: !authProvider.passwordObsecure,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          authProvider.passwordObsecure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          authProvider.togglePasswordObsecure();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Confirm Password
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return TextFormField(
                    controller: confirmPasswordController,
                    obscureText: !authProvider.confirmPasswordObsecure,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Confirm your password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          authProvider.passwordObsecure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          authProvider.toggleConfirmPasswordObsecrue();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              ButtonWidget(
                text: "Sign Up",
                onPressed: () async {
                  if (passwordController.text !=
                      confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("password do not match.")),
                    );
                    return;
                  }

                  try {
                    AuthServices services = AuthServices();

                    await services.signUp(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Account Created Successfully.")),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                width: double.infinity,
                height: 70,
                backgroundColor: Colors.blueAccent,
                textColor: Colors.white,
                borderRadius: 15,
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

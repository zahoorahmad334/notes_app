import 'package:flutter/material.dart';
import 'package:notes_app/customs/button_widget.dart';
import 'package:notes_app/feature/notes/screens/home_screen.dart';
import 'package:notes_app/feature/auth_services/signup_screen.dart';
import 'package:notes_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      print("Email: ${emailController.text}");
      print("Password: ${passwordController.text}");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Successful")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Icon(Icons.lock_outline, size: 100, color: Colors.blue),

                const SizedBox(height: 30),

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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }

                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                    ).hasMatch(value)) {
                      return "Enter a valid email";
                    }

                    return null;
                  },
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
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            authProvider.togglePasswordObsecure();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }

                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }

                        return null;
                      },
                    );
                  },
                ),

                const SizedBox(height: 30),

                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return ButtonWidget(
                      text: 'Login',
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        try {
                          await authProvider.logIn(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login Successfully')),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => HomeScreen()),
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
                    );
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => SignupScreen()),
                        );
                      },
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

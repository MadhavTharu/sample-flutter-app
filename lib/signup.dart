
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = "";

  Future<void> registerUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Registration successful - navigate or show message
      print("User registered successfully");
      setState(() {
        errorMessage = "User registered successfully. You can now log in.";
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "An error occurred";
      });
      print("Firebase Error: $errorMessage");
    } catch (e) {
      setState(() {
        errorMessage = "An unexpected error occurred";
      });
      print("Unknown Error: $e");
    }
  }

  Widget _title() {
    return const Text(
      'Sign Up',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _entryField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget _errorMessage() {
    return errorMessage.isNotEmpty
        ? Text(
            errorMessage,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          )
        : const SizedBox.shrink();
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: registerUser,
        child: const Text('Sign Up'),
      ),
    );
  }

  Widget _loginToggle(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context); // Go back to login
      },
      child: const Text("Already have an account? Login"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_open, size: 100, color: Colors.blue),
                const SizedBox(height: 30),
                _title(),
                const SizedBox(height: 30),
                _entryField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                _entryField(
                  label: 'Password',
                  icon: Icons.lock,
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                _errorMessage(),
                const SizedBox(height: 30),
                _submitButton(),
                const SizedBox(height: 20),
                _loginToggle(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

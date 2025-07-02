import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_ui/homepage.dart';
import 'package:login_ui/signup.dart';
import '../auth.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String errorMessage = "";
  bool isLogin = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      print("User signed in: ${userCredential.user?.email}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  Homepage()),
      );
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
      print("Error signing in: $errorMessage");
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      print("User registered: ${userCredential.user?.email}");
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
      print("Error registering: $errorMessage");
    }
  }

  Widget _title() {
    return Text(
      isLogin ? 'Login' : 'Sign Up',
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
        ? Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 14))
        : SizedBox.shrink();
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Login' : 'Sign Up'),
      ),
    );
  }

  Widget _loginorregisterToggle() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignupPage()),
        );
      },
      child: Text("Don't have an account? Sign Up"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 100, color: Colors.blue),
                SizedBox(height: 30),
                _title(),
                SizedBox(height: 30),
                _entryField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: emailController,
                ),
                SizedBox(height: 20),
                _entryField(
                  label: 'Password',
                  icon: Icons.lock,
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                _errorMessage(),
                SizedBox(height: 30),
                _submitButton(),
                SizedBox(height: 20),
                _loginorregisterToggle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

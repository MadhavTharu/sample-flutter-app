// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Homepage extends StatelessWidget {
//    Homepage({super.key});
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   Future<void> _signOut() async {
//     await _auth.signOut();
//   }
//  Widget _title() {
//     return Text(
//       'Welcome, ${_auth.currentUser?.email ?? 'Guest'}',
//       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//     );
//   }
//   Widget _userInfo() {
//     return Text(
//       'User ID: ${_auth.currentUser?.uid ?? 'Not signed in'}',
//       style: TextStyle(fontSize: 16),
//     );
//   }
//  Widget _signOutButton(BuildContext context) {
//   return ElevatedButton(
//     onPressed: () => _signOut(context),
//     child: Text('Sign Out'),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home Page')),
//       body: Center(
//         child: Column(

//           children: [

//             SizedBox(height: 20),
//             _title(),
//             SizedBox(height: 10),
//             _userInfo(),
//             SizedBox(height: 20),
//             _signOutButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    // Navigate back to login page (replace '/login' with your actual login route)
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Widget _title() {
    return Text(
      'Welcome, ${_auth.currentUser?.email ?? 'Guest'}',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _signOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _signOut(context),
      child: Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_title(), SizedBox(height: 20), _signOutButton(context)],
        ),
      ),
    );
  }
}

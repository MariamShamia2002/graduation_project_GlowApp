import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Glow/controllers/fb_auth_controller.dart';
import 'package:Glow/screens/app/contact_screen.dart';
import 'package:Glow/screens/app/edit_profile_screen.dart';
import 'package:Glow/screens/app/profile_screen.dart';
import 'package:Glow/screens/auth/forget_password_screen.dart';
import 'package:Glow/screens/auth/guard_screen.dart';
import 'package:Glow/screens/auth/login_screen.dart';
import 'package:Glow/screens/auth/register_screen.dart';
import 'package:Glow/screens/auth/splash_screen.dart';
import 'package:Glow/screens/app/home_screen.dart';
import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   User? user = FirebaseAuth.instance.currentUser;
//   runApp(MyApp(user: user!));
// }

// class MyApp extends StatelessWidget {
//   final User user;
//   const MyApp({super.key, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'GLOW',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       routes: {
//         '/register_screen': (context) => const RegisterScreen(),
//         '/login_screen': (context) => LoginScreen(isUser: true),
//         '/splash_screen': (context) => const SplashScreen(),
//         '/forget_password_screen': (context) => const ForgetPasswordScreen(),
//         '/profile_screen': (context) => const ProfileScreen(),
//         '/edit_profile_screen': (context) => const EditProfileScreen(),
//         '/contact_screen': (context) => const ContactScreen(),
//         '/guard_screen': (context) => const GuardScreen(),
//         '/home_screen': (context) => HomeScreen(
//               user: user,
//               isDermatologist: false,
//             ),
//       },
//       initialRoute: '/splash_screen',
//     );
//   }
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? user = FirebaseAuth.instance.currentUser;

  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final User? user; // Make the user nullable
  const MyApp({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GLOW',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/register_screen': (context) => const RegisterScreen(),
        '/login_screen': (context) => LoginScreen(isUser: true),
        '/splash_screen': (context) => const SplashScreen(),
        '/forget_password_screen': (context) => const ForgetPasswordScreen(),
        '/profile_screen': (context) => const ProfileScreen(),
        '/edit_profile_screen': (context) => const EditProfileScreen(),
        '/contact_screen': (context) => const ContactScreen(),
        '/guard_screen': (context) => const GuardScreen(),
        '/home_screen': (context) => user != null
            ? HomeScreen(
                user: user!,
                isDermatologist: false,
              )
            : const SplashScreen(),
      },
      initialRoute: user != null ? '/home_screen' : '/splash_screen',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_app/components/my_button.dart';
import 'package:mini_app/components/textfield.dart';
import 'package:mini_app/home_page.dart';
import 'package:mini_app/register_page.dart';

class LoginPage extends StatefulWidget {
  // final bool isDarkMode;
  // final Function(bool) onToggle;

  const LoginPage({
    super.key,
    // required this.isDarkMode,
    // required this.onToggle,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      print('Attempting login with email: $email');

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print('Firebase login returned user: ${userCredential.user}');

      if (userCredential.user != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login Successful!')));

        // Navigate to Dashboard only if user is not null
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        print('Login failed: userCredential.user is null');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Try again.')),
        );
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}');
      String errorMsg = 'Login failed. Please try again.';
      if (e.code == 'user-not-found') {
        errorMsg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Incorrect password.';
      } else if (e.code == 'invalid-email') {
        errorMsg = 'Invalid email format.';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMsg)));
    } catch (e) {
      print('Other exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred, try again.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // actions: [
        //   Switch(
        //     value: widget.isDarkMode,
        //     onChanged: (value) {
        //       widget.onToggle(value);
        //       setState(() {});
        //     },
        //   ),
        //   SizedBox(width: 10),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // FlutterLogo( size: 20,),
                // Icon(
                //   Icons.person,
                //   size: 150,
                //   color: Theme.of(context).colorScheme.inversePrimary,
                // ),
                // const SizedBox(height: 20),
                Text(
                  "L O G I N",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 40),
                MyTextfield(
                  obscuretext: false,
                  controller: emailController,
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                MyTextfield(
                  obscuretext: _obscurePassword,
                  controller: passwordController,
                  hintText: "Enter your password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : MyButton(
                        text: "Login",
                        onTap: loginUser,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
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

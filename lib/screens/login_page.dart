import 'package:flutter/material.dart';
import 'package:speechtotext/screens/auth_service.dart';
import 'package:speechtotext/screens/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  String? _errorMessage;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    final user = await _authService.signInWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
<<<<<<< HEAD
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    if (user == null) {
      setState(() {
        _errorMessage = 'Invalid email or password. Please try again.';
      });
    }
    // Navigation will be handled by the AuthWrapper
=======
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      if (user == null) {
        setState(() {
          _errorMessage = 'Invalid email or password. Please try again.';
        });
      }
    }
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
  }

  void _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
<<<<<<< HEAD
    try {
      final user = await _authService.signInWithGoogle();
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (user == null) {
        // This case now specifically means the user canceled the sign-in picker.
        setState(() {
          _errorMessage = 'Google Sign-In was canceled.';
        });
      }
      // Successful sign-in will be handled by the AuthWrapper stream.
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString(); // Display the error as a string.
      });
=======
    final user = await _authService.signInWithGoogle();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      if (user == null) {
        setState(() {
          _errorMessage = 'Google Sign-In failed. Please try again.';
        });
      }
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
<<<<<<< HEAD
        0xFFFAF9EE,
=======
        0xFFF7F8F9,
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 1),
              const Text(
                "Welcome back! Go with your Tasks!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),
              _buildTextField(
                controller: _emailController,
                hintText: 'Enter your email',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _passwordController,
                hintText: 'Enter your password',
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
<<<<<<< HEAD
                  onPressed: () {
                    // TODO: Implement Forgot Password functionality
                  },
=======
                  onPressed: () {},
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
<<<<<<< HEAD
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF212121),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
=======
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF212121),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
              const Spacer(flex: 2),
              _buildSocialLoginSection(),
              const Spacer(flex: 1),
              _buildBottomNavigation(context),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  Widget _buildSocialLoginSection() {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Or Login with',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
<<<<<<< HEAD
            onPressed: _isLoading ? null : _signInWithGoogle,
            icon: Image.asset('assets/images/google_signlogo.png', height: 22.0), // Assuming the logo is in assets/images
=======
            onPressed: _signInWithGoogle,
            // --- THIS IS THE FIX ---
            // Corrected the asset filename to match your project.
            icon: Image.asset('assets/images/google_signlogo.png', height: 22.0),
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
            label: const Text('Sign in with Google'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupPage()),
            );
          },
          child: const Text(
            'Register Now',
            style: TextStyle(
              color: Color(0xFF2962FF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
<<<<<<< HEAD
}
=======
}



// import 'package:flutter/material.dart';
// import 'package:speechtotext/screens/auth_service.dart';
// import 'package:speechtotext/screens/signup_page.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final AuthService _authService = AuthService();
//   String? _errorMessage;
//   bool _isLoading = false;
//   bool _isPasswordVisible = false;
//
//   void _login() async {
//     // Login logic remains the same
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//     final user = await _authService.signInWithEmail(
//       _emailController.text.trim(),
//       _passwordController.text.trim(),
//     );
//     if (mounted) {
//       setState(() {
//         _isLoading = false;
//       });
//       if (user == null) {
//         setState(() {
//           _errorMessage = 'Invalid email or password. Please try again.';
//         });
//       }
//     }
//   }
//
//   void _signInWithGoogle() async {
//     // Google sign-in logic remains the same
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//     final user = await _authService.signInWithGoogle();
//     if (mounted) {
//       setState(() {
//         _isLoading = false;
//       });
//       if (user == null) {
//         setState(() {
//           _errorMessage = 'Google Sign-In failed. Please try again.';
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(
//         0xFFF7F8F9,
//       ), // A slightly off-white background
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Use a flexible spacer at the top
//               const Spacer(flex: 1),
//               const Text(
//                 "Welcome back! Glad\nto see you, Again!",
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               _buildTextField(
//                 controller: _emailController,
//                 hintText: 'Enter your email',
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 controller: _passwordController,
//                 hintText: 'Enter your password',
//                 obscureText: !_isPasswordVisible,
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _isPasswordVisible
//                         ? Icons.visibility
//                         : Icons.visibility_off,
//                     color: Colors.grey,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _isPasswordVisible = !_isPasswordVisible;
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Forgot Password?',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               if (_errorMessage != null)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: Text(
//                     _errorMessage!,
//                     style: const TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               _isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: _login,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF212121),
//                           padding: const EdgeInsets.symmetric(vertical: 18),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text(
//                           'Login',
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                         ),
//                       ),
//                     ),
//               // Use another flexible spacer
//               const Spacer(flex: 2),
//               _buildSocialLoginSection(),
//               const Spacer(flex: 1),
//               _buildBottomNavigation(context),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     bool obscureText = false,
//     Widget? suffixIcon,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         hintText: hintText,
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 18,
//           horizontal: 20,
//         ),
//         suffixIcon: suffixIcon,
//       ),
//     );
//   }
//
//   Widget _buildSocialLoginSection() {
//     return Column(
//       children: [
//         const Row(
//           children: [
//             Expanded(child: Divider()),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(
//                 'Or Login with',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             Expanded(child: Divider()),
//           ],
//         ),
//         const SizedBox(height: 20),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton.icon(
//             onPressed: _signInWithGoogle,
//             icon: Image.asset('assets/google_logo.png', height: 22.0),
//             label: const Text('Sign in with Google'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.white,
//               foregroundColor: Colors.black,
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 side: BorderSide(color: Colors.grey.shade300),
//               ),
//               elevation: 0,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBottomNavigation(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("Don't have an account?"),
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const SignupPage()),
//             );
//           },
//           child: const Text(
//             'Register Now',
//             style: TextStyle(
//               color: Color(0xFF2962FF), // A nice blue color
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0

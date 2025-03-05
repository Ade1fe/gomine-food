// import 'package:flutter/material.dart';
// import 'package:gomine_food/widgets/app_scaffold.dart';
// import '../../../consants/image_constants.dart';
// import '../../../theme/theme.dart';
// import '../../../widgets/custom_button.dart';
// import '../../../widgets/custom_textfield.dart';
// import '../signup/sign_up_screen.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               _buildLogo(),
//               const SizedBox(height: 40),
//               _buildEmailField(),
//               const SizedBox(height: 16),
//               _buildPasswordField(),
//               const SizedBox(height: 24),
//               _buildSignInButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLogo() {
//     return Center(
//       child: _buildHeader(),
//     );
//   }

//   Widget _buildHeader() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Image.asset(
//           ImageConstants.logo,
//           width: 200,
//           height: 200,
//         ),
//         Text(
//           'Gomine_Food',
//           style: AppTextStyles.getStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: AppColors.brown,
//           ),
//         ),
//         Text(
//           'Delivery of Favorite Food',
//           style: Theme.of(context).textTheme.bodyLarge,
//         ),
//         const SizedBox(height: 40),
//         Text(
//           'Login To Your Account',
//           style: Theme.of(context).textTheme.displayLarge,
//         ),
//       ],
//     );
//   }

//   Widget _buildEmailField() {
//     return CustomTextField(
//       controller: _emailController,
//       hintText: 'Enter your email',
//       labelText: 'Email',
//       keyboardType: TextInputType.emailAddress,
//       prefixIcon: const Icon(Icons.email, color: AppColors.primary),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your email';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildPasswordField() {
//     return CustomTextField(
//       controller: _passwordController,
//       hintText: 'Enter your password',
//       labelText: 'Password',
//       obscureText: true,
//       prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your password';
//         }
//         if (value.length < 6) {
//           return 'Password must be at least 6 characters long';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildSignInButton() {
//     return CustomButton(
//       text: 'Log  In',
//       width: 150,
//       onPressed: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => const SignUpScreen()),
//         );
//         // _signIn();
//       },
//       type: ButtonType.primary,
//       // icon: Icon(Icons.restaurant_menu, color: Colors.white),
//     );
//   }

//   void _signIn() {
//     if (_formKey.currentState?.validate() ?? false) {
//       print('Signing in with email: ${_emailController.text}');
//       // Add actual sign-in logic (API calls, etc.)
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:gomine_food/widgets/app_scaffold.dart';
import '../../../consants/image_constants.dart';
import '../../../theme/theme.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../signup/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildLogo(),
              const SizedBox(height: 40),
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 24),
              _buildSignInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: _buildHeader(),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          ImageConstants.logo,
          width: 200,
          height: 200,
        ),
        Text(
          'Gomine_Food',
          style: AppTextStyles.getStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.brown,
          ),
        ),
        Text(
          'Delivery of Favorite Food',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 40),
        Text(
          'Login To Your Account',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      hintText: 'Enter your email',
      labelText: 'Email',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(
        Icons.email,
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkPrimary
            : AppColors.primary,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      hintText: 'Enter your password',
      labelText: 'Password',
      obscureText: true,
      prefixIcon: Icon(
        Icons.lock,
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkPrimary
            : AppColors.primary,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }

  Widget _buildSignInButton() {
    return CustomButton(
      text: 'Log In',
      width: 150,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        );
        // _signIn();
      },
      type: ButtonType.primary,
    );
  }

  void _signIn() {
    if (_formKey.currentState?.validate() ?? false) {
      print('Signing in with email: ${_emailController.text}');
      // Add actual sign-in logic (API calls, etc.)
    }
  }
}

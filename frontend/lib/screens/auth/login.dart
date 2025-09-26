import 'package:event_tracker/theme/colors.dart';
import 'package:event_tracker/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../../widgets/button.dart';
import '/components/ui_utils.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthController>(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              vSpace(50),

              // Logo
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiaryContainer.withAlpha((0.2 * 255).toInt()),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo1.png',
                    height: 150,
                    width: 130,
                  ),
                ),
              ),

              vSpace(25),

              // Welcome Text
              Text(
                "Welcome Back",
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.titleLarge?.color, // theme-aware
                ),
              ),

              vSpace(20),

              // Email Field
              customTextFormField(
                controller: auth.txtLoginEmail,
                hintText: "Email",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? "Please enter email" : null,
              ),
              vSpace(20),

              // Password Field
              customPasswordFormField(
                controller: auth.txtLoginPassword,
                obscureText: auth.obscureLoginPassword,
                onToggleVisibility: auth.toggleLoginPasswordVisibility,
                validator: (value) => value == null || value.isEmpty ? "Please enter password" : null,
              ),

              vSpace(16),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: elevatedButton(
                  onPressed: () => auth.handleLogin(context),
                  label: "Login",
                ),
              ),

              vSpace(10),

              // Divider
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("or"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              vSpace(10),

              // Google Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: outlinedButton(
                  label: "Continue with Google",
                  icon: Image.asset(
                    'assets/images/google.png',
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () {
                  //todo: add google login
                  },
                ),
              ),

              vSpace(20),

              // Apple Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: outlinedButton(
                  label: "Continue with Apple",
                  icon: Image.asset(
                    'assets/images/apple.png',
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () {
                    // todo: add apple login
                  }
                ),
              ),

              // Signup Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => auth.navigateToRegister(context),
                    child: const Text(
                      "Don’t have an account? Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kPrimaryColor,
                      ),
                    ),
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

import 'dart:collection';
import 'package:event_tracker/components/ui_utils.dart';
import 'package:event_tracker/widgets/button.dart';
import 'package:event_tracker/widgets/text_field.dart';
import 'package:event_tracker/widgets/label_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

typedef RoleEntry = DropdownMenuEntry<UserRole>;

enum UserRole {
  manager('Manager', 1),
  user('User', 2);

  const UserRole(this.label, this.value);

  final String label;
  final int value;

  static final List<RoleEntry> entries = UnmodifiableListView<RoleEntry>(
    UserRole.values.map<RoleEntry>(
          (UserRole role) => RoleEntry(
        value: role,
        label: role.label,
      ),
    ),
  );
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  UserRole? selectedRole;

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthController>(context);
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    var textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelText(text: 'Name', textTheme: textTheme),
              customTextFormField(
                  controller: auth.txtRegisterName, hintText: 'Enter Your Name'),
              vSpace(),

              LabelText(text: 'Email', textTheme: textTheme),
              customTextFormField(
                  controller: auth.txtRegisterEmail, hintText: 'Enter Your Email'),
              vSpace(),

              LabelText(text: 'Contact No.', textTheme: textTheme),
              customTextFormField(
                  controller: auth.txtRegisterPhone, hintText: 'Enter Your Contact No.'),
              vSpace(),
              LabelText(text: 'Role', textTheme: textTheme),
              Container(
                alignment: Alignment.centerLeft,
                  child: DropdownMenu<UserRole>(
                    controller: auth.txtRegisterRole,
                    dropdownMenuEntries: UserRole.values.map((role) {
                      return DropdownMenuEntry<UserRole>(
                        value: role,
                        label: role.label,
                        style: ButtonStyle(
                          foregroundColor: WidgetStateColor.resolveWith(
                                (states) => Colors.black, // text always black
                          ),
                          textStyle: WidgetStateTextStyle.resolveWith(
                                (states) => const TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    }).toList(),
                    trailingIcon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                    onSelected: (UserRole? value) {
                      setState(() {
                        selectedRole = value;
                        if (value != null) {
                          auth.txtRegisterRole.text = value.label;
                        }
                      });
                    },
                    menuHeight: 200,
                    menuStyle: MenuStyle(
                      backgroundColor: WidgetStateColor.resolveWith((states) => Colors.white), // menu background white
                      elevation: WidgetStateProperty.resolveWith((states) => 2),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              vSpace(),
              LabelText(text: 'Create Password', textTheme: textTheme),
              customPasswordFormField(
                controller: auth.txtRegisterPassword,
                hintText: 'Create Password',
                obscureText: auth.obscureRegisterPassword,
                onToggleVisibility: auth.toggleRegisterPasswordVisibility,
              ),
              vSpace(),

              LabelText(text: 'Confirm Password', textTheme: textTheme),
              customPasswordFormField(
                controller: auth.txtRegisterConfirmPassword,
                hintText: 'Confirm Password',
                obscureText: auth.obscureRegisterConfirmPassword,
                onToggleVisibility:
                auth.toggleRegisterConfirmPasswordVisibility,
              ),
              vSpace(20),

              elevatedButton(
                label: 'Register',
                onPressed: () => auth.handleSubmit(context),
                minimumSize: const Size(double.infinity, 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}

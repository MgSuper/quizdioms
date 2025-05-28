import 'package:flutter/material.dart';

class AuthFormWidget extends StatefulWidget {
  final String title;
  final String buttonLabel;
  final void Function(String email, String password) onSubmit;
  final bool isLoading;
  final String bottomText;
  final VoidCallback onToggle;

  const AuthFormWidget({
    super.key,
    required this.title,
    required this.buttonLabel,
    required this.onSubmit,
    this.isLoading = false,
    required this.bottomText,
    required this.onToggle,
  });

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF316E79),
            Color(0xFF88A6AA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 640),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    widget.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Color(0xFFD8E2E4),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          label: 'Email',
                          onChanged: (v) => _email = v,
                          validator: (v) => v != null && v.contains('@')
                              ? null
                              : 'Invalid email',
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: 'Password',
                          obscure: true,
                          onChanged: (v) => _password = v,
                          validator: (v) =>
                              v != null && v.length >= 6 ? null : 'Min 6 chars',
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Color(0xFFD8E2E4),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: widget.isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      widget.onSubmit(
                                          _email.trim(), _password.trim());
                                    }
                                  },
                            child: widget.isLoading
                                ? const CircularProgressIndicator()
                                : Text(
                                    widget.buttonLabel,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFD8E2E4),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.bottomText,
                              style: const TextStyle(
                                color: Color(0xFFD8E2E4),
                              ),
                            ),
                            TextButton(
                              onPressed: widget.onToggle,
                              child: Text(
                                widget.buttonLabel.contains("Sign Up")
                                    ? "Sign In"
                                    : "Sign Up",
                                style: const TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    bool obscure = false,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      obscureText: obscure,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.white),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Vérification',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Entrez votre numéro',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Nous vous enverrons un code par SMS',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 32),
              CustomInput(
                controller: _phoneController,
                hintText: '+237 123 45 67',
                keyboardType: TextInputType.phone,
                prefix: Icons.phone,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Envoyer le code',
                isLoading: _isLoading,
                onPressed: _sendVerificationCode,
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: 'En continuant, vous acceptez nos ',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                  children: [
                    const TextSpan(text: 'conditions d\'utilisation'),
                    const TextSpan(
                      text: ' et ',
                      style: TextStyle(
                        color: Color(0xFF3B82F6),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const TextSpan(text: 'politique de confidentialité'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendVerificationCode() async {
    if (_phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez entrer un numéro valide'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate sending verification code
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Provider.of<AuthProvider>(context, listen: false)
            .completeAuthentication();
        Navigator.pushReplacementNamed(context, '/passenger-home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${e.toString()}'),
            backgroundColor: Color(0xFFEF4444),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  bool _isProcessing = false;
  String _selectedMethod = 'mobile_money';

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
          'Paiement',
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
                'Méthode de paiement',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 32),

              // Payment Method Selection
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choisissez votre méthode',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _PaymentMethodButton(
                          method: 'mobile_money',
                          title: 'Mobile Money',
                          icon: Icons.phone_android,
                          isSelected: _selectedMethod == 'mobile_money',
                          onTap: () =>
                              setState(() => _selectedMethod = 'mobile_money'),
                        ),
                        const SizedBox(width: 16),
                        _PaymentMethodButton(
                          method: 'orange_money',
                          title: 'Orange Money',
                          icon: Icons.account_balance_wallet,
                          isSelected: _selectedMethod == 'orange_money',
                          onTap: () =>
                              setState(() => _selectedMethod = 'orange_money'),
                        ),
                        const SizedBox(width: 16),
                        _PaymentMethodButton(
                          method: 'credit_card',
                          title: 'Carte Bancaire',
                          icon: Icons.credit_card,
                          isSelected: _selectedMethod == 'credit_card',
                          onTap: () =>
                              setState(() => _selectedMethod = 'credit_card'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Card Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informations de la carte',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomInput(
                      controller: _cardController,
                      hintText: 'Numéro de la carte',
                      keyboardType: TextInputType.number,
                      prefix: Icons.credit_card,
                    ),
                    const SizedBox(height: 12),
                    CustomInput(
                      controller: _expiryController,
                      hintText: 'MM/AA',
                      keyboardType: TextInputType.text,
                      prefix: Icons.calendar_today,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Process Button
              CustomButton(
                text: _isProcessing
                    ? 'Traitement en cours...'
                    : 'Confirmer et payer',
                isLoading: _isProcessing,
                onPressed: _selectedMethod.isEmpty ? null : _processPayment,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _PaymentMethodButton({
    required String method,
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFFE5E7EB)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : const Color(0xFF6B7280),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF1F2937),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processPayment() async {
    if (_cardController.text.isEmpty ||
        _expiryController.text.isEmpty ||
        _selectedMethod.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 3));

      if (mounted) {
        setState(() {
          _isProcessing = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Paiement effectué avec succès!'),
            backgroundColor: Color(0xFF10B981),
          ),
        );

        // Navigate back to home after successful payment
        Navigator.pushReplacementNamed(context, '/passenger-home');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur de paiement: ${e.toString()}'),
            backgroundColor: Color(0xFFEF4444),
          ),
        );
      }
    }
  }
}

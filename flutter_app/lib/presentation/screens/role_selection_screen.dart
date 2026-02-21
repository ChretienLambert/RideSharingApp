import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import 'onboarding_screen.dart';
import 'passenger_home_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.directions_car,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Co-Voiturage Cameroun',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Sélectionnez votre type de compte',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _RoleCard(
                      icon: Icons.person,
                      iconColor: const Color(0xFF3B82F6),
                      backgroundColor: const Color(0xFFEFF6FF),
                      title: 'Passager',
                      description: 'Réserver des trajets partagés',
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .setUserRole(UserRole.passenger);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _RoleCard(
                      icon: Icons.drive_eta,
                      iconColor: const Color(0xFF3B82F6),
                      backgroundColor: const Color(0xFFEFF6FF),
                      title: 'Conducteur',
                      description: 'Proposer des trajets et gagner',
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .setUserRole(UserRole.driver);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _RoleCard(
                      icon: Icons.admin_panel_settings,
                      iconColor: const Color(0xFF8B5CF6),
                      backgroundColor: const Color(0xFFEDE9FE),
                      title: 'Administrateur',
                      description: 'Gérer la plateforme',
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .setUserRole(UserRole.admin);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .setUserRole(UserRole.passenger);
                        Provider.of<AuthProvider>(context, listen: false)
                            .completeOnboarding();
                        Provider.of<AuthProvider>(context, listen: false)
                            .completeAuthentication();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PassengerHomeScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Ignorer et voir la démo',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 28,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

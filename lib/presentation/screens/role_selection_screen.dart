import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/auth_provider.dart';
import 'onboarding_screen.dart';
import 'passenger_home_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const passengerColor = Color(0xFF3B82F6);
    final driverColor = Theme.of(context).colorScheme.primary;
    const adminColor = Color(0xFF8B5CF6);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
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
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.directions_car,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Co-Voiturage Cameroun',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sélectionnez votre type de compte',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _RoleCard(
                          icon: Icons.person,
                          iconColor: passengerColor,
                          backgroundColor:
                              passengerColor.withValues(alpha: 0.10),
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
                          iconColor: driverColor,
                          backgroundColor: driverColor.withValues(alpha: 0.10),
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
                          iconColor: adminColor,
                          backgroundColor: adminColor.withValues(alpha: 0.10),
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
                                builder: (context) =>
                                    const PassengerHomeScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: Text(
                            'Ignorer et voir la démo',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Theme.of(context).hintColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
          border: Border.all(color: Theme.of(context).dividerColor, width: 2),
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
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

import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BottomNavigation({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home,
                label: 'Accueil',
                isActive: currentIndex == 0,
                onTap: () {
                  // Navigate to home
                },
              ),
              _NavItem(
                icon: Icons.calendar_today,
                label: 'Programmés',
                isActive: currentIndex == 1,
                onTap: () {
                  // Navigate to scheduled
                },
              ),
              _NavItem(
                icon: Icons.history,
                label: 'Historique',
                isActive: currentIndex == 2,
                onTap: () {
                  // Navigate to history
                },
              ),
              _NavItem(
                icon: Icons.person,
                label: 'Profil',
                isActive: currentIndex == 3,
                onTap: () {
                  // Navigate to profile
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF3B82F6) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isActive ? Colors.white : const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

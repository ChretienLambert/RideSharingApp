import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BottomNavigation({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home,
                label: 'Accueil',
                isActive: currentIndex == 0,
                onTap: () {
                  if (currentIndex != 0) {
                    Navigator.pushReplacementNamed(context, '/passenger-home');
                  }
                },
              ),
              _NavItem(
                icon: Icons.calendar_today,
                label: 'Programmés',
                isActive: currentIndex == 1,
                onTap: () {
                  if (currentIndex != 1) {
                    Navigator.pushNamed(context, '/scheduled-routes');
                  }
                },
              ),
              _NavItem(
                icon: Icons.history,
                label: 'Historique',
                isActive: currentIndex == 2,
                onTap: () {
                  if (currentIndex != 2) {
                    Navigator.pushNamed(context, '/ride-history');
                  }
                },
              ),
              _NavItem(
                icon: Icons.person,
                label: 'Profil',
                isActive: currentIndex == 3,
                onTap: () {
                  if (currentIndex != 3) {
                    Navigator.pushNamed(context, '/profile');
                  }
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
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color muted = Theme.of(context).textTheme.bodySmall?.color ??
        Theme.of(context).hintColor;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isActive
                  ? primary.withValues(alpha: 0.10)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isActive ? primary : muted,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive ? primary : muted,
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

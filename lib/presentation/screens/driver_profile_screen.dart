import 'package:flutter/material.dart';
import '../../core/utils/app_logger.dart';
import '../widgets/custom_button.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  bool _showReviews = true;

  @override
  Widget build(BuildContext context) {
    final driver =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {
              'driverName': 'Jean Kamga',
              'driverRating': 4.8,
              'driverTrips': 156,
              'driverBio':
                  'Conducteur professionnel avec 5 ans d\'expérience. Véhicule propre et climatisé. Je privilégie la sécurité et le confort de mes passagers.',
              'memberSince': '2022',
              'responseRate': '98%',
              'responseTime': '5 min',
              'verified': true,
              'languages': ['Français', 'Anglais'],
              'vehicle': 'Toyota Corolla',
              'vehicleYear': '2022',
              'vehicleColor': 'Gris',
              'licenseVerified': true,
              'insuranceVerified': true,
              'phoneVerified': true,
              'emailVerified': true,
            };

    final reviews = [
      {
        'author': 'Marie Ngo',
        'rating': 5.0,
        'date': '15 Fév 2026',
        'text':
            'Excellent conducteur! Ponctuel, très professionnel et sympathique. Le trajet était confortable et sûr. Je recommande vivement!',
        'avatar': 'M',
      },
      {
        'author': 'Pierre Etoundi',
        'rating': 5.0,
        'date': '10 Fév 2026',
        'text':
            'Parfait! Jean est un super chauffeur. Véhicule impeccable, conduite douce. À refaire sans hésiter.',
        'avatar': 'P',
      },
      {
        'author': 'Alice Johnson',
        'rating': 4.0,
        'date': '5 Fév 2026',
        'text':
            'Bon trajet dans l\'ensemble. Léger retard de 10 minutes mais Jean m\'a prévenu à l\'avance.',
        'avatar': 'A',
      },
    ];

    final stats = [
      {
        'label': 'Trajets',
        'value': '${driver['driverTrips']}',
        'icon': Icons.directions_car
      },
      {'label': 'Annulations', 'value': '2%', 'icon': Icons.cancel},
      {
        'label': 'Taux réponse',
        'value': driver['responseRate'],
        'icon': Icons.message
      },
      {
        'label': 'Temps réponse',
        'value': driver['responseTime'],
        'icon': Icons.schedule
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: const Color(0xFF3B82F6),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  AppLogger.logUserAction('Share driver profile',
                      metadata: {'driver': driver['driverName']});
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF3B82F6),
                      const Color(0xFF2563EB),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 60),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Text(
                                driver['driverName']
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: const TextStyle(
                                  color: Color(0xFF3B82F6),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (driver['verified'])
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                  ),
                                  child: const Icon(Icons.check,
                                      size: 16, color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          driver['driverName'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.white),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${driver['driverRating']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Membre depuis ${driver['memberSince']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Stats Grid
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 0.8,
                    children: stats.map((stat) {
                      return Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              stat['icon'] as IconData,
                              color: const Color(0xFF3B82F6),
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            stat['value']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          Text(
                            stat['label']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),

                // About Section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'À propos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        driver['driverBio'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Languages
                      Row(
                        children: [
                          const Icon(Icons.language,
                              size: 20, color: Color(0xFF9CA3AF)),
                          const SizedBox(width: 8),
                          Text(
                            'Langues: ${(driver['languages'] as List).join(', ')}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Verifications
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Vérifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildVerificationItem(
                        'Permis de conduire',
                        driver['licenseVerified'],
                        Icons.badge,
                      ),
                      _buildVerificationItem(
                        'Assurance véhicule',
                        driver['insuranceVerified'],
                        Icons.verified_user,
                      ),
                      _buildVerificationItem(
                        'Téléphone vérifié',
                        driver['phoneVerified'],
                        Icons.phone,
                      ),
                      _buildVerificationItem(
                        'Email vérifié',
                        driver['emailVerified'],
                        Icons.email,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Vehicle Info
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Véhicule',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.directions_car,
                                size: 40, color: Color(0xFF9CA3AF)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${driver['vehicle']} ${driver['vehicleYear']}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Couleur: ${driver['vehicleColor']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Reviews Section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Avis (${reviews.length})',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() => _showReviews = !_showReviews);
                            },
                            child: Text(_showReviews ? 'Masquer' : 'Voir tout'),
                          ),
                        ],
                      ),
                      if (_showReviews) ...[
                        const SizedBox(height: 16),
                        ...reviews.map((review) => _buildReviewCard(review)),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: CustomButton(
            text: 'Contacter le conducteur',
            onPressed: () {
              AppLogger.logUserAction('Contact driver',
                  metadata: {'driver': driver['driverName']});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Message('Fonctionnalité de messagerie à venir!'),
                  backgroundColor: Color(0xFF3B82F6),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildVerificationItem(String label, bool verified, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color:
                  verified ? const Color(0xFFD1FAE5) : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color:
                  verified ? const Color(0xFF10B981) : const Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF374151),
              ),
            ),
          ),
          Icon(
            verified ? Icons.check_circle : Icons.cancel,
            color: verified ? const Color(0xFF10B981) : const Color(0xFF9CA3AF),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFEFF6FF),
                child: Text(
                  review['avatar'],
                  style: const TextStyle(
                    color: Color(0xFF3B82F6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['author'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    Text(
                      review['date'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Color(0xFFF59E0B)),
                  const SizedBox(width: 4),
                  Text(
                    '${review['rating']}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review['text'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String message;
  const Message(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(message);
  }
}

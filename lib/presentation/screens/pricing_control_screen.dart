import 'package:flutter/material.dart';
import '../../core/utils/app_logger.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/custom_button.dart';

class PricingControlScreen extends StatefulWidget {
  const PricingControlScreen({super.key});

  @override
  State<PricingControlScreen> createState() => _PricingControlScreenState();
}

class _PricingControlScreenState extends State<PricingControlScreen> {
  final Map<String, TextEditingController> _pricingControllers = {
    'baseRate': TextEditingController(text: '500'),
    'perKmRate': TextEditingController(text: '150'),
    'minimumFare': TextEditingController(text: '1000'),
    'peakHourMultiplier': TextEditingController(text: '1.2'),
    'nightMultiplier': TextEditingController(text: '1.5'),
    'commissionRate': TextEditingController(text: '15'),
  };

  final List<Map<String, dynamic>> _popularRoutes = [
    {
      'from': 'Yaoundé',
      'to': 'Douala',
      'basePrice': '5,000',
      'distance': '240 km'
    },
    {
      'from': 'Douala',
      'to': 'Bafoussam',
      'basePrice': '3,500',
      'distance': '180 km'
    },
    {
      'from': 'Yaoundé',
      'to': 'Bafoussam',
      'basePrice': '4,000',
      'distance': '200 km'
    },
    {
      'from': 'Douala',
      'to': 'Limbe',
      'basePrice': '2,000',
      'distance': '80 km'
    },
  ];

  bool _isEditing = false;

  void _savePricing() {
    AppLogger.info('Pricing updated', tag: 'PricingControl', data: {
      'baseRate': _pricingControllers['baseRate']?.text,
      'perKmRate': _pricingControllers['perKmRate']?.text,
    });
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tarifs mis à jour avec succès!'),
        backgroundColor: Color(0xFF10B981),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _pricingControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Contrôle des Tarifs',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_isEditing) {
                _savePricing();
              } else {
                setState(() => _isEditing = true);
              }
            },
            child: Text(
              _isEditing ? 'Sauvegarder' : 'Modifier',
              style: const TextStyle(
                color: Color(0xFF3B82F6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tarifs Actuels',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildPricingCard(
                          'Tarif de base',
                          '${_pricingControllers['baseRate']?.text} FCFA',
                          Icons.local_taxi,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildPricingCard(
                          'Par km',
                          '${_pricingControllers['perKmRate']?.text} FCFA',
                          Icons.route,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildPricingCard(
                          'Course min.',
                          '${_pricingControllers['minimumFare']?.text} FCFA',
                          Icons.attach_money,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildPricingCard(
                          'Commission',
                          '${_pricingControllers['commissionRate']?.text}%',
                          Icons.percent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Configuration des Tarifs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                children: [
                  _buildPricingInput(
                      'Tarif de base (FCFA)', _pricingControllers['baseRate']!),
                  const SizedBox(height: 12),
                  _buildPricingInput(
                      'Tarif par km (FCFA)', _pricingControllers['perKmRate']!),
                  const SizedBox(height: 12),
                  _buildPricingInput('Course minimale (FCFA)',
                      _pricingControllers['minimumFare']!),
                  const SizedBox(height: 12),
                  _buildPricingInput('Multiplicateur heures de pointe',
                      _pricingControllers['peakHourMultiplier']!),
                  const SizedBox(height: 12),
                  _buildPricingInput('Multiplicateur nuit',
                      _pricingControllers['nightMultiplier']!),
                  const SizedBox(height: 12),
                  _buildPricingInput(
                      'Commission (%)', _pricingControllers['commissionRate']!),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Trajets Populaires',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _popularRoutes.length,
              itemBuilder: (context, index) {
                final route = _popularRoutes[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.route,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${route['from']} → ${route['to']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${route['distance']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${route['basePrice']} FCFA',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            if (_isEditing)
              CustomButton(
                text: 'Sauvegarder les modifications',
                onPressed: _savePricing,
              ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
    );
  }

  Widget _buildPricingCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      enabled: _isEditing,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: _isEditing ? Colors.grey[50] : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
      ),
    );
  }
}

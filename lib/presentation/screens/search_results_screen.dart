import 'package:flutter/material.dart';
import '../../core/utils/app_logger.dart';
import '../widgets/custom_button.dart';

class SearchResultsScreen extends StatefulWidget {
  final Map<String, dynamic>? searchParams;

  const SearchResultsScreen({super.key, this.searchParams});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _results = [];
  String _sortBy = 'price';

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  void _loadResults() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _results = [
        {
          'id': '1',
          'driverName': 'Jean Kamga',
          'driverRating': 4.8,
          'driverTrips': 156,
          'driverImage': null,
          'from': 'Yaoundé',
          'to': 'Douala',
          'date': '21 Fév 2026',
          'time': '08:00',
          'price': 5000,
          'originalPrice': 6000,
          'seats': 3,
          'totalSeats': 4,
          'vehicle': 'Toyota Corolla',
          'vehicleColor': 'Gris',
          'features': ['Climatisation', 'WiFi'],
          'verified': true,
        },
        {
          'id': '2',
          'driverName': 'Marie Ngo',
          'driverRating': 4.9,
          'driverTrips': 89,
          'driverImage': null,
          'from': 'Yaoundé',
          'to': 'Douala',
          'date': '21 Fév 2026',
          'time': '09:30',
          'price': 4500,
          'originalPrice': null,
          'seats': 2,
          'totalSeats': 4,
          'vehicle': 'Honda Civic',
          'vehicleColor': 'Blanc',
          'features': ['Climatisation'],
          'verified': true,
        },
        {
          'id': '3',
          'driverName': 'Pierre Etoundi',
          'driverRating': 4.5,
          'driverTrips': 42,
          'driverImage': null,
          'from': 'Yaoundé',
          'to': 'Douala',
          'date': '21 Fév 2026',
          'time': '10:00',
          'price': 5500,
          'originalPrice': null,
          'seats': 4,
          'totalSeats': 4,
          'vehicle': 'Hyundai Tucson',
          'vehicleColor': 'Noir',
          'features': ['Climatisation', 'Bagages'],
          'verified': false,
        },
        {
          'id': '4',
          'driverName': 'Alice Johnson',
          'driverRating': 4.7,
          'driverTrips': 234,
          'driverImage': null,
          'from': 'Yaoundé',
          'to': 'Douala',
          'date': '21 Fév 2026',
          'time': '14:00',
          'price': 4800,
          'originalPrice': 5200,
          'seats': 1,
          'totalSeats': 3,
          'vehicle': 'Kia Sportage',
          'vehicleColor': 'Rouge',
          'features': ['Climatisation', 'WiFi', 'Animaux acceptés'],
          'verified': true,
        },
      ];
      _isLoading = false;
    });
  }

  void _sortResults() {
    setState(() {
      if (_sortBy == 'price') {
        _results.sort((a, b) => a['price'].compareTo(b['price']));
      } else if (_sortBy == 'rating') {
        _results.sort((a, b) => b['driverRating'].compareTo(a['driverRating']));
      } else if (_sortBy == 'time') {
        _results.sort((a, b) => a['time'].compareTo(b['time']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final from = widget.searchParams?['from'] ?? 'Yaoundé';
    final to = widget.searchParams?['to'] ?? 'Douala';

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$from → $to',
              style: const TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${_results.length} trajets disponibles',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF3B82F6)),
            onPressed: () => _showFilterBottomSheet(),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Sort Bar
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Text(
                        'Trier par:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildSortChip('Prix', 'price'),
                      const SizedBox(width: 8),
                      _buildSortChip('Note', 'rating'),
                      const SizedBox(width: 8),
                      _buildSortChip('Heure', 'time'),
                    ],
                  ),
                ),
                // Results List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final ride = _results[index];
                      return _buildResultCard(ride);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSortChip(String label, String value) {
    final isSelected = _sortBy == value;
    return InkWell(
      onTap: () {
        setState(() {
          _sortBy = value;
          _sortResults();
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(Map<String, dynamic> ride) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with driver info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xFFEFF6FF),
                      child: Text(
                        ride['driverName'].substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF3B82F6),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (ride['verified'])
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            ride['driverName'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star,
                                    size: 12, color: Color(0xFFF59E0B)),
                                const SizedBox(width: 4),
                                Text(
                                  '${ride['driverRating']}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF3B82F6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${ride['driverTrips']} trajets • ${ride['vehicle']} ${ride['vehicleColor']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${ride['price']} FCFA',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    if (ride['originalPrice'] != null)
                      Text(
                        '${ride['originalPrice']} FCFA',
                        style: const TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          // Route info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3B82F6),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            ride['time'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        width: 2,
                        height: 30,
                        color: const Color(0xFFE5E7EB),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _calculateArrivalTime(ride['time']),
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.event_seat,
                          size: 16, color: Color(0xFF3B82F6)),
                      const SizedBox(width: 4),
                      Text(
                        '${ride['seats']}/${ride['totalSeats']}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Features
          if (ride['features'].isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                children: (ride['features'] as List).map((feature) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      feature,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          // Book button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: CustomButton(
              text: 'Réserver',
              onPressed: () {
                AppLogger.logUserAction('Book ride',
                    metadata: {'rideId': ride['id']});
                Navigator.pushNamed(context, '/ride-detail', arguments: ride);
              },
            ),
          ),
        ],
      ),
    );
  }

  String _calculateArrivalTime(String departureTime) {
    // Simple calculation assuming 3 hours travel time
    final parts = departureTime.split(':');
    final hour = int.parse(parts[0]) + 3;
    final minute = parts[1];
    return '${hour > 24 ? hour - 24 : hour}:$minute';
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Filtres',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildFilterSection('Prix maximum', _buildPriceRangeSlider()),
                  _buildFilterSection(
                      'Heure de départ', _buildTimeRangeSlider()),
                  _buildFilterSection('Note minimale', _buildRatingFilter()),
                  _buildFilterSection('Options', _buildFeatureFilters()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Réinitialiser'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      text: 'Appliquer',
                      onPressed: () => Navigator.pop(context),
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

  Widget _buildFilterSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 16),
        content,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPriceRangeSlider() {
    return Row(
      children: [
        Text('0 FCFA', style: TextStyle(color: Colors.grey[600])),
        Expanded(
          child: Slider(
            value: 10000,
            min: 0,
            max: 20000,
            divisions: 20,
            activeColor: const Color(0xFF3B82F6),
            onChanged: (value) {},
          ),
        ),
        Text('20k FCFA', style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildTimeRangeSlider() {
    return Wrap(
      spacing: 8,
      children: ['06:00', '08:00', '10:00', '12:00', '14:00', '16:00', '18:00']
          .map((time) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(time),
        );
      }).toList(),
    );
  }

  Widget _buildRatingFilter() {
    return Row(
      children: [
        for (int i = 4; i >= 1; i--)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, size: 16, color: Color(0xFFF59E0B)),
                    const SizedBox(width: 4),
                    Text('$i+'),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFeatureFilters() {
    final features = ['Climatisation', 'WiFi', 'Bagages', 'Animaux acceptés'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: features.map((feature) {
        return FilterChip(
          label: Text(feature),
          onSelected: (_) {},
          selected: false,
        );
      }).toList(),
    );
  }
}

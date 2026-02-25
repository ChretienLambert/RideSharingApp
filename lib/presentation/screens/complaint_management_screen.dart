import 'package:flutter/material.dart';
import '../../core/utils/app_logger.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/custom_button.dart';

class ComplaintManagementScreen extends StatefulWidget {
  const ComplaintManagementScreen({super.key});

  @override
  State<ComplaintManagementScreen> createState() =>
      _ComplaintManagementScreenState();
}

class _ComplaintManagementScreenState extends State<ComplaintManagementScreen> {
  final List<Map<String, dynamic>> _complaints = [
    {
      'id': '1',
      'title': 'Conducteur en retard',
      'description':
          'Le conducteur est arrivé 30 minutes en retard au point de rendez-vous',
      'user': 'Marie Ngo',
      'userRole': 'passenger',
      'target': 'Jean Kamga',
      'targetRole': 'driver',
      'status': 'pending',
      'priority': 'high',
      'date': '2026-02-20',
      'category': 'Retard',
    },
    {
      'id': '2',
      'title': 'Comportement inapproprié',
      'description':
          'Le passager a eu un comportement irrespectueux pendant le trajet',
      'user': 'Pierre Etoundi',
      'userRole': 'driver',
      'target': 'Alice Johnson',
      'targetRole': 'passenger',
      'status': 'resolved',
      'priority': 'medium',
      'date': '2026-02-18',
      'category': 'Comportement',
    },
    {
      'id': '3',
      'title': 'Véhicule non conforme',
      'description':
          'Le véhicule ne correspondait pas à la description sur l\'application',
      'user': 'Bob Smith',
      'userRole': 'passenger',
      'target': 'Jean Kamga',
      'targetRole': 'driver',
      'status': 'in_progress',
      'priority': 'medium',
      'date': '2026-02-19',
      'category': 'Véhicule',
    },
  ];

  void _showComplaintDetails(Map<String, dynamic> complaint) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(complaint['priority'])
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            complaint['priority'].toUpperCase(),
                            style: TextStyle(
                              color: _getPriorityColor(complaint['priority']),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getStatusColor(complaint['status'])
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getStatusLabel(complaint['status']),
                            style: TextStyle(
                              color: _getStatusColor(complaint['status']),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      complaint['title'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Catégorie: ${complaint['category']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Description'),
                    const SizedBox(height: 8),
                    Text(
                      complaint['description'],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Informations'),
                    const SizedBox(height: 16),
                    _buildInfoTile(Icons.person, 'Plaignant',
                        '${complaint['user']} (${complaint['userRole']})'),
                    _buildInfoTile(Icons.person_outline, 'Concerné',
                        '${complaint['target']} (${complaint['targetRole']})'),
                    _buildInfoTile(
                        Icons.calendar_today, 'Date', complaint['date']),
                    const SizedBox(height: 24),
                    if (complaint['status'] != 'resolved') ...[
                      _buildSectionTitle('Actions'),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: 'Marquer comme résolu',
                        backgroundColor: const Color(0xFF10B981),
                        onPressed: () {
                          AppLogger.info(
                              'Complaint resolved: ${complaint['id']}',
                              tag: 'ComplaintManagement');
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
                        text: 'En cours de traitement',
                        backgroundColor: const Color(0xFF3B82F6),
                        onPressed: () {
                          AppLogger.info(
                              'Complaint in progress: ${complaint['id']}',
                              tag: 'ComplaintManagement');
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F2937),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF3B82F6), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
          'Gestion des Plaintes',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF3B82F6)),
            onPressed: () {
              AppLogger.logUserAction('Filter complaints',
                  metadata: {'screen': 'ComplaintManagement'});
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _complaints.length,
        itemBuilder: (context, index) {
          final complaint = _complaints[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getPriorityColor(complaint['priority'])
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.report_problem,
                  color: _getPriorityColor(complaint['priority']),
                ),
              ),
              title: Text(
                complaint['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    'De: ${complaint['user']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor(complaint['status'])
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _getStatusLabel(complaint['status']),
                          style: TextStyle(
                            fontSize: 12,
                            color: _getStatusColor(complaint['status']),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        complaint['date'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showComplaintDetails(complaint),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return const Color(0xFFEF4444);
      case 'medium':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6B7280);
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'resolved':
        return const Color(0xFF10B981);
      case 'in_progress':
        return const Color(0xFF3B82F6);
      default:
        return const Color(0xFFF59E0B);
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'resolved':
        return 'Résolu';
      case 'in_progress':
        return 'En cours';
      default:
        return 'En attente';
    }
  }
}

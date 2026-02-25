import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'mobile_money';

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'mobile_money',
      'name': 'Mobile Money',
      'icon': Icons.phone_android,
      'color': Color(0xFF10B981),
      'description': 'MTN, Orange, Camtel',
    },
    {
      'id': 'credit_card',
      'name': 'Carte de crédit',
      'icon': Icons.credit_card,
      'color': Color(0xFF3B82F6),
      'description': 'Visa, Mastercard',
    },
    {
      'id': 'bank_transfer',
      'name': 'Virement bancaire',
      'icon': Icons.account_balance,
      'color': Color(0xFF8B5CF6),
      'description': 'Transfert direct',
    },
  ];

  final List<Map<String, dynamic>> _recentTransactions = [
    {
      'id': '1',
      'title': 'Trajet Yaoundé - Douala',
      'amount': '-5,000 FCFA',
      'date': 'Aujourd\'hui',
      'time': '14:30',
      'type': 'payment',
      'status': 'completed',
    },
    {
      'id': '2',
      'title': 'Recharge de compte',
      'amount': '+10,000 FCFA',
      'date': 'Hier',
      'time': '10:15',
      'type': 'deposit',
      'status': 'completed',
    },
    {
      'id': '3',
      'title': 'Trajet Douala - Bafoussam',
      'amount': '-3,500 FCFA',
      'date': '12 Fév',
      'time': '08:45',
      'type': 'payment',
      'status': 'completed',
    },
    {
      'id': '4',
      'title': 'Bonus de parrainage',
      'amount': '+2,000 FCFA',
      'date': '10 Fév',
      'time': '16:20',
      'type': 'bonus',
      'status': 'completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Paiement',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(5),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Solde disponible',
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '25,500 FCFA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showAddMoneyDialog(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF3B82F6),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Ajouter des fonds',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _showWithdrawDialog(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Retirer',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Payment Methods
            const Text(
              'Méthodes de paiement',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),
            ..._paymentMethods.map((method) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _selectedPaymentMethod == method['id']
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFFE5E7EB),
                      width: _selectedPaymentMethod == method['id'] ? 2 : 1,
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: method['color'].withAlpha(20),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        method['icon'],
                        color: method['color'],
                        size: 20,
                      ),
                    ),
                    title: Text(
                      method['name'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    subtitle: Text(
                      method['description'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: Icon(
                      _selectedPaymentMethod == method['id']
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: const Color(0xFF3B82F6),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = method['id'];
                      });
                    },
                  ),
                )),
            const SizedBox(height: 24),

            // Recent Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transactions récentes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/transaction-history');
                  },
                  child: const Text(
                    'Voir tout',
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._recentTransactions.map((transaction) => Container(
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
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: transaction['type'] == 'payment'
                              ? const Color(0xFFFEE2E2)
                              : transaction['type'] == 'deposit'
                                  ? const Color(0xFFD1FAE5)
                                  : const Color(0xFFDBEAFE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          transaction['type'] == 'payment'
                              ? Icons.arrow_upward
                              : transaction['type'] == 'deposit'
                                  ? Icons.arrow_downward
                                  : Icons.card_giftcard,
                          color: transaction['type'] == 'payment'
                              ? const Color(0xFFEF4444)
                              : transaction['type'] == 'deposit'
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFF3B82F6),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction['title'],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${transaction['date']} • ${transaction['time']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        transaction['amount'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: transaction['amount'].startsWith('+')
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 2),
    );
  }

  void _showAddMoneyDialog() {
    final amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter des fonds'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Montant (FCFA)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixText: 'FCFA ',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Le montant sera ajouté à votre solde via la méthode de paiement sélectionnée.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Demande de paiement envoyée'),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  void _showWithdrawDialog() {
    final amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Retirer des fonds'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Montant (FCFA)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixText: 'FCFA ',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Les fonds seront transférés vers votre compte bancaire ou mobile money.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Demande de retrait envoyée'),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/ride_provider.dart';
import '../../core/utils/app_logger.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';

class CreateRideScreen extends StatefulWidget {
  const CreateRideScreen({super.key});

  @override
  State<CreateRideScreen> createState() => _CreateRideScreenState();
}

class _CreateRideScreenState extends State<CreateRideScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _priceController = TextEditingController();
  final _seatsController = TextEditingController(text: '3');
  final _carModelController = TextEditingController();
  final _carColorController = TextEditingController();
  final _plateNumberController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _priceController.dispose();
    _seatsController.dispose();
    _carModelController.dispose();
    _carColorController.dispose();
    _plateNumberController.dispose();
    super.dispose();
  }

  Future<void> _createRide() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final rideProvider = Provider.of<RideProvider>(context, listen: false);
      final success = await rideProvider.createRide(
        from: _fromController.text,
        to: _toController.text,
        date: _dateController.text,
        time: _timeController.text,
        price: _priceController.text,
        totalSeats: int.parse(_seatsController.text),
        carModel: _carModelController.text,
        carColor: _carColorController.text,
        plateNumber: _plateNumberController.text,
      );

      if (success && mounted) {
        AppLogger.info('Ride created successfully', tag: 'CreateRide');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Trajet créé avec succès!'),
            backgroundColor: Color(0xFF10B981),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      AppLogger.error('Error creating ride', tag: 'CreateRide', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${e.toString()}'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
          'Proposer un Trajet',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
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
                      'Nouveau trajet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Remplissez les informations pour proposer votre trajet',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Itinéraire'),
              const SizedBox(height: 12),
              CustomInput(
                controller: _fromController,
                hintText: 'Lieu de départ',
                prefix: Icons.location_on,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Champ requis' : null,
              ),
              const SizedBox(height: 12),
              CustomInput(
                controller: _toController,
                hintText: 'Destination',
                prefix: Icons.location_on_outlined,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Champ requis' : null,
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Date et Heure'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      controller: _dateController,
                      hintText: 'Date',
                      prefix: Icons.calendar_today,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Champ requis' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomInput(
                      controller: _timeController,
                      hintText: 'Heure',
                      prefix: Icons.access_time,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Champ requis' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Détails du Trajet'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      controller: _priceController,
                      hintText: 'Prix (FCFA)',
                      prefix: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Champ requis' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomInput(
                      controller: _seatsController,
                      hintText: 'Places',
                      prefix: Icons.event_seat,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Champ requis' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Informations du Véhicule'),
              const SizedBox(height: 12),
              CustomInput(
                controller: _carModelController,
                hintText: 'Modèle du véhicule',
                prefix: Icons.directions_car,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Champ requis' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      controller: _carColorController,
                      hintText: 'Couleur',
                      prefix: Icons.color_lens,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Champ requis' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomInput(
                      controller: _plateNumberController,
                      hintText: 'Plaque',
                      prefix: Icons.confirmation_number,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Champ requis' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Créer le trajet',
                isLoading: _isLoading,
                onPressed: _createRide,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F2937),
      ),
    );
  }
}

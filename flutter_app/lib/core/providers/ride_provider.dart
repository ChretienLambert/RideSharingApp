import 'package:flutter/foundation.dart';

class Ride {
  final String id;
  final String driverId;
  final String driverName;
  final String driverRating;
  final String from;
  final String to;
  final String date;
  final String time;
  final String price;
  final int availableSeats;
  final int totalSeats;
  final String carModel;
  final String carColor;
  final String plateNumber;

  Ride({
    required this.id,
    required this.driverId,
    required this.driverName,
    required this.driverRating,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.price,
    required this.availableSeats,
    required this.totalSeats,
    required this.carModel,
    required this.carColor,
    required this.plateNumber,
  });
}

class RideRequest {
  final String id;
  final String passengerId;
  final String passengerName;
  final String rideId;
  final String from;
  final String to;
  final String requestedAt;
  final int seatsRequested;
  final String status; // pending, accepted, rejected

  RideRequest({
    required this.id,
    required this.passengerId,
    required this.passengerName,
    required this.rideId,
    required this.from,
    required this.to,
    required this.requestedAt,
    required this.seatsRequested,
    required this.status,
  });
}

class RideProvider extends ChangeNotifier {
  List<Ride> _availableRides = [];
  List<Ride> _myRides = [];
  List<RideRequest> _rideRequests = [];
  List<Ride> _scheduledRides = [];
  Ride? _currentRide;
  bool _isLoading = false;

  // Getters
  List<Ride> get availableRides => _availableRides;
  List<Ride> get myRides => _myRides;
  List<RideRequest> get rideRequests => _rideRequests;
  List<Ride> get scheduledRides => _scheduledRides;
  Ride? get currentRide => _currentRide;
  bool get isLoading => _isLoading;

  // Setters
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setCurrentRide(Ride? ride) {
    _currentRide = ride;
    notifyListeners();
  }

  // Fetch available rides
  Future<void> fetchAvailableRides() async {
    setLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 1));

      _availableRides = [
        Ride(
          id: '1',
          driverId: 'driver1',
          driverName: 'Jean Kamga',
          driverRating: '4.8',
          from: 'Yaoundé Centre',
          to: 'Douala Akwa',
          date: '28 Jan 2026',
          time: '08:00',
          price: '5,000 FCFA',
          availableSeats: 2,
          totalSeats: 4,
          carModel: 'Toyota Camry',
          carColor: 'Noir',
          plateNumber: 'CE 1234 AB',
        ),
        Ride(
          id: '2',
          driverId: 'driver2',
          driverName: 'Marie Ngo',
          driverRating: '5.0',
          from: 'Douala Bonaberi',
          to: 'Bafoussam',
          date: '28 Jan 2026',
          time: '10:30',
          price: '3,500 FCFA',
          availableSeats: 1,
          totalSeats: 3,
          carModel: 'Honda Civic',
          carColor: 'Blanc',
          plateNumber: 'LT 5678 CD',
        ),
      ];
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching available rides: $e');
    } finally {
      setLoading(false);
    }
  }

  // Fetch my rides
  Future<List<Ride>> fetchMyRides(String userId) async {
    setLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 1));

      _myRides = [
        Ride(
          id: '3',
          driverId: 'driver1',
          driverName: 'Jean Kamga',
          driverRating: '4.8',
          from: 'Yaoundé Centre',
          to: 'Douala Akwa',
          date: '15 Jan 2026',
          time: '14:00',
          price: '5,000 FCFA',
          availableSeats: 0,
          totalSeats: 4,
          carModel: 'Toyota Camry',
          carColor: 'Noir',
          plateNumber: 'CE 1234 AB',
        ),
      ];
      notifyListeners();
      return _myRides;
    } catch (e) {
      debugPrint('Error fetching my rides: $e');
      return [];
    } finally {
      setLoading(false);
    }
  }

  // Fetch ride requests (for drivers)
  Future<List<RideRequest>> fetchRideRequests(String driverId) async {
    setLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 1));

      final mockRequests = [
        RideRequest(
          id: '1',
          passengerId: 'p1',
          passengerName: 'Alice Johnson',
          rideId: 'r1',
          from: 'Douala, Akwa',
          to: 'Yaoundé, Ngoa-Ekelle',
          requestedAt: 'Il y a 2 heures',
          seatsRequested: 2,
          status: 'pending',
        ),
        RideRequest(
          id: '2',
          passengerId: 'p2',
          passengerName: 'Bob Smith',
          rideId: 'r2',
          from: 'Yaoundé, Mokolo',
          to: 'Douala, Bonaberi',
          requestedAt: 'Il y a 5 heures',
          seatsRequested: 1,
          status: 'pending',
        ),
      ];

      _rideRequests = mockRequests;
      notifyListeners();
      return _rideRequests;
    } catch (e) {
      print('Error fetching ride requests: $e');
      return [];
    } finally {
      setLoading(false);
    }
  }

  // Fetch scheduled rides
  Future<void> fetchScheduledRides(String userId) async {
    setLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 1));

      _scheduledRides = [
        Ride(
          id: '4',
          driverId: 'driver3',
          driverName: 'Pierre Etoundi',
          driverRating: '4.9',
          from: 'Yaoundé Mokolo',
          to: 'Douala Bepanda',
          date: 'Lundi-Vendredi',
          time: '07:00',
          price: '4,500 FCFA',
          availableSeats: 3,
          totalSeats: 4,
          carModel: 'Nissan Almera',
          carColor: 'Gris',
          plateNumber: 'NW 9012 EF',
        ),
      ];
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching scheduled rides: $e');
    } finally {
      setLoading(false);
    }
  }

  // Create a new ride (for drivers)
  Future<bool> createRide({
    required String from,
    required String to,
    required String date,
    required String time,
    required String price,
    required int totalSeats,
    required String carModel,
    required String carColor,
    required String plateNumber,
  }) async {
    setLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 2));

      final newRide = Ride(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        driverId: 'current_driver',
        driverName: 'Current Driver',
        driverRating: '4.7',
        from: from,
        to: to,
        date: date,
        time: time,
        price: price,
        availableSeats: totalSeats,
        totalSeats: totalSeats,
        carModel: carModel,
        carColor: carColor,
        plateNumber: plateNumber,
      );

      _myRides.insert(0, newRide);
      notifyListeners();

      return true;
    } catch (e) {
      debugPrint('Error creating ride: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  // Book a ride (for passengers)
  Future<bool> bookRide(String rideId, int seatsRequested) async {
    setLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 2));

      final rideIndex = _availableRides.indexWhere((ride) => ride.id == rideId);
      if (rideIndex != -1) {
        final ride = _availableRides[rideIndex];
        _availableRides[rideIndex] = Ride(
          id: ride.id,
          driverId: ride.driverId,
          driverName: ride.driverName,
          driverRating: ride.driverRating,
          from: ride.from,
          to: ride.to,
          date: ride.date,
          time: ride.time,
          price: ride.price,
          availableSeats: ride.availableSeats - seatsRequested,
          totalSeats: ride.totalSeats,
          carModel: ride.carModel,
          carColor: ride.carColor,
          plateNumber: ride.plateNumber,
        );

        _myRides.insert(0, ride);
        notifyListeners();

        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error booking ride: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  // Accept ride request (for drivers)
  Future<bool> acceptRideRequest(String requestId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final requestIndex =
          _rideRequests.indexWhere((req) => req.id == requestId);
      if (requestIndex != -1) {
        _rideRequests[requestIndex] = RideRequest(
          id: _rideRequests[requestIndex].id,
          passengerId: _rideRequests[requestIndex].passengerId,
          passengerName: _rideRequests[requestIndex].passengerName,
          rideId: _rideRequests[requestIndex].rideId,
          from: _rideRequests[requestIndex].from,
          to: _rideRequests[requestIndex].to,
          requestedAt: _rideRequests[requestIndex].requestedAt,
          seatsRequested: _rideRequests[requestIndex].seatsRequested,
          status: 'accepted',
        );
        notifyListeners();

        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error accepting ride request: $e');
      return false;
    }
  }

  // Reject ride request (for drivers)
  Future<bool> rejectRideRequest(String requestId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final requestIndex =
          _rideRequests.indexWhere((req) => req.id == requestId);
      if (requestIndex != -1) {
        _rideRequests[requestIndex] = RideRequest(
          id: _rideRequests[requestIndex].id,
          passengerId: _rideRequests[requestIndex].passengerId,
          passengerName: _rideRequests[requestIndex].passengerName,
          rideId: _rideRequests[requestIndex].rideId,
          from: _rideRequests[requestIndex].from,
          to: _rideRequests[requestIndex].to,
          requestedAt: _rideRequests[requestIndex].requestedAt,
          seatsRequested: _rideRequests[requestIndex].seatsRequested,
          status: 'rejected',
        );
        notifyListeners();

        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error rejecting ride request: $e');
      return false;
    }
  }
}

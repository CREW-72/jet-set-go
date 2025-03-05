import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';


class FlightTrackingPage extends StatefulWidget {
  const FlightTrackingPage({Key? key}) : super(key: key);

  @override
  _FlightTrackingPageState createState() => _FlightTrackingPageState();
}

class _FlightTrackingPageState extends State<FlightTrackingPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  Flight? _flight;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _searchFlight(String flightNumber) async {
    if (flightNumber.isEmpty) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Please enter a flight number';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });

    try {
      // Simulate API call with a delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock flight data - in a real app, this would be fetched from an API
      final mockFlight = Flight(
        flightNumber: flightNumber,
        airline: Airline(
          code: 'UA',
          name: 'United Airlines',
          logo: 'https://example.com/united-logo.png',
        ),
        origin: Airport(
          code: 'SFO',
          name: 'San Francisco International Airport',
          city: 'San Francisco',
          terminal: 'Terminal 3',
          gate: 'G12',
        ),
        destination: Airport(
          code: 'JFK',
          name: 'John F. Kennedy International Airport',
          city: 'New York',
          terminal: 'Terminal 4',
          gate: 'B8',
        ),
        departure: FlightTime(
          scheduled: DateTime.now().subtract(const Duration(hours: 1)),
          actual: DateTime.now().subtract(const Duration(minutes: 45)),
        ),
        arrival: FlightTime(
          scheduled: DateTime.now().add(const Duration(hours: 4)),
          estimated: DateTime.now().add(const Duration(hours: 4, minutes: 15)),
        ),
        status: FlightStatus.inAir,
        delayMinutes: 15,
        aircraft: Aircraft(
          registration: 'N12345',
          model: 'Boeing 787-9',
        ),
        events: [
          FlightEvent(
            type: EventType.checkIn,
            time: DateTime.now().subtract(const Duration(hours: 3)),
            completed: true,
          ),
          FlightEvent(
            type: EventType.security,
            time: DateTime.now().subtract(const Duration(hours: 2)),
            completed: true,
          ),
          FlightEvent(
            type: EventType.boarding,
            time: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
            completed: true,
          ),
          FlightEvent(
            type: EventType.departure,
            time: DateTime.now().subtract(const Duration(minutes: 45)),
            completed: true,
          ),
          FlightEvent(
            type: EventType.arrival,
            time: DateTime.now().add(const Duration(hours: 4, minutes: 15)),
            completed: false,
          ),
        ],
        progressPercent: 0.25,
      );

      setState(() {
        _flight = mockFlight;
        _isLoading = false;
      });


      // Set up periodic refresh
      _refreshTimer?.cancel();
      _refreshTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
        _refreshFlightData();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'Failed to fetch flight data. Please try again.';
      });
    }
  }

  Future<void> _refreshFlightData() async {
    if (_flight == null) return;

    try {
      // In a real app, this would refresh data from the API
      // For demo purposes, we'll just update the progress
    } catch (e) {
      // Handle refresh error silently
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.grey[900] : Colors.grey[50];
    final cardColor = isDarkMode ? Colors.grey[800] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Flight Tracker'),
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        foregroundColor: textColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (_flight != null) {
            await _refreshFlightData();
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: subtitleColor),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Enter flight number (e.g., UA123)',
                              hintStyle: TextStyle(color: subtitleColor),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: textColor),
                            onSubmitted: _searchFlight,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          color: Theme.of(context).primaryColor,
                          onPressed: () => _searchFlight(_searchController.text),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Error Message
                if (_hasError)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Loading Shimmer
                if (_isLoading) _buildLoadingShimmer(cardColor),

                // Flight Information
                if (!_isLoading && _flight != null) ...[
                  _buildFlightHeader(_flight!, textColor, subtitleColor),
                  const SizedBox(height: 24),
                  _buildFlightRoute(_flight!, textColor, subtitleColor, cardColor),
                  const SizedBox(height: 24),
                  _buildFlightTimeline(_flight!, textColor, subtitleColor, cardColor),
                  const SizedBox(height: 24),
                  _buildFlightDetails(_flight!, textColor, subtitleColor, cardColor),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer(Color? cardColor) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightHeader(Flight flight, Color textColor, Color? subtitleColor) {
    Color statusColor;
    switch (flight.status) {
      case FlightStatus.onTime:
        statusColor = Colors.green;
        break;
      case FlightStatus.delayed:
        statusColor = flight.delayMinutes! > 60 ? Colors.red : Colors.orange;
        break;
      case FlightStatus.boarding:
        statusColor = Colors.green;
        break;
      case FlightStatus.departed:
      case FlightStatus.inAir:
        statusColor = Colors.blue;
        break;
      case FlightStatus.arrived:
        statusColor = Colors.green;
        break;
      case FlightStatus.cancelled:
        statusColor = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 24,
            child: Text(
              flight.airline.code,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${flight.airline.name} ${flight.flightNumber}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${flight.origin.city} to ${flight.destination.city}',
                  style: TextStyle(
                    color: subtitleColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getStatusIcon(flight.status),
                  size: 16,
                  color: statusColor,
                ),
                const SizedBox(width: 4),
                Text(
                  _getStatusText(flight.status),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightRoute(Flight flight, Color textColor, Color? subtitleColor, Color? cardColor) {
    final timeFormat = DateFormat('HH:mm');
    final dateFormat = DateFormat('EEE, MMM d');

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      flight.origin.code,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      flight.origin.city,
                      style: TextStyle(
                        fontSize: 16,
                        color: subtitleColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      timeFormat.format(flight.departure.actual ?? flight.departure.scheduled),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateFormat.format(flight.departure.scheduled),
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitleColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Gate ${flight.origin.gate}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(
                    Icons.flight_takeoff,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 1,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.flight_land,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      flight.destination.code,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      flight.destination.city,
                      style: TextStyle(
                        fontSize: 16,
                        color: subtitleColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      timeFormat.format(flight.arrival.estimated ?? flight.arrival.scheduled),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateFormat.format(flight.arrival.scheduled),
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitleColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Gate ${flight.destination.gate}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (flight.delayMinutes != null && flight.delayMinutes! > 0) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Flight is delayed by ${flight.delayMinutes} minutes',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }


  Widget _buildProgressStat(String label, String value, IconData icon, Color textColor, Color? subtitleColor) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: subtitleColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFlightTimeline(Flight flight, Color textColor, Color? subtitleColor, Color? cardColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flight Timeline',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 24),
          ...flight.events.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            final isLast = index == flight.events.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: event.completed
                            ? Theme.of(context).primaryColor
                            : Colors.grey.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: event.completed
                          ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      )
                          : null,
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 40,
                        color: event.completed
                            ? Theme.of(context).primaryColor
                            : Colors.grey.withOpacity(0.3),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getEventTypeText(event.type),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('HH:mm, MMM d').format(event.time),
                        style: TextStyle(
                          color: subtitleColor,
                        ),
                      ),
                      if (!isLast) const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFlightDetails(Flight flight, Color textColor, Color? subtitleColor, Color? cardColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flight Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Airline', flight.airline.name, textColor, subtitleColor),
          _buildDetailRow('Flight', flight.flightNumber, textColor, subtitleColor),
          if (flight.aircraft != null) ...[
            _buildDetailRow('Aircraft', flight.aircraft!.model, textColor, subtitleColor),
            _buildDetailRow('Registration', flight.aircraft!.registration, textColor, subtitleColor),
          ],
          _buildDetailRow('Origin Terminal', flight.origin.terminal ?? 'N/A', textColor, subtitleColor),
          _buildDetailRow('Destination Terminal', flight.destination.terminal ?? 'N/A', textColor, subtitleColor),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, Color textColor, Color? subtitleColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: subtitleColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(FlightStatus status) {
    switch (status) {
      case FlightStatus.onTime:
        return Icons.check_circle;
      case FlightStatus.delayed:
        return Icons.access_time;
      case FlightStatus.boarding:
        return Icons.airline_seat_recline_normal;
      case FlightStatus.departed:
        return Icons.flight_takeoff;
      case FlightStatus.inAir:
        return Icons.flight;
      case FlightStatus.arrived:
        return Icons.flight_land;
      case FlightStatus.cancelled:
        return Icons.cancel;
    }
  }

  String _getStatusText(FlightStatus status) {
    switch (status) {
      case FlightStatus.onTime:
        return 'On Time';
      case FlightStatus.delayed:
        return 'Delayed';
      case FlightStatus.boarding:
        return 'Boarding';
      case FlightStatus.departed:
        return 'Departed';
      case FlightStatus.inAir:
        return 'In Air';
      case FlightStatus.arrived:
        return 'Arrived';
      case FlightStatus.cancelled:
        return 'Cancelled';
    }
  }

  String _getEventTypeText(EventType type) {
    switch (type) {
      case EventType.checkIn:
        return 'Check-in';
      case EventType.security:
        return 'Security Check';
      case EventType.boarding:
        return 'Boarding';
      case EventType.departure:
        return 'Departure';
      case EventType.arrival:
        return 'Arrival';
    }
  }
}

// Models
enum FlightStatus {
  onTime,
  delayed,
  boarding,
  departed,
  inAir,
  arrived,
  cancelled,
}

enum EventType {
  checkIn,
  security,
  boarding,
  departure,
  arrival,
}

class Airline {
  final String code;
  final String name;
  final String? logo;

  Airline({
    required this.code,
    required this.name,
    this.logo,
  });
}

class Airport {
  final String code;
  final String name;
  final String city;
  final String? terminal;
  final String? gate;

  Airport({
    required this.code,
    required this.name,
    required this.city,
    this.terminal,
    this.gate,
  });
}

class FlightTime {
  final DateTime scheduled;
  final DateTime? actual;
  final DateTime? estimated;

  FlightTime({
    required this.scheduled,
    this.actual,
    this.estimated,
  });
}

class Aircraft {
  final String registration;
  final String model;

  Aircraft({
    required this.registration,
    required this.model,
  });
}

class FlightEvent {
  final EventType type;
  final DateTime time;
  final bool completed;

  FlightEvent({
    required this.type,
    required this.time,
    required this.completed,
  });
}

class Flight {
  final String flightNumber;
  final Airline airline;
  final Airport origin;
  final Airport destination;
  final FlightTime departure;
  final FlightTime arrival;
  final FlightStatus status;
  final int? delayMinutes;
  final Aircraft? aircraft;
  final List<FlightEvent> events;
  final double progressPercent;

  Flight({
    required this.flightNumber,
    required this.airline,
    required this.origin,
    required this.destination,
    required this.departure,
    required this.arrival,
    required this.status,
    this.delayMinutes,
    this.aircraft,
    required this.events,
    required this.progressPercent,
  });

  Flight copyWith({
    String? flightNumber,
    Airline? airline,
    Airport? origin,
    Airport? destination,
    FlightTime? departure,
    FlightTime? arrival,
    FlightStatus? status,
    int? delayMinutes,
    Aircraft? aircraft,
    List<FlightEvent>? events,
    double? progressPercent,
  }) {
    return Flight(
      flightNumber: flightNumber ?? this.flightNumber,
      airline: airline ?? this.airline,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival,
      status: status ?? this.status,
      delayMinutes: delayMinutes ?? this.delayMinutes,
      aircraft: aircraft ?? this.aircraft,
      events: events ?? this.events,
      progressPercent: progressPercent ?? this.progressPercent,
    );
  }
}
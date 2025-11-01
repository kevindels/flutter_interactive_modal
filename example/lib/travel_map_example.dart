import 'package:flutter/material.dart';
import 'package:interactive_modal/interactive_modal.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';

// Color palette
class AppColors {
  static const Color primary = Color(0xFF2D545E); // Fondo, encabezados
  static const Color secondary = Color(0xFFC4DFE6); // Elementos de apoyo
  static const Color accent = Color(0xFF66A5AD); // Botones, acentos
  static const Color background = Color(0xFFFAF3DE); // Fondo principal, texto
}

/// Example similar to the FmapsTravelMap functionality
class TravelMapExample extends StatefulWidget {
  const TravelMapExample({super.key});

  @override
  State<TravelMapExample> createState() => _TravelMapExampleState();
}

class _TravelMapExampleState extends State<TravelMapExample> {
  final InteractiveModalController _modalController =
      InteractiveModalController();

  // Simulated travel data
  final List<TravelPoint> _travelPoints = [];
  int _currentIndex = 0;
  bool _isPlaying = false;
  Timer? _playTimer;
  String _selectedSpeed = '1x';
  final List<String> _speedOptions = ['0.5x', '1x', '2x', '4x', '8x'];
  final ScrollController _scrollController = ScrollController();

  // Map controller
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _generateSampleTravelData();
  }

  void _generateSampleTravelData() {
    // Generate 50 sample travel points
    for (int i = 0; i < 50; i++) {
      _travelPoints.add(
        TravelPoint(
          id: i,
          date: DateTime.now().subtract(Duration(minutes: 50 - i)),
          speed: (i % 3 == 0) ? 0 : 40 + (i % 30),
          latitude: 10.4634 + (i * 0.001),
          longitude: -66.6057 + (i * 0.001),
          hasAlarm: i % 10 == 0,
          alarmName: i % 10 == 0 ? 'Velocidad excedida' : null,
        ),
      );
    }
  }

  void _playAnimation() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      final duration = _getDurationFromSpeed(_selectedSpeed);
      _playTimer = Timer.periodic(duration, (timer) {
        if (_currentIndex < _travelPoints.length - 1) {
          setState(() {
            _currentIndex++;
            _updateMapPosition(_travelPoints[_currentIndex]);
          });
          _scrollToCurrentItem();
        } else {
          _stopAnimation();
        }
      });
    } else {
      _playTimer?.cancel();
    }
  }

  Duration _getDurationFromSpeed(String speed) {
    switch (speed) {
      case '0.5x':
        return const Duration(milliseconds: 2000);
      case '1x':
        return const Duration(milliseconds: 1000);
      case '2x':
        return const Duration(milliseconds: 500);
      case '4x':
        return const Duration(milliseconds: 250);
      case '8x':
        return const Duration(milliseconds: 125);
      default:
        return const Duration(milliseconds: 1000);
    }
  }

  void _stopAnimation() {
    setState(() {
      _isPlaying = false;
    });
    _playTimer?.cancel();
  }

  void _resetAnimation() {
    _stopAnimation();
    setState(() {
      _currentIndex = 0;
      _updateMapPosition(_travelPoints[0]);
    });
    _scrollToCurrentItem();
  }

  void _updateMapPosition(TravelPoint point) {
    _mapController.move(
      LatLng(point.latitude, point.longitude),
      _mapController.camera.zoom,
    );
  }

  void _scrollToCurrentItem() {
    if (_scrollController.hasClients) {
      final position = _currentIndex * 100.0;
      _scrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSliderChanged(double value) {
    setState(() {
      _currentIndex = value.toInt();
      _updateMapPosition(_travelPoints[_currentIndex]);
    });
    _scrollToCurrentItem();
  }

  void _onListItemTap(int index) {
    _stopAnimation();
    setState(() {
      _currentIndex = index;
      _updateMapPosition(_travelPoints[index]);
    });
  }

  @override
  void dispose() {
    _playTimer?.cancel();
    _scrollController.dispose();
    _modalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Map Example'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: InteractiveModal(
        controller: _modalController,
        background: _buildMapWidget(),
        modalContent: _buildModalContent(),
        position: ModalPosition.bottom,
        animate: true,
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _modalController,
        builder: (context, child) => _buildFloatingButtons(),
      ),
    );
  }

  Widget _buildMapWidget() {
    if (_travelPoints.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Build list of polyline points
    final List<LatLng> polylinePoints = _travelPoints
        .take(_currentIndex + 1)
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: LatLng(
              _travelPoints[0].latitude,
              _travelPoints[0].longitude,
            ),
            initialZoom: 16.0,
            minZoom: 5.0,
            maxZoom: 18.0,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
              subdomains: const ['a', 'b', 'c', 'd'],
              userAgentPackageName: 'dev.example.interactive_modal_example',
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: polylinePoints,
                  strokeWidth: 4.0,
                  color: AppColors.accent,
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                // Current position marker
                if (_currentIndex < _travelPoints.length)
                  Marker(
                    point: LatLng(
                      _travelPoints[_currentIndex].latitude,
                      _travelPoints[_currentIndex].longitude,
                    ),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
              ],
            ),
          ],
        ),
        // Zoom controls
        Positioned(
          top: 20,
          left: 20,
          child: Column(
            children: [
              FloatingActionButton(
                mini: true,
                heroTag: 'zoom_in',
                onPressed: () {
                  final currentZoom = _mapController.camera.zoom;
                  _mapController.move(
                    _mapController.camera.center,
                    currentZoom + 1,
                  );
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                mini: true,
                heroTag: 'zoom_out',
                onPressed: () {
                  final currentZoom = _mapController.camera.zoom;
                  _mapController.move(
                    _mapController.camera.center,
                    currentZoom - 1,
                  );
                },
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingButtons() {
    if (_modalController.isVisible) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'play',
          onPressed: () {
            _modalController.toggle();
          },
          child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
        ),
      ],
    );
  }

  Widget _buildModalContent() {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recorrido Animado',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _modalController.hide();
                    },
                  ),
                ],
              ),
              // Controls row
              Row(
                children: [
                  const Text('Velocidad: '),
                  DropdownButton<String>(
                    value: _selectedSpeed,
                    items: _speedOptions.map((String speed) {
                      return DropdownMenuItem<String>(
                        value: speed,
                        child: Text(speed),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedSpeed = newValue;
                        });
                        if (_isPlaying) {
                          _playAnimation(); // Restart with new speed
                          _playAnimation();
                        }
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: _playAnimation,
                    color: AppColors.accent,
                  ),
                  Expanded(
                    child: Slider(
                      value: _currentIndex.toDouble(),
                      min: 0,
                      max: _travelPoints.isEmpty
                          ? 1
                          : (_travelPoints.length - 1).toDouble(),
                      onChanged: _onSliderChanged,
                      activeColor: AppColors.accent,
                      inactiveColor: AppColors.secondary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _resetAnimation,
                  ),
                ],
              ),
            ],
          ),
        ),
        // List of travel points
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _travelPoints.length,
            itemBuilder: (context, index) {
              final point = _travelPoints[index];
              final isSelected = index == _currentIndex;

              return Container(
                color: isSelected ? AppColors.secondary.withValues() : null,
                child: ListTile(
                  leading: Icon(
                    point.speed == 0 ? Icons.location_on : Icons.local_shipping,
                    color: point.speed == 0 ? Colors.red : AppColors.accent,
                  ),
                  title: Text(
                    '${_formatDate(point.date)}, ${point.speed} km/h',
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: point.hasAlarm
                      ? Text(
                          point.alarmName ?? '',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                  trailing: point.hasAlarm
                      ? const Icon(Icons.warning, color: Colors.red)
                      : null,
                  onTap: () => _onListItemTap(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

/// Model for a travel point
class TravelPoint {
  final int id;
  final DateTime date;
  final int speed;
  final double latitude;
  final double longitude;
  final bool hasAlarm;
  final String? alarmName;

  TravelPoint({
    required this.id,
    required this.date,
    required this.speed,
    required this.latitude,
    required this.longitude,
    required this.hasAlarm,
    this.alarmName,
  });
}

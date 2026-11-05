import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_colors.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import 'package:trash2treasure/screens/auth/submit_id_screen.dart';

import 'package:trash2treasure/core/app_session.dart';
import 'package:trash2treasure/services/api_service.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});
  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final MapController _mapController = MapController();
  LatLng _pos = const LatLng(33.6844, 73.0479);
  bool _loading = true;

  bool _hasRealLocation = false;

  @override
  void initState() {
    super.initState();
    _getRealLocation();
  }

  Future<void> _getRealLocation() async {
    try {
      // Check whether phone location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        if (mounted) {
          setState(() => _loading = false);
        }
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (mounted) {
          setState(() => _loading = false);
        }
        return;
      }

      // Get actual device location
      Position p = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );

      if (!mounted) return;

      setState(() {
        _pos = LatLng(p.latitude, p.longitude);
        _hasRealLocation = true;
        _loading = false;
      });

      // Do not move the map controller here.
      // The map has not necessarily been initialized yet.
    } catch (e) {
      debugPrint("Location error: $e");

      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _goToSubmitId() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SubmitIdScreen()),
    );
  }

  Future<void> _saveLocationAndContinue() async {
    final token = AppSession.authToken;

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please sign in again."),
        ),
      );
      return;
    }

    if (!_hasRealLocation) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please allow location access first."),
        ),
      );
      return;
    }

    try {
      await ApiService.updateLocation(
        latitude: _pos.latitude,
        longitude: _pos.longitude,
        token: token,
      );

      if (!mounted) return;

      _goToSubmitId();
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(16),
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Set Your Location",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Allow location access to find\nnearby materials.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8A8A8A),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFEAEAEA)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF1F7A3A),
                              strokeWidth: 2,
                            ),
                          )
                        : FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                              initialCenter: _pos,
                              initialZoom: 15,

                              // Move the map only after it is initialized.
                              onMapReady: () {
                                _mapController.move(_pos, 15);
                              },

                              interactionOptions: const InteractionOptions(
                                flags: InteractiveFlag.all,
                              ),
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName:
                                    'com.example.trash2treasure',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: _pos,
                                    width: 40,
                                    height: 40,
                                    child: const Icon(
                                      Icons.location_pin,
                                      color: Color(0xFF3A86FF),
                                      size: 36,
                                    ),
                                  ),
                                  Marker(
                                    point: LatLng(
                                      _pos.latitude + 0.008,
                                      _pos.longitude + 0.008,
                                    ),
                                    width: 40,
                                    height: 40,
                                    child: const Icon(
                                      Icons.location_pin,
                                      color: Color(0xFF1F7A3A),
                                      size: 36,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed:
                        _saveLocationAndContinue, // <-- EDITED: Now goes to next screen
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F7A3A),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Allow Location",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: OutlinedButton(
                    onPressed:
                        _goToSubmitId, // <-- EDITED: Now goes to next screen
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5F5F5),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Enter Manually",
                      style: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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

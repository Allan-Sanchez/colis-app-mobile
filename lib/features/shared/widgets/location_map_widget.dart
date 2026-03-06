import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';

class LocationMapWidget extends StatefulWidget {
  final String? address;
  final String? latitude;
  final String? longitude;

  const LocationMapWidget({
    super.key,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<LocationMapWidget> createState() => _LocationMapWidgetState();
}

class _LocationMapWidgetState extends State<LocationMapWidget> {
  GoogleMapController? _controller;
  bool _mapError = false;

  double? get _lat => double.tryParse(widget.latitude ?? '');
  double? get _lng => double.tryParse(widget.longitude ?? '');
  bool get _hasCoords => _lat != null && _lng != null;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildMap() {
    try {
      return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(_lat!, _lng!),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('location'),
            position: LatLng(_lat!, _lng!),
            infoWindow: InfoWindow(
              title: widget.address ?? 'Ubicación',
            ),
          ),
        },
        onMapCreated: (c) => _controller = c,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        compassEnabled: false,
        rotateGesturesEnabled: false,
        scrollGesturesEnabled: false,
        tiltGesturesEnabled: false,
        zoomGesturesEnabled: false,
      );
    } catch (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _mapError = true);
      });
      return _MapPlaceholder();
    }
  }

  Future<void> _openInMaps() async {
    if (!_hasCoords) return;
    final uri = Uri.parse('geo:$_lat,$_lng?q=$_lat,$_lng');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback a Google Maps web
      final webUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$_lat,$_lng',
      );
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mapa o placeholder
          SizedBox(
            height: 160,
            child: _hasCoords && !_mapError
                ? _buildMap()
                : _MapPlaceholder(),
          ),
          // Dirección + botón
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.primary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.address ?? 'Sin dirección',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (_hasCoords)
                  GestureDetector(
                    onTap: _openInMaps,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.directions_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Cómo llegar',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F5F9),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off_rounded,
              size: 36,
              color: Color(0xFFCBD5E1),
            ),
            SizedBox(height: 8),
            Text(
              'Ubicación no disponible',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

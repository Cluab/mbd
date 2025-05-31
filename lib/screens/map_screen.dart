import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// A screen that displays a Google Map.
/// Initially centered on a major Canadian city.
/// Will be updated later to show business markers.
class MapScreen extends StatefulWidget {
  /// Constructor for MapScreen.
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Initial camera position centered on a major Canadian city (e.g., Toronto).
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(43.651070, -79.347015), // Coordinates for Toronto, ON, Canada
    zoom: 10.0, // Initial zoom level
  );

  // Controller for the Google Map.
  late GoogleMapController _controller;

  // Method called when the map is created.
  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Map'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: _onMapCreated,
        myLocationButtonEnabled: true, // Show my location button
        zoomControlsEnabled: true, // Show zoom controls
        // Other map properties can be configured here.
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed to free up resources.
    _controller.dispose();
    super.dispose();
  }
} 
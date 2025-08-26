import 'package:flutter/material.dart';

class InspectionScreen extends StatelessWidget {
  const InspectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Inspection'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Driver Inspection Screen - Coming Soon'),
      ),
    );
  }
}

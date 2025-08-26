import 'package:flutter/material.dart';

class IncidentsScreen extends StatelessWidget {
  const IncidentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Incident'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Driver Incidents Screen - Coming Soon'),
      ),
    );
  }
}

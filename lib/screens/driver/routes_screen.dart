import 'package:flutter/material.dart';
import '../../config/theme.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  int _selectedRouteIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Routes'),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Route selector
          Container(
            height: 120,
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _getRoutes().length,
              itemBuilder: (context, index) {
                final route = _getRoutes()[index];
                return _buildRouteCard(route, index);
              },
            ),
          ),

          // Route details
          Expanded(
            child: _buildRouteDetails(),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getRoutes() {
    return [
      {
        'id': 'ROUTE_A',
        'name': 'Route A',
        'description': 'Westlands to Riverside',
        'status': 'Active',
        'color': AppColors.primary,
        'stops': 8,
        'students': 15,
      },
      {
        'id': 'ROUTE_B',
        'name': 'Route B',
        'description': 'Kilimani to Lavington',
        'status': 'Scheduled',
        'color': AppColors.secondary,
        'stops': 6,
        'students': 12,
      },
      {
        'id': 'ROUTE_C',
        'name': 'Route C',
        'description': 'Karen to Westlands',
        'status': 'Completed',
        'color': AppColors.accent,
        'stops': 10,
        'students': 18,
      },
    ];
  }

  Widget _buildRouteCard(Map<String, dynamic> route, int index) {
    final isSelected = index == _selectedRouteIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRouteIndex = index;
        });
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? route['color'] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? route['color'] : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.2)
                          : route['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.route,
                      color: isSelected ? Colors.white : route['color'],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          route['name'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          route['status'],
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                isSelected ? Colors.white70 : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                route['description'],
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white70 : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildRouteStat(
                    icon: Icons.location_on,
                    value: '${route['stops']}',
                    label: 'Stops',
                    isSelected: isSelected,
                  ),
                  const SizedBox(width: 16),
                  _buildRouteStat(
                    icon: Icons.people,
                    value: '${route['students']}',
                    label: 'Students',
                    isSelected: isSelected,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRouteStat({
    required IconData icon,
    required String value,
    required String label,
    required bool isSelected,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isSelected ? Colors.white70 : Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          '$value $label',
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white70 : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildRouteDetails() {
    final selectedRoute = _getRoutes()[_selectedRouteIndex];
    final stops = _getStopsForRoute(selectedRoute['id']);

    return Column(
      children: [
        // Route header
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedRoute['name'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      selectedRoute['description'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: selectedRoute['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  selectedRoute['status'],
                  style: TextStyle(
                    color: selectedRoute['color'],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Quick actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.navigation,
                  label: 'Navigate',
                  onTap: () => _startNavigation(selectedRoute),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.people,
                  label: 'Students',
                  onTap: () => _viewStudents(selectedRoute),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.schedule,
                  label: 'Schedule',
                  onTap: () => _viewSchedule(selectedRoute),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Stops list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: stops.length,
            itemBuilder: (context, index) {
              final stop = stops[index];
              return _buildStopCard(stop, index);
            },
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getStopsForRoute(String routeId) {
    if (routeId == 'ROUTE_A') {
      return [
        {
          'name': 'Westlands Mall',
          'address': 'Westlands, Nairobi',
          'time': '07:00 AM',
          'students': 5,
          'status': 'Completed',
          'type': 'pickup',
        },
        {
          'name': 'Sarit Centre',
          'address': 'Westlands, Nairobi',
          'time': '07:15 AM',
          'students': 3,
          'status': 'Completed',
          'type': 'pickup',
        },
        {
          'name': 'ABC School',
          'address': 'Riverside, Nairobi',
          'time': '07:45 AM',
          'students': 8,
          'status': 'Current',
          'type': 'dropoff',
        },
        {
          'name': 'XYZ Academy',
          'address': 'Riverside, Nairobi',
          'time': '08:00 AM',
          'students': 7,
          'status': 'Upcoming',
          'type': 'dropoff',
        },
      ];
    }
    return [];
  }

  Widget _buildStopCard(Map<String, dynamic> stop, int index) {
    Color statusColor;
    IconData statusIcon;

    switch (stop['status']) {
      case 'Completed':
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle;
        break;
      case 'Current':
        statusColor = AppColors.primary;
        statusIcon = Icons.location_on;
        break;
      case 'Upcoming':
        statusColor = Colors.grey;
        statusIcon = Icons.schedule;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.schedule;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            statusIcon,
            color: statusColor,
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                stop['name'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: stop['type'] == 'pickup'
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                stop['type'].toUpperCase(),
                style: TextStyle(
                  color: stop['type'] == 'pickup'
                      ? AppColors.primary
                      : AppColors.secondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              stop['address'],
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  stop['time'],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.people,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '${stop['students']} students',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: stop['status'] == 'Current'
            ? ElevatedButton(
                onPressed: () => _arriveAtStop(stop),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Arrive'),
              )
            : null,
        onTap: () => _showStopDetails(stop),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.secondary,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startNavigation(Map<String, dynamic> route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting navigation for ${route['name']}'),
        backgroundColor: AppColors.secondary,
      ),
    );
  }

  void _viewStudents(Map<String, dynamic> route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing students for ${route['name']}'),
        backgroundColor: AppColors.secondary,
      ),
    );
  }

  void _viewSchedule(Map<String, dynamic> route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing schedule for ${route['name']}'),
        backgroundColor: AppColors.secondary,
      ),
    );
  }

  void _arriveAtStop(Map<String, dynamic> stop) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Arrived at ${stop['name']}'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _showStopDetails(Map<String, dynamic> stop) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(stop['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: ${stop['address']}'),
            const SizedBox(height: 8),
            Text('Time: ${stop['time']}'),
            const SizedBox(height: 8),
            Text('Students: ${stop['students']}'),
            const SizedBox(height: 8),
            Text('Type: ${stop['type']}'),
            const SizedBox(height: 8),
            Text('Status: ${stop['status']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (stop['status'] == 'Current')
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _arriveAtStop(stop);
              },
              child: const Text('Mark Arrived'),
            ),
        ],
      ),
    );
  }
}

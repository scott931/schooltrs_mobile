import 'package:flutter/material.dart';
import '../../config/theme.dart';

class ParentNotificationsScreen extends StatefulWidget {
  const ParentNotificationsScreen({super.key});

  @override
  State<ParentNotificationsScreen> createState() =>
      _ParentNotificationsScreenState();
}

class _ParentNotificationsScreenState extends State<ParentNotificationsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'All',
                child: Text('All'),
              ),
              const PopupMenuItem(
                value: 'Transport',
                child: Text('Transport'),
              ),
              const PopupMenuItem(
                value: 'Payment',
                child: Text('Payment'),
              ),
              const PopupMenuItem(
                value: 'Safety',
                child: Text('Safety'),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_selectedFilter),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('All', _selectedFilter == 'All'),
                const SizedBox(width: 8),
                _buildFilterChip('Transport', _selectedFilter == 'Transport'),
                const SizedBox(width: 8),
                _buildFilterChip('Payment', _selectedFilter == 'Payment'),
                const SizedBox(width: 8),
                _buildFilterChip('Safety', _selectedFilter == 'Safety'),
              ],
            ),
          ),

          // Notifications list
          Expanded(
            child: _buildNotificationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? label : 'All';
        });
      },
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : Colors.grey[600],
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildNotificationsList() {
    final notifications = _getFilteredNotifications();

    if (notifications.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No notifications',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'You\'re all caught up!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  List<Map<String, dynamic>> _getFilteredNotifications() {
    final allNotifications = [
      {
        'id': '1',
        'type': 'Transport',
        'title': 'Bus Arrival Update',
        'message': 'Bus SB-001 is 5 minutes away from pickup location',
        'time': '2 minutes ago',
        'isRead': false,
        'icon': Icons.directions_bus,
        'color': AppColors.primary,
      },
      {
        'id': '2',
        'type': 'Payment',
        'title': 'Payment Successful',
        'message': 'Your payment of KES 5,000 has been processed successfully',
        'time': '1 hour ago',
        'isRead': true,
        'icon': Icons.payment,
        'color': AppColors.success,
      },
      {
        'id': '3',
        'type': 'Safety',
        'title': 'Route Change Alert',
        'message':
            'Due to road construction, pickup time has been delayed by 15 minutes',
        'time': '3 hours ago',
        'isRead': false,
        'icon': Icons.warning,
        'color': AppColors.warning,
      },
      {
        'id': '4',
        'type': 'Transport',
        'title': 'Student Boarded',
        'message': 'Emma Johnson has boarded the bus at 7:15 AM',
        'time': '5 hours ago',
        'isRead': true,
        'icon': Icons.person_add,
        'color': AppColors.success,
      },
      {
        'id': '5',
        'type': 'Payment',
        'title': 'Payment Due Reminder',
        'message': 'Your monthly transport fee of KES 5,000 is due in 3 days',
        'time': '1 day ago',
        'isRead': false,
        'icon': Icons.schedule,
        'color': AppColors.warning,
      },
      {
        'id': '6',
        'type': 'Safety',
        'title': 'Weather Alert',
        'message':
            'Heavy rain expected. Bus may be delayed. Please plan accordingly',
        'time': '2 days ago',
        'isRead': true,
        'icon': Icons.cloud,
        'color': AppColors.secondary,
      },
      {
        'id': '7',
        'type': 'Transport',
        'title': 'Bus Maintenance',
        'message':
            'Bus SB-001 is undergoing scheduled maintenance. Alternative bus arranged',
        'time': '3 days ago',
        'isRead': true,
        'icon': Icons.build,
        'color': AppColors.accent,
      },
    ];

    if (_selectedFilter == 'All') {
      return allNotifications;
    }

    return allNotifications.where((notification) {
      return notification['type'] == _selectedFilter;
    }).toList();
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: notification['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            notification['icon'],
            color: notification['color'],
            size: 20,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                notification['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: notification['isRead']
                      ? FontWeight.normal
                      : FontWeight.w600,
                ),
              ),
            ),
            if (!notification['isRead'])
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification['message'],
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              notification['time'],
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleNotificationAction(value, notification),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'mark_read',
              child: Text('Mark as read'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
          child: const Icon(Icons.more_vert),
        ),
        onTap: () => _handleNotificationTap(notification),
      ),
    );
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    // Mark as read if not already read
    if (!notification['isRead']) {
      setState(() {
        notification['isRead'] = true;
      });
    }

    // Show notification details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: notification['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                notification['icon'],
                color: notification['color'],
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(notification['title']),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification['message']),
            const SizedBox(height: 16),
            Text(
              'Time: ${notification['time']}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            Text(
              'Type: ${notification['type']}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (notification['type'] == 'Payment')
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to payments screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Navigating to payments...'),
                  ),
                );
              },
              child: const Text('View Payment'),
            ),
        ],
      ),
    );
  }

  void _handleNotificationAction(
      String action, Map<String, dynamic> notification) {
    switch (action) {
      case 'mark_read':
        setState(() {
          notification['isRead'] = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Marked as read'),
          ),
        );
        break;
      case 'delete':
        setState(() {
          // Remove from list (in a real app, this would update the database)
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification deleted'),
          ),
        );
        break;
    }
  }
}

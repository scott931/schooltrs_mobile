import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../data/dummy_data.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Manifest'),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary cards
          Container(
            height: 80,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    title: 'Total',
                    count: dummyStudents.length,
                    color: AppColors.primary,
                    icon: Icons.people,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSummaryCard(
                    title: 'On Bus',
                    count: dummyStudents
                        .where((s) => _getStudentStatus(s.id) == 'On Bus')
                        .length,
                    color: AppColors.success,
                    icon: Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSummaryCard(
                    title: 'Absent',
                    count: dummyStudents
                        .where((s) => _getStudentStatus(s.id) == 'Absent')
                        .length,
                    color: AppColors.error,
                    icon: Icons.cancel,
                  ),
                ),
              ],
            ),
          ),

          // Filter chips
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('All', _selectedFilter == 'All'),
                const SizedBox(width: 6),
                _buildFilterChip('On Bus', _selectedFilter == 'On Bus'),
                const SizedBox(width: 6),
                _buildFilterChip('Absent', _selectedFilter == 'Absent'),
                const SizedBox(width: 6),
                _buildFilterChip(
                    'Pickup Pending', _selectedFilter == 'Pickup Pending'),
              ],
            ),
          ),

          // Students list
          Expanded(
            child: _buildStudentsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required int count,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 18,
            ),
            const SizedBox(height: 4),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
      selectedColor: AppColors.secondary.withOpacity(0.2),
      checkmarkColor: AppColors.secondary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.secondary : Colors.grey[600],
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildStudentsList() {
    final filteredStudents = _getFilteredStudents();

    if (filteredStudents.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No students found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: filteredStudents.length,
      itemBuilder: (context, index) {
        final student = filteredStudents[index];
        return _buildStudentCard(student);
      },
    );
  }

  List<dynamic> _getFilteredStudents() {
    final students = dummyStudents;

    if (_selectedFilter == 'All') {
      return students;
    }

    return students.where((student) {
      final status = _getStudentStatus(student.id);
      return status == _selectedFilter;
    }).toList();
  }

  String _getStudentStatus(String studentId) {
    // Simulate different statuses based on student ID
    final statuses = ['On Bus', 'Absent', 'Pickup Pending'];
    return statuses[studentId.hashCode % statuses.length];
  }

  Widget _buildStudentCard(dynamic student) {
    final status = _getStudentStatus(student.id);

    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (status) {
      case 'On Bus':
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle;
        statusText = 'On Bus';
        break;
      case 'Absent':
        statusColor = AppColors.error;
        statusIcon = Icons.cancel;
        statusText = 'Absent';
        break;
      case 'Pickup Pending':
        statusColor = AppColors.warning;
        statusIcon = Icons.schedule;
        statusText = 'Pickup Pending';
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
        statusText = 'Unknown';
    }

         return Card(
       margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: student.profileImage != null
              ? NetworkImage(student.profileImage!)
              : null,
          child: student.profileImage == null
              ? const Icon(Icons.person, size: 25)
              : null,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                student.name,
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
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    statusIcon,
                    color: statusColor,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${student.grade} • ${student.school}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    student.pickupLocation.address,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleStudentAction(value, student),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'details',
              child: Text('View Details'),
            ),
            const PopupMenuItem(
              value: 'contact',
              child: Text('Contact Parent'),
            ),
            if (status == 'Pickup Pending')
              const PopupMenuItem(
                value: 'mark_present',
                child: Text('Mark Present'),
              ),
            if (status == 'On Bus')
              const PopupMenuItem(
                value: 'mark_absent',
                child: Text('Mark Absent'),
              ),
          ],
          child: const Icon(Icons.more_vert),
        ),
        onTap: () => _showStudentDetails(student),
      ),
    );
  }

  void _showFilterOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterOption('All Students', 'All'),
            _buildFilterOption('Present Today', 'On Bus'),
            _buildFilterOption('Absent Today', 'Absent'),
            _buildFilterOption('Pickup Pending', 'Pickup Pending'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: _selectedFilter == value
          ? const Icon(Icons.check, color: AppColors.secondary)
          : null,
      onTap: () {
        setState(() {
          _selectedFilter = value;
        });
        Navigator.pop(context);
      },
    );
  }

  void _handleStudentAction(String action, dynamic student) {
    switch (action) {
      case 'details':
        _showStudentDetails(student);
        break;
      case 'contact':
        _contactParent(student);
        break;
      case 'mark_present':
        _markStudentPresent(student);
        break;
      case 'mark_absent':
        _markStudentAbsent(student);
        break;
    }
  }

  void _showStudentDetails(dynamic student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: student.profileImage != null
                        ? NetworkImage(student.profileImage!)
                        : null,
                    child: student.profileImage == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${student.grade} • ${student.school}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildDetailItem('Student ID', student.id),
              _buildDetailItem('Grade', student.grade),
              _buildDetailItem('School', student.school),
              _buildDetailItem(
                  'Pickup Location', student.pickupLocation.address),
              _buildDetailItem(
                  'Drop-off Location', student.dropoffLocation.address),
              _buildDetailItem('Bus Route', student.busRoute),
              const SizedBox(height: 24),
              const Text(
                'Emergency Contacts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              ...student.emergencyContacts.map((contact) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text(contact.name),
                      subtitle: Text(contact.phone),
                      trailing: IconButton(
                        icon: const Icon(Icons.call),
                        onPressed: () => _callContact(contact),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _contactParent(dynamic student) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Contacting parent of ${student.name}...'),
        backgroundColor: AppColors.secondary,
      ),
    );
  }

  void _markStudentPresent(dynamic student) {
    setState(() {
      // In a real app, this would update the database
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${student.name} marked as present'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _markStudentAbsent(dynamic student) {
    setState(() {
      // In a real app, this would update the database
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${student.name} marked as absent'),
        backgroundColor: AppColors.error,
      ),
    );
  }

  void _callContact(dynamic contact) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling ${contact.name}...'),
        backgroundColor: AppColors.secondary,
      ),
    );
  }
}

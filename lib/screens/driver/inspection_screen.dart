import 'package:flutter/material.dart';
import '../../config/theme.dart';

class InspectionScreen extends StatefulWidget {
  const InspectionScreen({super.key});

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  final Map<String, bool> _inspectionItems = {
    'Tires and Wheels': false,
    'Brakes': false,
    'Lights and Signals': false,
    'Engine and Transmission': false,
    'Fuel and Fluids': false,
    'Interior and Safety Equipment': false,
    'Exterior and Body': false,
    'Emergency Equipment': false,
  };

  final TextEditingController _notesController = TextEditingController();
  bool _isInspectionComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Inspection'),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.secondary.withOpacity(0.1),
            child: Row(
              children: [
                const Icon(
                  Icons.checklist,
                  color: AppColors.secondary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Daily Vehicle Inspection',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Complete all checks before starting your route',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Progress indicator
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Inspection Progress',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${_inspectionItems.values.where((checked) => checked).length}/${_inspectionItems.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: _inspectionItems.values
                          .where((checked) => checked)
                          .length /
                      _inspectionItems.length,
                  backgroundColor: Colors.grey[300],
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.secondary),
                ),
              ],
            ),
          ),

          // Inspection items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                ..._inspectionItems.entries.map((entry) => _buildInspectionItem(
                      entry.key,
                      entry.value,
                    )),
                const SizedBox(height: 16),

                // Notes section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Additional Notes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _notesController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText:
                                'Add any additional notes or observations...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: AppColors.secondary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Action buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isInspectionComplete
                        ? () => _submitInspection()
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit Inspection',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetInspection,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildInspectionItem(String title, bool isChecked) {
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isChecked
                ? AppColors.success.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isChecked ? Icons.check : Icons.check_box_outline_blank,
            color: isChecked ? AppColors.success : Colors.grey,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal,
            color: isChecked ? Colors.black : Colors.grey[700],
          ),
        ),
        subtitle: Text(
          _getInspectionDescription(title),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: Switch(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              _inspectionItems[title] = value;
              _checkInspectionComplete();
            });
          },
          activeColor: AppColors.success,
        ),
      ),
    );
  }

  String _getInspectionDescription(String title) {
    switch (title) {
      case 'Tires and Wheels':
        return 'Check tire pressure, tread depth, and wheel condition';
      case 'Brakes':
        return 'Test brake pedal feel and check brake fluid level';
      case 'Lights and Signals':
        return 'Verify all lights, turn signals, and emergency flashers';
      case 'Engine and Transmission':
        return 'Check for leaks, unusual noises, and fluid levels';
      case 'Fuel and Fluids':
        return 'Verify fuel level and check all fluid levels';
      case 'Interior and Safety Equipment':
        return 'Check seats, seatbelts, and emergency equipment';
      case 'Exterior and Body':
        return 'Inspect body condition, mirrors, and windows';
      case 'Emergency Equipment':
        return 'Verify first aid kit, fire extinguisher, and emergency tools';
      default:
        return '';
    }
  }

  void _checkInspectionComplete() {
    setState(() {
      _isInspectionComplete =
          _inspectionItems.values.every((checked) => checked);
    });
  }

  void _resetInspection() {
    setState(() {
      for (String key in _inspectionItems.keys) {
        _inspectionItems[key] = false;
      }
      _notesController.clear();
      _isInspectionComplete = false;
    });
  }

  void _submitInspection() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit Inspection'),
        content: const Text(
          'Are you sure you want to submit this inspection? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Vehicle inspection submitted successfully!'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}

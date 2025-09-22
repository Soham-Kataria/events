import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var _ = theme.textTheme;
    var colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search events...',
                  // Prefix icon for filter
                  prefixIcon: IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {
                      // Handle filter icon press
                      if (kDebugMode) {
                        print('Filter button pressed');
                      }
                      // You can show a dialog, navigate to a filter screen, etc.
                    },
                  ),
                  // Suffix icon for search
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Handle search icon press
                      if (kDebugMode) {
                        print('Search button pressed: ${_searchController.text}');
                      }
                      // Perform search based on _searchController.text
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // Or customize border
                  ),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest, // Or your desired background color
                ),
                onSubmitted: (value) {
                  // Handle search when user presses enter/done on keyboard
                  if (kDebugMode) {
                    print('Search submitted: $value');
                  }
                  // Perform search based on value
                },
              ),
              // Add other widgets for your event list below
              SizedBox(height: 20),
              Text('Your event list content goes here...'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

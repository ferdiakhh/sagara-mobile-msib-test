import 'package:flutter/material.dart';

class SearchCityDialog extends StatelessWidget {
   final TextEditingController searchController;
  final VoidCallback onSearch;

  const SearchCityDialog({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search City'),
      content: TextField(
        controller: searchController,
        decoration: const InputDecoration(hintText: 'Enter city name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onSearch,
          child: const Text('Search'),
        ),
      ],
    );
  }
}

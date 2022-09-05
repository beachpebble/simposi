/*
*  searchbar.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';

class ActivitySearch extends SearchDelegate<String> {
  final cities = [
    'Berlin',
    'Paris',
    'Munich',
    'Hamburg',
    'London',
  ];

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {},
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {},
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_city, size: 120),
            const SizedBox(height: 48),
            Text(
              query,
            ),
          ],
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = cities;

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          leading: const Icon(Icons.location_city),
          title: Text(suggestion),
        );
      });
}

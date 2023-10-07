import 'package:flutter/material.dart';
import 'package:matjary/config/images.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(AppImages.noResults));
  }
}

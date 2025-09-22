import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Welcome to the Favourite screen!',
          style: textTheme.bodyLarge,
        ),
      ),
    );

  }
}

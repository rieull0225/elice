import 'package:elice/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncreaseFontButton extends StatelessWidget {
  const IncreaseFontButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap: () {
        themeProvider.increaseFontSize();
      },
      child: Container(
        child: Center(
          child: Text(
            '폰트 확대',
            style: TextStyle(fontSize: 1 * themeProvider.fontScale),
          ),
        ),
      ),
    );
  }
}

class DecreaseFontButton extends StatelessWidget {
  const DecreaseFontButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap: () {
        themeProvider.decreaseFontSize();
      },
      child: Container(
        child: Center(
          child: Text(
            '폰트 축소',
            style: TextStyle(fontSize: 1 * themeProvider.fontScale),
          ),
        ),
      ),
    );
  }
}

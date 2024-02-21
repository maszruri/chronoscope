import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  final Widget child;
  const MainPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: accentColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        currentIndex: context.watch<MainProvider>().navigationIndex,
        onTap: (value) => _onTap(value, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: child,
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        splashColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: accentColor,
        ),
        onPressed: () {
          context.go('/addStory');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onTap(int index, BuildContext context) {
    context.read<MainProvider>().changeIndex(index);
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/profile');
        break;
      default:
    }
  }
}

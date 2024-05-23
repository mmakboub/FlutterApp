// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:library_app/screens/chat/chat_screen.dart';
import 'package:library_app/screens/formations/register/formation_register.dart';
import 'package:library_app/screens/home_screen.dart';
import 'package:library_app/screens/my_formations/courses_screen.dart';
import 'package:library_app/screens/my_formations/my_formations_screen.dart';
import 'package:library_app/screens/my_formations/zoom_screen.dart';
import 'package:library_app/screens/schedules/schedule_screen.dart';
import 'package:library_app/screens/settings/settings_screen.dart';

class NavigationController extends ChangeNotifier {
  final List<NavigationItem> _screens = [
    NavigationItem(
      screen: const HomeScreen(),
      label: "Accueil",
      icon: 'home',
      boldIcon: 'home_bold',
    ),
    NavigationItem(
      screen: const MyFormationsScreen(),
      label: "Mes Formations",
      icon: 'doc',
      boldIcon: 'doc_bold',
    ),
    NavigationItem(
      screen: const ScheduleScreen(),
      label: "Emploi",
      icon: 'calendar',
      boldIcon: 'calendar_bold',
    ),
    NavigationItem(
      screen: const ChatScreen(),
      label: "Chat",
      icon: 'chat',
      boldIcon: 'chat_bold',
    ),
    NavigationItem(
      screen: const SettingsScreen(),
      label: "Parametres",
      icon: 'settings',
      boldIcon: 'settings_bold',
    ),
  ];

  UnmodifiableListView get screens =>
      UnmodifiableListView(_screens.map((i) => i.screen).toList());
  UnmodifiableListView get labels =>
      UnmodifiableListView(_screens.map((i) => i.label).toList());
  UnmodifiableListView get icons =>
      UnmodifiableListView(_screens.map((i) => i.icon).toList());

  late int _currentIndex;
  int get currentIndex => _currentIndex;

  late Widget currentScreen;

  NavigationController() {
    _currentIndex = 0;
    currentScreen = screens[currentIndex];
  }

  void navigateTo(Widget screen, {int? index}) {
    currentScreen = screen;
    if (index != null) {
      _currentIndex = index;
    }
    notifyListeners();
  }
}

class NavigationItem {
  final String label;
  final String icon, boldIcon;
  final Widget screen;
  NavigationItem({
    required this.label,
    required this.icon,
    required this.boldIcon,
    required this.screen,
  });
}

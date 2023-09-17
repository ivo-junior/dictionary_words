import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/core/routes/auth_routes.dart';
import 'package:dictionary_words/global_components/layouts/auth_layout/auth_layout.dart';
import 'package:dictionary_words/global_components/layouts/global_layout/global_layout_controller.dart';

// ignore: must_be_immutable
class GlobalLayout extends StatefulWidget {
  Widget child;
  GlobalLayout({super.key, required this.child});

  @override
  State<GlobalLayout> createState() => _GlobalLayoutState();
}

class _GlobalLayoutState extends State<GlobalLayout> {
  final GlobalLayoutController _globalLayoutController = Get.find();

  @override
  void initState() {
    ever(_globalLayoutController.currentRouteName, (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authRoutes = AuthRoutes.values.map((route) => route.value);
    final currentRoute = _globalLayoutController.currentRouteName.value;

    if (authRoutes.contains(currentRoute)) {
      return AuthLayout(child: widget.child);
    } else {
      return Scaffold(body: widget.child);
    }
  }
}

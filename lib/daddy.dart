import 'package:alice/widgets/components/appbar.dart';
import 'package:flutter/material.dart';



class DaddyScreen extends StatefulWidget {
  final Widget child;
  const DaddyScreen({required this.child, super.key});

  @override
  DaddyScreenState createState() => DaddyScreenState();
}

class DaddyScreenState extends State<DaddyScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = const GlobalObjectKey('app-navigator-scaffold');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(130.0),
            child: TopAppBar(),
          ),
          key: scaffoldKey,
          backgroundColor: const Color.fromARGB(255, 255, 97, 250),
          body: Center(
            child: widget.child,
          ),
        );
  }
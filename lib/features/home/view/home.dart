import 'package:alice/config.dart';
import 'package:alice/features/home/domain/bloc/home.bloc.dart';
import 'package:alice/features/home/domain/data/home.state.dart';
import 'package:alice/features/home/domain/events/home.events.dart';
import 'package:alice/navigator.dart';
import 'package:alice/widgets/components/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final logger = LoggerConfig(instanceName: 'Home');

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  FocusNode textGroupedListFocusNode = FocusNode(); 
  bool isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textGroupedListFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130.0),
        child: TopAppBar(),
      ),
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 255, 240, 253),
      body: LayoutBuilder(
        builder: (context, constraints) {
          constraints.maxHeight;
          constraints.maxWidth;
          return Container(
              child: const Center(
                child: Text(
                  'Welcome to Alice!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
        }
      ),
          
    );
}

import 'package:alice/config.dart';
import 'package:flutter/material.dart';
import 'package:alice/features/home/domain/index.dart';
import 'package:alice/template/index.dart';

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
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          constraints.maxHeight;
          constraints.maxWidth;
          return Container(
              decoration: BoxDecoration(
                color: ColorProvider.homeBackground,
              ),
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
      );
}

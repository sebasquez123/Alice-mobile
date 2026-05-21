import 'package:alice/widgets/shared/appbar.dart';
import 'package:flutter/material.dart';

class CoreScaffold extends StatefulWidget {
  final Widget child;
  final TextEditingController? searchController;
  const CoreScaffold({required this.child, this.searchController, super.key});

  @override
  CoreScaffoldState createState() => CoreScaffoldState();
}

class CoreScaffoldState extends State<CoreScaffold> {
  final GlobalKey<CoreScaffoldState> scaffoldKey = const GlobalObjectKey('app-core-scaffold');
  final GlobalKey<CoreScaffoldState> appBarKey = const GlobalObjectKey('app-core-appbar');

  @override
  Widget build(BuildContext context) => Scaffold(
    key: scaffoldKey,
    appBar: PreferredSize(
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        widget.searchController != null ? MediaQuery.of(context).size.height * 0.192 : MediaQuery.of(context).size.height * 0.13,
      ),
      child: AppBarWidget(searchController: widget.searchController),
    ),
    body: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: widget.child,
    ),
  );
}
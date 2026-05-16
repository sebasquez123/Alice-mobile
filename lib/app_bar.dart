import 'package:alice/navigator.dart';
import 'package:alice/template/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';


class AppBarScreen extends StatefulWidget {
  final Widget child;
  const AppBarScreen({required this.child, super.key});

  @override
  AppBarScreenState createState() => AppBarScreenState();
}

class AppBarScreenState extends State<AppBarScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = const GlobalObjectKey('app-navigator-scaffold');
  final currentRoute = ValueNotifier<String>('');
  final searchController = TextEditingController();
  final scrollController = ScrollController();
  late final GoRouterDelegate _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter.of(context).routerDelegate;
    _router.addListener(_onRouteChanged);
  }

  void _onRouteChanged() {
      setState(() {
        currentRoute.value = GoRouter.of(context).state.path?? Routes.home;
      });
    }

  @override
  void dispose() {
    _router.removeListener(_onRouteChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          key: scaffoldKey,
          body: SuperScaffold(
            scrollController: scrollController,
            stretch: false,
            body: widget.child,
            appBar: SuperAppBar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              title: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.1,
                  ),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: CachedNetworkImage(
                    imageUrl: getNetworkLogo(gTopbar),
                    height: 30,
                    placeholder: (context, url) => SizedBox(child: Center(child: SpinnerProvider.spinnerXs)),
                    errorWidget: (context, url, error) => Image.asset(logoTopbar, height: 30),
                    ),
                  ),
                ),
              searchBar: SuperSearchBar(
                enabled: currentRoute.value == Routes.home || currentRoute.value == Routes.preferences,
                placeholderText: 'Search for our newest products',
                searchController: searchController,
                cancelButtonText: 'dismiss',
                cancelTextStyle: const TextStyle(
                  color: Color(0xFFFF005D),
                )
              ),
              largeTitle: SuperLargeTitle(
                enabled: true,
                largeTitle: '',
                actions: [
                  Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CachedNetworkImage(
                          imageUrl: getNetworkLogo(gTopbar),
                          height: 30,
                          placeholder: (context, url) => SizedBox(child: Center(child: SpinnerProvider.spinnerXs)),
                          errorWidget: (context, url, error) => Image.asset(logoTopbar, height: 30),
                        ),
                        Row(
                          children: [
                            IconButton(
                            onPressed: () {
                              
                            },
                            iconSize: 28,
                            color: const Color(0xFF531900),
                            icon: const Icon(Icons.image),
                          ),
                        IconButton(
                            onPressed: () {
                              
                            },
                            color: const Color(0xFF531900),
                            iconSize: 28,
                            icon: const Icon(Icons.info),
                          ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              bottom: SuperAppBarBottom(
                enabled: true,
                height: 50,
                child: AnimatedBuilder(
                    animation: _router,
                    builder: (context, _) {
                      final currentPath = GoRouter.of(context).state.path;
                      final activeIndex = pageObjects.indexWhere((p) => p.pageRedirectPath == currentPath);
                      return Container(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(pageObjects.length, (i) {
                            final pageObject = pageObjects[i];
                            final isActive = i == activeIndex;
                            return Container(
                              color: isActive ? const Color(0xFFF1A1FF).withAlpha(38) : Colors.transparent,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  IconButton(
                                    style: ButtonStyle(
                                      fixedSize: WidgetStateProperty.all(const Size(82, 50)),
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                                      ),
                                    ),
                                    highlightColor: const Color(0xFFFF86C8).withAlpha(41),
                                    icon: SvgPicture.asset(
                                      pageObject.pageIcon,
                                      width: 30,
                                      colorFilter: ColorFilter.mode(
                                        isActive ? const Color(0xFFFF005D) : const Color(0xFF531900),
                                        BlendMode.srcIn,
                                      )
                                    ),
                                    tooltip: pageObject.iconToolTip,
                                    onPressed: () {
                                      context.replaceNamed(pageObject.pageRedirectPath);
                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                          scrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                        });                                      
                                      searchController.clear();
                                      },
                                  ),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                      height: 4,
                                      width: isActive
                                          ? MediaQuery.of(context).size.width*0.95 / pageObjects.length
                                          : 0,
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? const Color(0xFFFF005D)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
              ),
            ),
          ),
        );
  }
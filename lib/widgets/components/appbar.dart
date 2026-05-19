import 'package:alice/navigator.dart';
import 'package:alice/template/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget extends StatefulWidget {
  final TextEditingController? searchController;
  const AppBarWidget({this.searchController, super.key});

  @override
  AppBarState createState() => AppBarState();
}

class AppBarState extends State<AppBarWidget> {
  final FocusNode searchFocusNode = FocusNode(debugLabel: 'SearchBarFocus');
  
  late final GoRouterDelegate _router;
  bool searchBarHasText = false;

  @override
  void initState() {
    super.initState();
    _router = GoRouter.of(context).routerDelegate;
    _router.addListener(_onRouteChanged);
    widget.searchController?.addListener(_onChangeSearch);
  }

  void _onRouteChanged() => setState(() {});
  void _onChangeSearch() => setState(() => searchBarHasText = widget.searchController?.text.isNotEmpty ?? false);

  @override
  void dispose() {
    _router.removeListener(_onRouteChanged);
    widget.searchController?.removeListener(_onChangeSearch);
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.only(top: 60),
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
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
                        onPressed: () { },
                        iconSize: 28,
                        color: const Color(0xFF531900),
                        icon: const Icon(Icons.image),
                      ),
                      IconButton(
                        onPressed: () { },
                        color: const Color(0xFF531900),
                        iconSize: 28,
                        icon: const Icon(Icons.info),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          widget.searchController != null ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: searchFocusNode.hasFocus
                    ? [
                        BoxShadow(
                          color: const Color(0xFFFF005D).withAlpha(25),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withAlpha(10),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        )
                      ],
              ),
              child: TextField(
                focusNode: searchFocusNode,
                style: const TextStyle(
                  color: Color(0xFF531900),
                  fontSize: 15,
                ),
                controller: widget.searchController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: const Color(0xFF531900).withAlpha(128),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: searchFocusNode.hasFocus
                        ? const Color(0xFFFF005D)
                        : const Color(0xFF531900).withAlpha(153),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  filled: true,
                  fillColor: searchFocusNode.hasFocus
                      ? const Color(0xFFF1A1FF).withAlpha(35)
                      : const Color(0xFFF1A1FF).withAlpha(15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: const Color(0xFF531900).withAlpha(25),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xFFFF005D),
                      width: 1.5,
                    ),
                  ),
                  suffixIcon: searchFocusNode.hasFocus && searchBarHasText
                      ? GestureDetector(
                          onTap: () => widget.searchController?.clear(),
                          child: Icon(
                            Icons.close,
                            color: const Color(0xFFFF005D).withAlpha(179),
                            size: 24,
                          ),
                        )
                      : null,
                  isDense: true,
                ),
              ),
            ),
          ) : const SizedBox(),
          AnimatedBuilder(
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
                            onPressed: () => context.replaceNamed(pageObject.pageRedirectPath),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                            height: 4,
                            width: isActive
                                ? MediaQuery.of(context).size.width * 0.95 / pageObjects.length
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
        ],
      ),
  );
}

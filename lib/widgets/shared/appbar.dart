import 'package:alice/navigator.dart';
import 'package:alice/template/index.dart';
import 'package:alice/widgets/home/create_post.dart';
import 'package:alice/widgets/shared/index.dart';
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
    widget.searchController?.addListener(_onChangeSearch);
  }

  void _onChangeSearch() => setState(() => searchBarHasText = widget.searchController?.text.isNotEmpty ?? false);

  @override
  void dispose() {

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
                        onPressed: () {
                          showCreatePostSheet(
                            context,
                            onPost: (data) {
                              
                            },
                            onSave: (data) {

                            }
                          );
                        },
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
          widget.searchController != null ? 
          SearchField(
            searchController: widget.searchController, 
            searchFocusNode: searchFocusNode, 
            hasText: searchBarHasText, 
            onClear: () => widget.searchController?.clear()
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
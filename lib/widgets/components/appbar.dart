import 'package:alice/navigator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopAppBar extends StatefulWidget {
  const TopAppBar({ super.key });
  
  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  @override
  Widget build(BuildContext context){ 
    final routerDelegate = GoRouter.of(context).routerDelegate;
    return Column(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.1,
              ),
              color: const Color.fromARGB(255, 255, 255, 255),
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
              child: const Padding(
                padding: EdgeInsets.only(left: 0),
                child: Text(
                  'LOCATE LOGO HERE',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              child: const Divider(
                color: Color(0xFFFFD6D6),
                thickness: 1,
                height: 1,
              ),
            ),
            AnimatedBuilder(
              animation: routerDelegate,
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
                              icon: Icon(
                                size: 30,
                                pageObject.pageIcon,
                                color: isActive ? const Color(0xFFFF005D) : const Color(0xFF531900),
                              ),
                              tooltip: pageObject.iconToolTip,
                              onPressed: () => context.replaceNamed(pageObject.pageRedirectPath),
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
          ],
        );
  }
}
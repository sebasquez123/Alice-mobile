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
        Column(
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
                  'HOME PAGE',
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
                color: Color.fromARGB(255, 255, 214, 214),
                thickness: 1,
                height: 1,
              ),
            ),
            AnimatedBuilder(
              animation: routerDelegate,
              builder: (context, _) => Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pageObjects.map<Widget>((pageObject) {
                      final isActive = pageObject.pageRedirectPath == GoRouter.of(context).state.path;
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isActive ? const Color(0xFFFF86C8) : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          color: 
                              isActive ? const Color(0xFFF1A1FF).withAlpha(38)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: IconButton(
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
                            color: isActive ? const Color(0xFFF1A1FF) : const Color.fromARGB(255, 0, 0, 0),
                          ),
                          tooltip: pageObject.iconToolTip,
                          onPressed: () => context.replaceNamed(pageObject.pageRedirectPath),
                        ),
                      );
                    }).toList(),
                  ),
                )
            ),
            Container(
              child: const Divider(
                color: Color.fromARGB(255, 255, 214, 214),
                thickness: 1,
                height: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
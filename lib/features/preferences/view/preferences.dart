import 'package:alice/config.dart';
import 'package:alice/features/home/domain/index.dart';
import 'package:alice/features/preferences/domain/index.dart';
import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


final logger = LoggerConfig(instanceName: 'Preferences');

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {

  bool isLikedAdds = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadLikedAdds(context);
    });
  }

  Future<void> loadLikedAdds(BuildContext context) async {
    if(isLikedAdds) return;
    final adds = context.read<AddsBloc>().state.adds;
    setState(() => isLikedAdds = true);
    context.read<LikedAddsBloc>().add(LoadLikedAdds(adds: adds));
  }

  Future<void> loadSavedAdds(BuildContext context) async {
    if(!isLikedAdds) return;
    setState(() => isLikedAdds = false);
    context.read<SavedAddsBloc>().add(LoadSavedAdds());
  }


  @override
  Widget build(BuildContext context) => 
          LayoutBuilder(
            builder: (context, constraints) { 
            constraints.maxHeight;
            constraints.maxWidth;
              return Container(
                color: ColorProvider.preferencesBackground,
                child:
                  BlocConsumer<LikedAddsBloc, LikedAddsState>(
                    listener: (context, state) {},
                    builder: (context, likedState) => 
                      BlocConsumer<SavedAddsBloc, SavedAddsState>(
                        listener: (context, state) {},
                        builder: (context, savedState) => 
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                                              child: Container(
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFFDE6F5),
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () async => await loadSavedAdds(context),
                                                          child: AnimatedContainer(
                                                            duration: const Duration(milliseconds: 0),
                                                            curve: Curves.easeInOut,
                                                            decoration: BoxDecoration(
                                                              color: !isLikedAdds ? Colors.white : Colors.transparent,
                                                              borderRadius: const BorderRadius.only(
                                                                topLeft: Radius.circular(15),
                                                                bottomLeft: Radius.circular(15),
                                                              )
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              'SavedPosts',
                                                              style: TextStyle(
                                                                color: !isLikedAdds ? Colors.pinkAccent : Colors.black54,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () async => await loadLikedAdds(context),
                                                          child: AnimatedContainer(
                                                            duration: const Duration(milliseconds: 0),
                                                            curve: Curves.easeInOut,
                                                            decoration: BoxDecoration(
                                                              color: isLikedAdds ? Colors.white : Colors.transparent,
                                                              borderRadius: const BorderRadius.only(
                                                                topRight: Radius.circular(15),
                                                                bottomRight: Radius.circular(15),
                                                              )
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              'LikedPosts',
                                                              style: TextStyle(
                                                                color: isLikedAdds ? Colors.pinkAccent : Colors.black54,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(bottom: 60,left: 12, right: 12),
                                              child: StaggeredGrid.count(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 12,
                                                crossAxisSpacing: 12,
                                                children: [
                                                  ...(isLikedAdds ? likedState.likedAdds : savedState.savedAdds).map((add) => Card(
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                                            child: Image.network(
                                                              add.images.first,
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 48),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                              add.title,
                                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                    ),
                                  )
                                ],
                              ),
                            if(likedState.isLoadingLikedAdds || savedState.isLoadingSavedAdds) Center( child: SpinnerProvider.spinnerLg),
                          ]
                        ),
                      ),
                    ),
          );
        }
      );
}
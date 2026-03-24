import 'package:alice/config.dart';
import 'package:alice/features/home/domain/index.dart';
import 'package:alice/template/index.dart';
import 'package:alice/widgets/home/index.dart';
import 'package:flutter/material.dart';

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
    requestAdds();
  }

  Future<void> requestAdds() async {
    context.read<AddsBloc>().add(LoadAdds());
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
              child: BlocConsumer<AddsBloc, AddsState>(
                listener: (context, state) {},
                builder: (context, state) => Stack(
                    children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              ...state.adds.map<Widget>((add) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AddHeadline(add: add),
                                    AddImagePost(add: add),
                                    AddOptions(
                                      likes: add.liked,
                                      onLove: () { },
                                      onShare: () { },
                                      onQuote: () { },
                                      onSave: () { },
                                    ),
                                    AddDescription(
                                      title: add.title,
                                      description: add.description,
                                      tags: add.tags,
                                    ),
                                    const Divider(height: 32, color: Color.fromARGB(255, 255, 214, 239), thickness: 2,),
                                  ],
                                ),
                              )),
                              const SizedBox(height: 40)
                          ],
                        ),
                      ),
                      if(state.isLoading) Center( child: SpinnerProvider.spinnerLg),
                    ]
                  ),
                ),
            );
        }
      );
}

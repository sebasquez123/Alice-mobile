import 'package:alice/config.dart';
import 'package:alice/features/home/domain/index.dart';
import 'package:alice/template/index.dart';
import 'package:alice/widgets/shared/footer.dart';
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
        child: BlocBuilder<AddsBloc, AddsState>(
          builder: (context, addsState) => Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...addsState.adds.map<Widget>((add) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AddHeadline(add: add),
                                  AddImagePost(add: add),
                                  AddOptions(
                                    onShare: () { },
                                    onQuote: () { },
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
                          addsState.isLoadingAdds ? const SizedBox() : Footer(
                            phoneNumberString: '+57 3126567098',
                            locationString: 'Mz11 Cs12 San Fernando Cuba, Pereira',
                            privacyPolicy: () { },
                            whatsapp: () { },
                            location: () { },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if(addsState.isLoadingAdds) Center(child: SpinnerProvider.spinnerLg),
            ]
          ),
        ),
      );
    }
  );
}

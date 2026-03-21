import 'package:alice/config.dart';
import 'package:alice/features/home/domain/index.dart';
import 'package:alice/template/index.dart';
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
    print('Requesting adds...');
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
                          child: Column(
                            children: [
                              ...state.adds.map<Widget>((add) => Column(
                                  children: [
                                    Text(add.title),
                                  const Divider(),
                                ],
                              )),
                          ],
                        ),
                      ),
                      if(state.isLoading) Center( child: SpinnerProvider.spinnerLg)
                    ]
                  ),
                ),
            );
        }
      );
}

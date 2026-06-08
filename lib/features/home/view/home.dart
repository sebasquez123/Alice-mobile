import 'package:alice/config.dart';
import 'package:alice/features/home/domain/index.dart';
import 'package:alice/models/ads/ads.dart';
import 'package:alice/shared/internet_connection_bloc/index.dart';
import 'package:alice/template/index.dart';
import 'package:alice/widgets/home/index.dart';
import 'package:alice/widgets/shared/index.dart';
import 'package:flutter/material.dart';

final logger = LoggerConfig(instanceName: 'Home');

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String lackInternetConnectionStatus = 'Comprueba tu conexión';
  String genericErrorStatus = 'Ups, algo salió mal. Por favor, intenta mas ratito.';
  
  bool isLoading = false;
  String searchString = '';
  bool searchBarHasText = false;
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode(debugLabel: 'HomeSearchBarFocus');
  bool get internetOn => context.watch<InternetCheckerBloc>().state.thereisinternet;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onFetchAdds(context);
    });
    searchController.addListener(_onChangeSearch);
  }

  void _onChangeSearch() => setState(() {
    searchString = searchController.text.toLowerCase();
    searchBarHasText = searchController.text.isNotEmpty;
  });

  List<Ads> _filterAdsBySearch(List<Ads> ads, String search) {
    if (search.isEmpty) return ads;
    return ads.where((ad) {
      final title = ad.title.toLowerCase();
      final tags = ad.tags.map((tag) => tag.toLowerCase()).toList();
      return title.contains(search) || tags.any((tag) => tag.contains(search));
    }).toList();
  }

  void _onFetchAdds(BuildContext context)  {
    searchController.clear();
    searchString = '';
    FocusScope.of(context).unfocus();
    context.read<AdsBloc>().add(LoadAds());
  }

  @override
  void dispose() {
    searchController.removeListener(_onChangeSearch);
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
        child: BlocBuilder<AdsBloc, AdsState>(
          builder: (context, adsState) {

            final List<Ads> filteredAds = _filterAdsBySearch(adsState.ads, searchString);
            final bool failedRequest = (adsState.isErrorAds);
            final bool isAddLoaded = adsState.ads.isNotEmpty && !adsState.isLoadingAds;

            final bool searchIsNotFound = filteredAds.isEmpty && isAddLoaded && !failedRequest && searchString.isNotEmpty;
            final bool needRetry = failedRequest && !adsState.isLoadingAds;


            return Stack(
            children: [
              Column(
                children: [
                  SearchField(
                    searchController: searchController, 
                    searchFocusNode: searchFocusNode, 
                    hasText: searchBarHasText, 
                    onClear: () => searchController.clear()
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...filteredAds.map<Widget>((add) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AddHeadline(add: add),
                                  AddImagePost(add: add),
                                  AddOptions(
                                    add: add,
                                    onShare: () { },
                                    onQuote: () { },
                                    onMenu: () { },
                                  ),
                                  AdDescription(
                                    title: add.title,
                                    description: add.description,
                                    tags: add.tags,
                                  ),
                                  const Divider(height: 32, color: Color.fromARGB(255, 255, 214, 239), thickness: 2,),
                                ],
                              ),
                            )),
                            if(needRetry)
                              ...[
                              ConnectionRetryWidget(
                                onRetry: _onFetchAdds,
                                internetStatus: internetOn,
                                lackInternetMessage: lackInternetConnectionStatus,
                                genericErrorMessage: genericErrorStatus,
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.15)
                              ],
                            if(searchIsNotFound)
                              NotFoundWidget(
                                itemName: searchString,
                                icon: Icons.search_off_rounded,
                                boxSize: MediaQuery.sizeOf(context).height*0.55,
                              ),
                          filteredAds.length == 1 ? SizedBox(height: MediaQuery.of(context).size.height * 0.1) : const SizedBox(),
                          adsState.isLoadingAds ? const SizedBox() : Footer(
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
              if(adsState.isLoadingAds) Center(child: SpinnerProvider.spinnerLg),
            ]
          );
          }
        ),
      );
    }
  );
}

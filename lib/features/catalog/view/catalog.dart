import 'package:alice/config.dart';
import 'package:alice/features/catalog/domain/index.dart';
import 'package:alice/helpers/index.dart';
import 'package:alice/shared/internet_connection_bloc/index.dart';
import 'package:alice/template/index.dart';
import 'package:alice/widgets/catalog/index.dart';
import 'package:alice/widgets/shared/index.dart';
import 'package:flutter/material.dart';

final logger = LoggerConfig(instanceName: 'Catalog');

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {

  String lackInternetConnectionStatus = 'Comprueba tu conexión';
  String genericErrorStatus = 'Ups, algo salió mal. Por favor, intenta mas ratito.';

  bool isMostrarios = true;
  String? selectedCategory;
  String searchString = '';
  FocusNode searchFocusNode = FocusNode(debugLabel: 'CatalogSearchBarFocus');
  bool searchBarHasText = false;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool get internetOn => context.watch<InternetCheckerBloc>().state.thereisinternet;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProductos(context);
    });
    searchController.addListener(_onChangeSearch);
  }

  void _onChangeSearch() => setState(() {
    searchBarHasText = searchController.text.isNotEmpty;
    searchString = searchController.text.toLowerCase();
  });

  Future<void> _loadMostrarios(BuildContext context) async {
    if(isMostrarios) return;
    setState(() {isMostrarios = true; selectedCategory = null;});
    context.read<CatalogMostrarioBloc>().add(LoadCatalogMostrario());
  }

  Future<void> _loadProductos(BuildContext context) async {
    if(!isMostrarios) return;
    setState(() {isMostrarios = false; selectedCategory = null;});
    context.read<CatalogProductBloc>().add(LoadCatalogProduct());
  }

  Future<void> _onRetry(BuildContext context) async {
    if(!isMostrarios) context.read<CatalogProductBloc>().add(LoadCatalogProduct());
    if(isMostrarios) context.read<CatalogMostrarioBloc>().add(LoadCatalogMostrario());
  }

  Set<String> _getCategories(bool isMostrarios, Map<String, dynamic> mostrarios) {
    if (isMostrarios) return mostrarios.keys.toSet();
    return {};
  }

  Map<String, dynamic> _filterGroupedBySearch(Map<String, dynamic> grouped) {
    if (searchString.isEmpty) return grouped;
    
    final filtered = <String, dynamic>{};
    grouped.forEach((category, items) {
      final filteredItems = (items as List).where((item) {
        final name = (item.title ?? '') as String;
        return name.toLowerCase().contains(searchString);
      }).toList();
      if (filteredItems.isNotEmpty) {
        filtered[category] = filteredItems;
      }
    });
    return filtered;
  }

  @override
  Widget build(BuildContext context) => 
          LayoutBuilder(
            builder: (context, constraints) { 
            constraints.maxHeight;
            constraints.maxWidth;
              return Container(
                decoration: BoxDecoration(
                  color: ColorProvider.preferencesBackground,
                ),
                child:
                  BlocBuilder<CatalogMostrarioBloc, CatalogMostrarioState>(
                    builder: (context, mostrariosState) => 
                      BlocBuilder<CatalogProductBloc, CatalogProductState>(
                        builder: (context, productsState)
                          {

                          final bool failedRequest = (mostrariosState.isErrorMostrario || productsState.isErrorProducts);
                          final bool isMostrariosLoaded = isMostrarios && mostrariosState.mostrarios.isNotEmpty && !mostrariosState.isLoadingMostrario;
                          final bool isProductsLoaded = !isMostrarios && productsState.products.isNotEmpty && !productsState.isLoadingProducts;

                          final groupedMostrarios = groupByCategory(mostrariosState.mostrarios);
                          final groupedProducts = _filterGroupedBySearch(groupByCategory(productsState.products));
                          final categories = _getCategories(isMostrarios, groupedMostrarios).toList();

                          final bool searchIsNotFound = groupedProducts.isEmpty && isProductsLoaded && !failedRequest && searchString.isNotEmpty;
                          final bool needRetry = failedRequest && !productsState.isLoadingProducts && !mostrariosState.isLoadingMostrario;

                          return Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, left: 12.0, right: 12.0, bottom: 8),
                                    child: AnimatedSwitch(
                                      isActive: isMostrarios,
                                      onFirstTabTap: _loadMostrarios,
                                      onSecondTabTap: _loadProductos,
                                      firstLabel: 'Mostrarios',
                                      secondLabel: 'Productos',
                                    ),
                                  ),
                                  if(isProductsLoaded)
                                  SearchField(
                                    searchController: searchController, 
                                    searchFocusNode: searchFocusNode, 
                                    hasText: searchBarHasText, 
                                    onClear: () => searchController.clear()
                                  ),
                                  if(categories.isNotEmpty && isMostrarios)
                                  CategoryLabelingWidget(
                                    categories: categories,
                                    selectedCategory: selectedCategory,
                                    onCategorySelected: (category) => setState(() => selectedCategory = category),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 50),
                                        child: GestureDetector(
                                          onHorizontalDragEnd: (details) {
                                            if (details.primaryVelocity! > 1) {
                                              if (isMostrarios) return;
                                              _loadMostrarios(context);
                                            } else if (details.primaryVelocity! < -1) {
                                              if (!isMostrarios) return;
                                              _loadProductos(context);
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              if(isMostrariosLoaded)
                                                 ...buildGroupedMostrariosList(
                                                  groupedMostrarios: selectedCategory == null
                                                      ? groupedMostrarios
                                                      : {selectedCategory!: groupedMostrarios[selectedCategory!] ?? []},
                                                ),
                                              if(isProductsLoaded)
                                                ...buildGroupedProductList(
                                                  groupedProducts: groupedProducts
                                                ),
                                              if(needRetry)
                                                ConnectionRetryWidget(
                                                  onRetry: _onRetry,
                                                  internetStatus: internetOn,
                                                  lackInternetMessage: lackInternetConnectionStatus,
                                                  genericErrorMessage: genericErrorStatus,
                                                ),
                                              if(searchIsNotFound)
                                                NotFoundWidget(
                                                  itemName: searchString,
                                                  icon: Icons.search_off_rounded,
                                                  boxSize: MediaQuery.sizeOf(context).height*0.55,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if(mostrariosState.isLoadingMostrario || productsState.isLoadingProducts) Center(child: SpinnerProvider.spinnerLg),
                            ]
                          );
                        }
                      ),
                    ),
          );
        }
      );
  }


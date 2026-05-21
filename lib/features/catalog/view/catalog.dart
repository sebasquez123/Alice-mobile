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

  bool isMostrarios = true;
  String? selectedCategory;
  String searchQuery = '';
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
    searchQuery = searchController.text.toLowerCase();
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

  Set<String> _getCategories(bool isMostrarios, Map<String, dynamic> mostrarios, Map<String, dynamic> productos) {
    if (isMostrarios) {
      return mostrarios.keys.toSet();
    } else {
      return productos.keys.toSet();
    }
  }

  Map<String, dynamic> _filterGroupedBySearch(Map<String, dynamic> grouped) {
    if (searchQuery.isEmpty) return grouped;
    
    final filtered = <String, dynamic>{};
    grouped.forEach((category, items) {
      final filteredItems = (items as List).where((item) {
        final name = (item.title ?? '') as String;
        return name.toLowerCase().contains(searchQuery);
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

                          final bool failedByInternet = !internetOn && (mostrariosState.isErrorMostrario || productsState.isErrorProducts);
                          final bool isMostrariosLoaded = isMostrarios && mostrariosState.mostrarios.isNotEmpty && !mostrariosState.isLoadingMostrario;
                          final bool isProductsLoaded = !isMostrarios && productsState.products.isNotEmpty && !productsState.isLoadingProducts;

                          final groupedMostrarios = _filterGroupedBySearch(groupByCategory(mostrariosState.mostrarios));
                          final groupedProducts = _filterGroupedBySearch(groupByCategory(productsState.products));
                          final categories = _getCategories(isMostrarios, groupedMostrarios, groupedProducts).toList();

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
                                  SearchField(
                                    searchController: searchController, 
                                    searchFocusNode: searchFocusNode, 
                                    hasText: searchBarHasText, 
                                    onClear: () => searchController.clear()
                                  ),
                                  if(categories.isNotEmpty && isMostrarios)...[
                                  SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                      child: Row(
                                        children: [       
                                          GestureDetector(
                                            onTap: () => setState(() => selectedCategory = null),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                              decoration: BoxDecoration(
                                                color: selectedCategory == null ? const Color(0xFF531900) : Colors.grey[300],
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                'Todos',
                                                style: TextStyle(
                                                  color: selectedCategory == null ? Colors.white : Colors.grey[600],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          ...categories.map((category) => GestureDetector(
                                            onTap: () => setState(() => selectedCategory = category),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 3),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                                decoration: BoxDecoration(
                                                  color: selectedCategory == category ? const Color(0xFF531900) : Colors.grey[300],
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  category,
                                                  style: TextStyle(
                                                    color: selectedCategory == category ? Colors.white : Colors.grey[600],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),],
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
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
                                          if(failedByInternet && !productsState.isLoadingProducts && !mostrariosState.isLoadingMostrario)
                                            ConnectionRetryWidget(onRetry: _onRetry),
                                          if(!failedByInternet)
                                            if(!productsState.isLoadingProducts && !mostrariosState.isLoadingMostrario)
                                              Footer(
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


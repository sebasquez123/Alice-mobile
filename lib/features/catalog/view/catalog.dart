import 'package:alice/config.dart';
import 'package:alice/features/catalog/domain/index.dart';
import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


final logger = LoggerConfig(instanceName: 'Catalog');

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {

  bool isMostrarios = false;
  ScrollController scrollController = ScrollController();
  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadMostrarios(context);
    });
  }

  Future<void> loadMostrarios(BuildContext context) async {
    if(isMostrarios) return;
    setState(() => isMostrarios = true);
    context.read<CatalogMostrarioBloc>().add(LoadCatalogMostrario());
  }

  Future<void> loadProductos(BuildContext context) async {
    if(!isMostrarios) return;
    setState(() => isMostrarios = false);
    context.read<CatalogProductBloc>().add(LoadCatalogProduct());
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
                  BlocConsumer<CatalogMostrarioBloc, CatalogMostrarioState>(
                    listener: (context, state) {},
                    builder: (context, mostrariosState) => 
                      BlocConsumer<CatalogProductBloc, CatalogProductState>(
                        listener: (context, state) {},
                        builder: (context, productsState)
                          {
                          final bool isOffMostrarios =  !isMostrarios && productsState.products.isEmpty && !internet && !mostrariosState.isLoadingMostrario;
                          final bool isOffProducts =  isMostrarios && mostrariosState.mostrarios.isEmpty && !internet && !productsState.isLoadingProducts;
                          final bool isMostrariosLoaded = isMostrarios && mostrariosState.mostrarios.isNotEmpty && !mostrariosState.isLoadingMostrario;
                          final bool isProductsLoaded = !isMostrarios && productsState.products.isNotEmpty && !productsState.isLoadingProducts;
                          return Stack(
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
                                                          onTap: () async => await loadMostrarios(context),
                                                          child: AnimatedContainer(
                                                            duration: const Duration(milliseconds: 0),
                                                            curve: Curves.easeInOut,
                                                            decoration: BoxDecoration(
                                                              color: !isMostrarios ? Colors.white : Colors.transparent,
                                                              borderRadius: const BorderRadius.only(
                                                                topLeft: Radius.circular(15),
                                                                bottomLeft: Radius.circular(15),
                                                              )
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              'Mostrarios',
                                                              style: TextStyle(
                                                                color: !isMostrarios ? Colors.pinkAccent : Colors.black54,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () async => await loadMostrarios(context),
                                                          child: AnimatedContainer(
                                                            duration: const Duration(milliseconds: 0),
                                                            curve: Curves.easeInOut,
                                                            decoration: BoxDecoration(
                                                              color: isMostrarios ? Colors.white : Colors.transparent,
                                                              borderRadius: const BorderRadius.only(
                                                                topRight: Radius.circular(15),
                                                                bottomRight: Radius.circular(15),
                                                              )
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              'Productos',
                                                              style: TextStyle(
                                                                color: isMostrarios ? Colors.pinkAccent : Colors.black54,
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
                                                  if(isMostrariosLoaded)
                                                  ...mostrariosState.mostrarios.map((item) => Card(
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                                            child: Image.network(
                                                              item.images.first,
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 48),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                              item.title,
                                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                  if(isProductsLoaded)
                                                  ...productsState.products.map((item) => Card(
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                                            child: Image.network(
                                                              item.images.first,
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 48),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                              item.title,
                                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                  if(isOffMostrarios)

                                                  if(isOffProducts)

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                    ),
                                  )
                                ],
                              ),
                            if(mostrariosState.isLoadingMostrario || productsState.isLoadingProducts) Center( child: SpinnerProvider.spinnerLg),
                          ]
                        );
                        }
                      ),
                    ),
          );
        }
      );
}
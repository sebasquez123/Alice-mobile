import 'package:alice/config.dart';
import 'package:alice/features/catalog/domain/index.dart';
import 'package:alice/shared/internet_connection_bloc/index.dart';
import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


final logger = LoggerConfig(instanceName: 'Catalog');

// Custom Painter for Watermark
class _DisconnectionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint wave = Paint()
      ..color = Colors.grey.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    // Draw decorative wave circles
    for (int i = 0; i < 3; i++) {
      canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.3),
        (i + 1) * 80.0,
        wave,
      );
    }

    // Draw WiFi disconnection icon
    final Paint iconPaint = Paint()
      ..color = Colors.grey.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(
      _getWifiOffPath(Offset(size.width * 0.5, size.height * 0.25), 60),
      iconPaint,
    );

    // Draw X through WiFi
    final Paint xPaint = Paint()
      ..color = Colors.red.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawLine(
      Offset(size.width * 0.35, size.height * 0.15),
      Offset(size.width * 0.65, size.height * 0.35),
      xPaint,
    );
  }

  Path _getWifiOffPath(Offset center, double size) {
    final path = Path();
    // WiFi icon outline
    path.moveTo(center.dx - size * 0.4, center.dy + size * 0.3);
    path.quadraticBezierTo(center.dx, center.dy - size * 0.4, center.dx + size * 0.4, center.dy + size * 0.3);
    return path;
  }

  @override
  bool shouldRepaint(_DisconnectionPainter oldDelegate) => false;
}

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
                BlocConsumer<InternetCheckerBloc, InternetCheckerState>(
                    listener: (context, state) {},
                    builder: (context, internetState) => 
                  BlocConsumer<CatalogMostrarioBloc, CatalogMostrarioState>(
                    listener: (context, state) {},
                    builder: (context, mostrariosState) => 
                      BlocConsumer<CatalogProductBloc, CatalogProductState>(
                        listener: (context, state) {},
                        builder: (context, productsState)
                          {
                          final bool isOffProducts =  !isMostrarios && productsState.products.isEmpty && !internetState.thereisinternet && !productsState.isLoadingProducts;
                          final bool isOffMostrarios =  isMostrarios && mostrariosState.mostrarios.isEmpty && !internetState.thereisinternet && !mostrariosState.isLoadingMostrario;
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
                            if(isOffMostrarios || isOffProducts)
                              _DisconnectionOverlay(
                                onRetry: () {
                                  if (isMostrarios) {
                                    loadMostrarios(context);
                                  } else {
                                    loadProductos(context);
                                  }
                                },
                              ),
                          ]
                        );
                        }
                      ),
                    ),
                ),
          );
        }
      );
}

class _DisconnectionOverlay extends StatefulWidget {
  final VoidCallback onRetry;

  const _DisconnectionOverlay({required this.onRetry});

  @override
  State<_DisconnectionOverlay> createState() => _DisconnectionOverlayState();
}

class _DisconnectionOverlayState extends State<_DisconnectionOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomPaint(
                painter: _DisconnectionPainter(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                          CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut),
                        ),
                        child: Icon(
                          Icons.wifi_off_rounded,
                          size: 80,
                          color: Colors.red.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Ups, sin conexión',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Parece que no hay conexión a internet. Verifica tu conexión e intenta de nuevo.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => Transform.scale(
                    scale: 0.95 + (_animationController.value * 0.05),
                    child: ElevatedButton.icon(
                      onPressed: widget.onRetry,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Reintentar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
}
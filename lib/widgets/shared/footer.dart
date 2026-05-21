import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Footer extends StatelessWidget {
  final Function privacyPolicy;
  final Function whatsapp;
  final Function location;
  final String phoneNumberString;
  final String locationString;

  const Footer({
    super.key,
    required this.privacyPolicy,
    required this.whatsapp,
    required this.location,
    required this.phoneNumberString,
    required this.locationString,
  });

  @override
  Widget build(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      color: const Color(0xFF531900),
      child: Row(
        children: [
            Expanded(
            flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 1),
                          ),
                        ),
                        child: Column(
                          spacing: 5,
                          children: [
                            GestureDetector(
                              onTap: () => whatsapp(),
                              child: Row (
                                children: [
                                  SvgPicture.asset(
                                    whatsappIcon,
                                    width: 25,
                                  ),
                                  const SizedBox(width: 10),
                                   Text('Contacto: $phoneNumberString',
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => location(),
                              child: Row(
                                  children: [
                                    SvgPicture.asset(
                                    mapsIcon,
                                    width: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                      width: 220,
                                      child: Text('Dirección: $locationString', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white))),
                                  ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => privacyPolicy(),
                              child: Row (
                                children: [
                                  SvgPicture.asset(
                                    questionIcon,
                                    width: 27,
                                  ),
                                  const SizedBox(width: 10),
                                  const SizedBox(
                                    width: 220,
                                    child: Text('Política de privacidad y manejo de datos', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 55, left: 15),
                    child: Row(
                      children: [
                        Text('© Copy Right - Alice 2026', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10, top: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          getNetworkLogo(gMain),
                          width: 80,
                          height: 80,
                          loadingBuilder: (context, child, loadingProgress){
                            if (loadingProgress == null) return child;
                              return Center(child: SpinnerProvider.spinnerSm);
                            },
                          errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey[300],
                              child: Center(
                                child: Image.asset(
                                  gMain,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                          ),
                        const Text('Celebrating since 2004', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ],
    )
  );
}
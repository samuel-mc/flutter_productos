import 'dart:math';

import 'package:flutter/material.dart';
import 'package:productos_app/helpers/custom_colors.dart';
import 'package:productos_app/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product producto;
  const ProductCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: _cardDecoration(),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Stack(
        children: [
          _BgImage(urlImage: producto.imagen),
          _CardContent(nombre: producto.name),
          _ProductPrice(price: producto.price),
          if (!producto.available) _ProductAvailable()
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() =>
      BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: const [
        BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 5),
            blurRadius: 10,
            spreadRadius: 1)
      ]);
}

class _ProductPrice extends StatelessWidget {
  final double price;

  const _ProductPrice({required this.price});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 60,
        width: 140,
        decoration: const BoxDecoration(
            color: CustomColors.lightBlue,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              '\$ $price',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -50,
      top: 40,
      child: Transform.rotate(
        angle: -pi / 4.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: 40,
          width: 220,
          decoration:
              const BoxDecoration(color: CustomColors.darkPink, boxShadow: [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 1)
          ]),
          child: const FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                'No disponible',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final String nombre;

  const _CardContent({super.key, required this.nombre});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 32),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: CustomColors.lightBlue,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Laborum occaecat excepteur id Lorem.',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BgImage extends StatelessWidget {
  final String? urlImage;

  const _BgImage({this.urlImage});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: double.infinity,
        height: 320,
        child: urlImage != null
            ? FadeInImage(
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(urlImage!))
            : const Image(
                fit: BoxFit.cover, image: AssetImage('assets/no-image.png')),
      ),
    );
  }
}

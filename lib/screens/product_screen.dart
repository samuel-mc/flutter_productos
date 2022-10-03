import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productos_app/helpers/custom_colors.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/products_service.dart';
import 'package:productos_app/ui/input_decoration.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productsService.selectedProduct),
      child: _ProductsScreenBody(productsService: productsService),
    );
  }
}

class _ProductsScreenBody extends StatelessWidget {
  const _ProductsScreenBody({
    Key? key,
    required this.productsService,
  }) : super(key: key);

  final ProductsService productsService;

  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white),
                child: Column(
                  children: [
                    _BgImage(image: productsService.selectedProduct.imagen),
                    _FormContainer()
                  ],
                ),
              ),
              if (productsService.isSaving) _SavingModal()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!productFormProvider.isValidForm()) {
            return;
          } else {
            productsService.saveProduct(productFormProvider.product);
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class _SavingModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.black54,
      child: const Center(
          child: CircularProgressIndicator(
        color: CustomColors.lightPink,
      )),
    );
  }
}

class _FormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: productFormProvider.formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: productFormProvider.product.name,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecorations.authInputDecorations(
                  placeholder: 'Nombre', label: 'Nombre'),
              onChanged: (value) {
                productFormProvider.product.name = value;
              },
              validator: (value) {
                if (value == null || value == '') {
                  return 'El nombre es obligatorio';
                }
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: productFormProvider.product.price.toString(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecorations(
                  placeholder: 'Precio', label: 'Precio'),
              onChanged: (value) {
                if (double.tryParse(value) == null) {
                  productFormProvider.product.price = 0;
                } else {
                  productFormProvider.product.price = double.tryParse(value)!;
                }
              },
              validator: (value) {
                if (value == null || value == '') {
                  return 'El precio es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: SwitchListTile.adaptive(
                value: productFormProvider.product.available,
                onChanged: productFormProvider.updateSwitch,
                title: const Text(
                  'Disponible',
                  style: TextStyle(color: Colors.black),
                ),
                activeColor: CustomColors.lightBlue,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _BgImage extends StatelessWidget {
  final String? image;

  const _BgImage({super.key, this.image});
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    return Stack(
      children: [
        obtenerImagen(image),
        // image != null
        //     ? ClipRRect(
        //         borderRadius: const BorderRadius.only(
        //             topLeft: Radius.circular(20),
        //             topRight: Radius.circular(20)),
        //         child: FadeInImage(
        //             placeholder: const AssetImage('assets/jar-loading.gif'),
        //             image: NetworkImage(image!)),
        //       )
        //     : const ClipRRect(
        //         borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(20),
        //             topRight: Radius.circular(20)),
        //         child: FadeInImage(
        //           placeholder: AssetImage('assets/jar-loading.gif'),
        //           image: AssetImage('assets/no-image.png'),
        //         ),
        //       ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4, left: 4),
              decoration: const BoxDecoration(
                  color: Colors.black45, shape: BoxShape.circle),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.chevron_left)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4, right: 4),
              decoration: const BoxDecoration(
                color: Colors.black45,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 100);

                    if (pickedFile == null) {
                      print('No se seleccionó image');
                      return;
                    }

                    print('Imagen seleccionada: ${pickedFile.path}');
                    productsService.setProductImage(pickedFile.path);
                  },
                  icon: const Icon(Icons.camera_alt_outlined)),
            )
          ],
        )
      ],
    );
  }
}

Widget obtenerImagen(String? image) {
  if (image == null) {
    return const ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: AssetImage('assets/no-image.png'),
      ),
    );
  }

  if (image.startsWith('http')) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(image)),
    );
  }

  return Image.file(
    File(image),
    fit: BoxFit.cover,
  );
}

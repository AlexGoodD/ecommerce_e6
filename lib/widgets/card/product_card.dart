import 'package:super_store_e_commerce_flutter/imports.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final cart = Provider.of<CartProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(255, 18, 47, 12), width: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () => openImage(context, size),
        child: Stack(
          children: [
            // Category Label at the top-left corner
            Positioned(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 18, 47, 12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextBuilder(
                  text: product.category,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),

            // Centered Image in the middle, but smaller
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Adjusted height for smaller images
                const SizedBox(height: 55.0),
                SizedBox(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        product.image!,
                        height: 125, // Smaller height to keep image centered
                        fit: BoxFit.contain,
                        colorBlendMode: BlendMode.overlay,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),

                // Price below the image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      // Precio centrado
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Centrar el precio en el contenedor
                        children: [
                          const TextBuilder(
                            text: '\$ ',
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 13, 3),
                          ),
                          TextBuilder(
                            text: product.price!.round().toString(),
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 1, 11, 0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5), // Espacio entre el precio y el botón

                      // Botón de carrito alineado a la derecha
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          splashColor: const Color.fromARGB(255, 59, 138, 47),
                          tooltip: 'Añadir al carrito',
                          onPressed: () {
                            final ScaffoldMessengerState addToCartMsg = ScaffoldMessenger.of(context);
                            addToCartMsg.showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.black,
                                action: SnackBarAction(
                                  label: 'Ir al carrito',
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => Cart(userEmail: '',)));
                                  },
                                ),
                                behavior: SnackBarBehavior.floating,
                                content: const TextBuilder(text: 'Producto añadido al carrito'),
                              ),
                            );
                            CartModel cartModel = CartModel(
                              id: product.id!,
                              title: product.title!,
                              price: product.price!,
                              image: product.image!,
                              category: product.category!,
                              quantity: 1,
                              totalPrice: product.price!,
                            );
                            cart.addItem(cartModel);
                          },
                          icon: const Icon(Icons.add_shopping_cart_outlined),
                          color: const Color.fromARGB(255, 74, 157, 53),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  openImage(BuildContext context, Size size) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(8),
          iconPadding: EdgeInsets.zero,
          elevation: 0,
          title: SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextBuilder(text: 'Image'),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
          content: InteractiveViewer(
            minScale: 0.1,
            maxScale: 1.9,
            child: Image.network(
              product.image!,
              height: size.height * 0.5,
              width: size.width,
            ),
          ),
        );
      },
    );
  }
}
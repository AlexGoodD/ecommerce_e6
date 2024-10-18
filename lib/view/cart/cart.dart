import 'package:super_store_e_commerce_flutter/imports.dart';

class Cart extends StatelessWidget {
  final String userEmail; // Agrega este campo para el email del usuario

  const Cart({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 225, 251, 213),
        title: const Text('Mi Carrito'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              height: 25,
              width: 25,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Text(
                cart.itemCount.toString(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: cart.items.length,
          itemBuilder: (BuildContext context, int i) {
            final item = cart.items[i];
            return CartCard(cart: item);
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<int>(
          future: cart.totalPrice(), // Llama al cálculo en el isolate.
          builder: (context, snapshot) {
            String buttonText;
            bool isButtonEnabled;
            VoidCallback? onButtonPressed;

            if (snapshot.connectionState == ConnectionState.waiting) {
              buttonText = 'Cargando...';
              isButtonEnabled = false;
              onButtonPressed = null;
            } else if (snapshot.hasError) {
              buttonText = 'Error al calcular';
              isButtonEnabled = false;
              onButtonPressed = null;
            } else {
              final int total = snapshot.data ?? 0;

              if (total == 0) {
                // Si el total es 0, el botón dice "Añade productos"
                buttonText = 'Añade productos';
                isButtonEnabled = true;
                onButtonPressed = () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Home(email: userEmail))); // Usa el email aquí
                };
              } else {
                // Si hay productos, el botón muestra el total y "Pagar Ahora"
                buttonText = '\$${total} - Pagar Ahora';
                isButtonEnabled = true;
                onButtonPressed = () async {
                  await sendEmail(cart, total, userEmail); // Pasa el email aquí
                  final buyNow = ScaffoldMessenger.of(context);
                  buyNow.showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.black,
                      behavior: SnackBarBehavior.floating,
                      content: const Text('Gracias por comprar con nosotros'),
                    ),
                  );
                };
              }
            }

            return MaterialButton(
              height: 60,
              color: Colors.black,
              minWidth: size.width,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: isButtonEnabled ? onButtonPressed : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buttonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Modificar la función para aceptar el email del usuario
  Future<void> sendEmail(CartProvider cart, int total, String userEmail) async {
    String productDetails = cart.items.map((item) {
      return 'Producto: ${item.title}, Cantidad: ${item.quantity}, Precio: \$${item.price}';
    }).join('\n');

    final Email email = Email(
      body: 'Detalles de la compra:\n\n$productDetails\n\nTotal: \$${total}',
      subject: 'Compra realizada - Productos Comprados',
      recipients: [userEmail], // Usa el email del usuario aquí
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print('Error al enviar el correo: $error');
    }
  }
}
import 'package:super_store_e_commerce_flutter/imports.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

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
          future: cart.totalPrice(),  // Llama al cálculo en el isolate.
          builder: (context, snapshot) {
            String buttonText;
            bool isButtonEnabled;

            if (snapshot.connectionState == ConnectionState.waiting) {
              buttonText = 'Cargando...';
              isButtonEnabled = false;
            } else if (snapshot.hasError) {
              buttonText = 'Error al calcular';
              isButtonEnabled = false;
            } else {
              buttonText = '\$${snapshot.data} - Pagar Ahora';
              isButtonEnabled = true;
            }

            return MaterialButton(
              height: 60,
              color: Colors.black,
              minWidth: size.width,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: isButtonEnabled
                  ? () {
                final buyNow = ScaffoldMessenger.of(context);
                buyNow.showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.black,
                    behavior: SnackBarBehavior.floating,
                    content: const Text('Thank you for shopping with us'),
                  ),
                );
              }
                  : null,
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
}
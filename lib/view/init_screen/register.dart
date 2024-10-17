import 'package:super_store_e_commerce_flutter/imports.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    // total height and width of screen
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppNameWidget(),
              const SizedBox(height: 50),
              const Align(
                alignment: Alignment.center,
                child: TextBuilder(
                  text: 'Registro',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: TextBuilder(
                  text: 'Crea tu nueva cuenta',
                  fontSize: 15,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 40),
              const CustomTextField(labelText: 'Nombre completo', hintText: 'John Doe', prefixIcon: Icons.person),
              const SizedBox(height: 20.0),
              const CustomTextField(labelText: 'Correo electrónico', hintText: 'example@example.com', prefixIcon: Icons.email),
              const SizedBox(height: 20.0),
              const CustomTextField(labelText: 'Contraseña', hintText: '123456', prefixIcon: Icons.lock),
              const SizedBox(height: 20.0),
              const CustomTextField(labelText: 'Confirmar contraseña', hintText: '123456', prefixIcon: Icons.lock),
              const SizedBox(height: 30.0),
              Center(
                child: MaterialButton(
                  height: 60,
                  color: AppColors.buttonColor,
                  minWidth: size.width * 0.8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Login()), (route) => false);
                  },
                  child: const TextBuilder(
                    text: 'Registrarme',
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextBuilder(
                    text: "¿Tienes una cuenta? ",
                    color: Colors.black,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Login()));
                    },
                    child: const TextBuilder(
                      text: 'Inicia sesión',
                      color: AppColors.textPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

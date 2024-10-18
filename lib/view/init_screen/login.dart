import 'package:super_store_e_commerce_flutter/imports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  text: 'Bienvenido de vuelta',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: TextBuilder(
                  text: 'Ingresa a tu cuenta por favor',
                  fontSize: 15,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 50),
              CustomTextField(
                labelText: 'Correo electrónico',
                hintText: 'example@example.com',
                prefixIcon: Icons.email,
                controller: _emailController,
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                labelText: 'Contraseña',
                hintText: '123456',
                prefixIcon: Icons.lock,
                controller: _passwordController,
              ),
              const SizedBox(height: 15.0),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: const TextBuilder(
                    text: 'Olvidé mi contraseña',
                    fontSize: 16,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Center(
                child: MaterialButton(
                  height: 60,
                  color: AppColors.buttonColor,
                  minWidth: size.width * 0.8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    // Obtener el email del controlador
                    String email = _emailController.text;

                    // Navegar a Home y pasar el email como argumento
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => Home(email: email)),
                          (route) => false,
                    );
                  },
                  child: const TextBuilder(
                    text: 'Iniciar sesión',
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
                    text: "¿No tienes una cuenta? ",
                    color: AppColors.textSecondaryColor,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Register()));
                    },
                    child: const TextBuilder(
                      text: 'Regístrate',
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

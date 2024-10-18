import 'package:super_store_e_commerce_flutter/imports.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 170.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '🐻', // Emoji de oso
                          style: TextStyle(
                            fontSize: 40, // Tamaño del emoji
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextBuilder(text: RawString.appName, fontSize: 30.0, fontWeight: FontWeight.bold),
                            TextBuilder(text: RawString.dummyEmail, fontSize: 15.0, fontWeight: FontWeight.normal),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Divider(
                    color: Colors.grey, // Línea separadora tenue
                    thickness: 0.5,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => Home(email: '',)));
                          },
                          leading: const Icon(
                            Icons.home_outlined, // Cambié el ícono a "outlined"
                            color: Colors.black,
                            size: 24,
                          ),
                          title: const TextBuilder(
                              text: "Inicio",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => Cart(userEmail: '',)));
                          },
                          leading: const Icon(
                            Icons.shopping_bag_outlined, // Ícono "outlined"
                            color: Colors.black,
                            size: 24,
                          ),
                          title: const TextBuilder(
                              text: "Carrito de compras",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        ListTile(
                          onTap: () {
                            UrlLaunch.launchInBrowser(urlString: RawString.gitHubRepo);
                          },
                          leading: const Icon(Icons.code_outlined, color: Colors.black, size: 24), // Ícono de código
                          title: const TextBuilder(
                              text: "Repositorio",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        ListTile(
                          onTap: () {
                            UrlLaunch.makeEmail(email: RawString.emailId, body: 'Hola?,', subject: 'Podríamos hablar?');
                          },
                          leading: const Icon(
                            Icons.email_outlined, // Ícono "outlined"
                            color: Colors.black,
                            size: 24,
                          ),
                          title: const TextBuilder(
                              text: "Contáctanos",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            showAboutDialog(
                              applicationName: RawString.appName,
                              context: context,
                              applicationVersion: '1.0.0+1',
                            );
                          },
                          child: const ListTile(
                            leading: Icon(
                              Icons.info_outline, // Ícono "outlined"
                              color: Colors.black,
                              size: 24,
                            ),
                            title: TextBuilder(
                                text: "Acerca de la app",
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const Login()));
                          },
                          leading: const Icon(
                            Icons.logout_outlined, // Cambié el ícono a "outlined"
                            color: Colors.black,
                            size: 24,
                          ),
                          title: const TextBuilder(
                              text: "Cerrar sesión",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        const Divider(color: Colors.grey, thickness: 0.5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 100,
              child: Column(
                children: [
                  const AppNameWidget(),
                  TextBuilder(
                    text: RawString.appDescription,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

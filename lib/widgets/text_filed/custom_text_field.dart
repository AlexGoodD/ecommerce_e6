import 'package:super_store_e_commerce_flutter/imports.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.prefixIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: GoogleFonts.poppins(color: AppColors.textPrimaryColor, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          size: 20,
          color: AppColors.textPrimaryColor,
        ),
        labelText: labelText,
        //hintText: hintText,
        filled: true,
        fillColor: AppColors.backgroundTextFieldColor, // Color de fondo del TextField
        border: _border(),
        enabledBorder: _border(), // Para aplicar el estilo cuando no está enfocado
        focusedBorder: _border(), // Para aplicar el estilo cuando está enfocado
      ),
    );
  }

  InputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: AppColors.textSecondaryColor),
    );
  }
}
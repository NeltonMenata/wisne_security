import 'package:flutter/material.dart';
import 'package:wisne_security/core/service/auth_service.dart';
import 'package:wisne_security/layers/presenter/routes/Routes.dart';
import 'package:wisne_security/layers/presenter/ui/auth/auth_firebase.dart';
import '../../utils/customButton.dart';
import 'package:country_picker/country_picker.dart';
import '../../utils/colors.dart';
import '../../utils/text_with_tap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = AuthControllerFirebase.instance;
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
      countryCode: 'AO',
      displayName: 'Angola',
      displayNameNoCountryCode: 'AO',
      e164Key: '',
      e164Sc: 0,
      example: 'Angola',
      geographic: true,
      level: 1,
      name: 'Angola',
      phoneCode: '244');

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(offset: phoneController.text.length),
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 35,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                  child: Image.asset(
                    "assets/logo/security.png",
                  ),
                ),
                const TextWithTap(
                  "Registro / Login",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  marginTop: 20,
                  marginBottom: 20,
                ),
                const TextWithTap(
                  "Adicione seu número de telefone. Enviaremos um código de verificação",
                  fontSize: 14,
                  color: Colors.black38,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  marginBottom: 20.0,
                ),
                TextFormField(
                  cursorColor: Colors.blueAccent,
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: "Digite o número de telefone",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.only(
                        top: 14.0,
                        left: 8.0,
                        right: 5.0,
                      ),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                bottomSheetHeight: 400,
                              ),
                              onSelect: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              });
                        },
                        child: Text(
                          "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    text: "Login",
                    onPressed: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => OtpScreen(
                      //       numero: phoneController.text,
                      //       code: selectedCountry.phoneCode.toString(),
                      //     ),
                      //   ),
                      // );
                      if (phoneController.text.isNotEmpty) {
                        final code = selectedCountry.phoneCode;
                        await AuthService.verifyNumber(
                            phoneNumber: "+$code${phoneController.text}",
                            next: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.HOME);
                            });

                        Navigator.pushNamed(context, Routes.OTP);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Digite o número para continuar!"),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:wisne_security/layers/presenter/routes/Routes.dart';
import 'package:wisne_security/layers/presenter/ui/auth/auth_firebase.dart';
import '../../utils/colors.dart';
import '../../utils/container_with_corner.dart';
import '../../utils/customButton.dart';
import '../../utils/text_with_tap.dart';
import '../home/SlivertabBat.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final auth = AuthControllerFirebase.instance;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Map;
    String numero = "${args["numero"]}";
    String code = "${args["code"]}";
    String id = "${args["id"]}";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        //alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContainerCorner(
                marginTop: 25.0,
                child: Image.asset(
                  "assets/logo/logo.png",
                  width: 300,
                  height: 250,
                ),
              ),
              const TextWithTap(
                "Verificação de telefone",
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              TextWithTap(
                "Digite o codigo enviado no seu número de telefone + $code $numero",
                fontSize: 16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: code.length,
                smsCodeMatcher: code,
                controller: TextEditingController(text: code),
                showCursor: true,
                onCompleted: (pin) => print(pin),
                defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.blue),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  text: "Enviar",
                  onPressed: () {
                    setState(() {
                      print(code);
                    });
                    auth.auth
                        .applyActionCode(code)
                        .then((value) => print("Verified Sucess"))
                        .catchError((exepction) {
                      print("Error code: $exepction");
                    });

                    //Navigator.pushNamed(context, Routes.EDIT_USER);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Slivertabbat()),
                    // );
                  },
                ),
              ),
              const TextWithTap(
                "Não recebeu nenhum código?",
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
                marginTop: 15,
                marginBottom: 15,
              ),
              TextWithTap(
                "Enviar novo código",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wisne_security/layers/domain/entities/call_emergency/call_emergency.dart';
import 'package:wisne_security/layers/presenter/routes/Routes.dart';
import '../../utils/text_with_tap.dart';
import '../../utils/colors.dart';

class SliverTabBarPage extends StatefulWidget {
  const SliverTabBarPage({Key? key}) : super(key: key);

  @override
  State<SliverTabBarPage> createState() => _SliverTabBarPageState();
}

class _SliverTabBarPageState extends State<SliverTabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int index = 0;
  String image =
      "https://img.freepik.com/premium-vector/information-privacy-abstract-concept-vector-illustration_107173-25671.jpg?w=740";
  List<String> miImages = [
    "https://img.freepik.com/premium-vector/information-privacy-abstract-concept-vector-illustration_107173-25671.jpg?w=740",
    "https://www.quickin.io/wp-content/uploads/2022/06/13.-HEADER-2560x1709-_-LGPD-1-2048x1367.png",
    "https://img.freepik.com/free-vector/business-woman-business-man-with-diagram-document-information_24640-45232.jpg?t=st=1693652924~exp=1693653524~hmac=238d1f509238674664fb7d48e3231e514b044460c74135e1071ca91feec520d9",
  ];
  final emergencys = [
    Emergency(
        name: "1º ESQUADRA DO KILAMBA",
        phone: "941684825",
        type: "Policia",
        consignee: "SALA OPERATIVA",
        block: [
          "A",
          "B",
          "C",
          "E",
          "F",
          "M",
          "N",
          "R",
          " P",
          " T",
          "S",
          "CAMAMA II"
        ]),
    Emergency(
        name: "2º ESQUADRA DO KILAMBA",
        phone: "922272555",
        type: "Policia",
        consignee: "SALA OPERATIVA"),
    Emergency(
        name: "ESQUADRA DO QUENGUELA",
        phone: "998565030",
        type: "Policia",
        consignee: "SALA OPERATIVA"),
    Emergency(
        name: "ESQUADRA DO RAMIROS",
        phone: "923750124",
        type: "Policia",
        consignee: "CHEFE DAS OPERAÇÕES"),
    Emergency(
        name: "ESQUADRA DO BITA TANQUE 2",
        phone: "943527711",
        type: "Policia",
        consignee: "PIQUEETE"),
    Emergency(
        name: "ESQUADRA DO CANHANGA",
        phone: "924448910",
        type: "Policia",
        consignee: "CMDT ESQUADRA"),
  ];
  void _tabaListenner() {
    setState(() {
      index = tabController.index;
      image = miImages[index];
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_tabaListenner);
    super.initState();
  }

  @override
  void dispose() {
    tabController.removeListener(_tabaListenner);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Drawer(
            child: Column(children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(),
                accountName: Text(
                    FirebaseAuth.instance.currentUser?.displayName ??
                        "Edite o seu nome"),
                accountEmail: Text(FirebaseAuth.instance.currentUser?.email ??
                    "Edite o seu email"),
              ),
              const Spacer(),
              ListTile(
                title: const Text("Terminar Sessão"),
                trailing: const Icon(
                  Icons.power_settings_new_rounded,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.REGISTER, (route) => false);
                },
              )
            ]),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0.0,
                pinned: true,
                backgroundColor: primaryColor,
                expandedHeight: size.height * .3,
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                    children: [
                      const TextWithTap(
                        " Wisne Security ",
                        color: Colors.green,
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.USER_PERFIL);
                          },
                          icon: const CircleAvatar(child: Icon(Icons.person)))
                    ],
                  ),
                  background: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    width: size.width * .8,
                  ),
                ),
              ),
              SliverAppBar(
                pinned: true,
                primary: false,
                leading: const SizedBox(),
                leadingWidth: 0,
                elevation: 8.0,
                backgroundColor: primaryColor,
                title: Align(
                  alignment: AlignmentDirectional.center,
                  child: TabBar(
                    controller: tabController,
                    indicatorColor: primaryColor,
                    isScrollable: true,
                    tabs: const [
                      Tab(
                        text: "Emergência Policial",
                      ),
                      Tab(
                        text: "Segurança electrónica",
                      ),
                      Tab(
                        text: "Tecnologia em segurança",
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * .01),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(emergencys.length, (index) {
                                return ListTile(
                                  leading: const CircleAvatar(),
                                  title: Text("${emergencys[index].name}"),
                                  subtitle:
                                      Text("${emergencys[index].consignee}"),
                                  trailing: IconButton(
                                      onPressed: () async {
                                        final call = Uri.parse(
                                            "tel:+244${emergencys[index].phone}");
                                        if (await canLaunchUrl(call)) {
                                          launchUrl(call);
                                        }
                                      },
                                      icon: Icon(Icons.phone)),
                                );
                              })
                            ],
                          ),
                        ),
                        TextWithTap("Hola 2"),
                        TextWithTap("Hola 3"),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../utils/text_with_tap.dart';
import '../../utils/colors.dart';

class Slivertabbat extends StatefulWidget {
  const Slivertabbat({Key? key}) : super(key: key);

  @override
  State<Slivertabbat> createState() => _SlivertabbatState();
}

class _SlivertabbatState extends State<Slivertabbat>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int index = 0;
  String image =
      "https://img.freepik.com/premium-vector/information-privacy-abstract-concept-vector-illustration_107173-25671.jpg?w=740";
  List<String> miImages = [
    "https://img.freepik.com/premium-vector/information-privacy-abstract-concept-vector-illustration_107173-25671.jpg?w=740",
    "https://www.quickin.io/wp-content/uploads/2022/06/13.-HEADER-2560x1709-_-LGPD-1-2048x1367.png",
    "https://img.freepik.com/free-vector/business-woman-business-man-with-diagram-document-information_24640-45232.jpg?t=st=1693652924~exp=1693653524~hmac=238d1f509238674664fb7d48e3231e514b044460c74135e1071ca91feec520d9",
  ];

  void _tabaListenner() {
    setState(() {
      index = tabController!.index;
      image = miImages[index];
    });
  }

  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController!.addListener(_tabaListenner);
    super.initState();
  }

  void dispose() {
    tabController!.removeListener(_tabaListenner);
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0.0,
              pinned: true,
              leading: Container(),
              backgroundColor: primaryColor,
              expandedHeight: 350,
              flexibleSpace: FlexibleSpaceBar(
                title: const TextWithTap(" Wisne Security "),
                background: Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: 100,
                ),
              ),
            ),
            SliverAppBar(
              pinned: true,
              primary: false,
              leading: Container(),
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
                      text: "Vigilância e Protecção",
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
                height: 800.0,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      TextWithTap("Hola 1"),
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
    );
  }
}

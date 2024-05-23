import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:library_app/controllers/formations_controller.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/models/domains.dart';
import 'package:library_app/models/formation.dart';
import 'package:library_app/screens/formations/formation_screen.dart';
import 'package:library_app/screens/formations/register/formation_register.dart';
import 'package:library_app/screens/formations_out/formation_screen.dart';
import 'package:library_app/screens/widgets/library_app_bar.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FormationsScreenOut extends StatefulWidget {
  const FormationsScreenOut({super.key});

  @override
  State<FormationsScreenOut> createState() => _FormationsScreenOutState();
}

class _FormationsScreenOutState extends State<FormationsScreenOut> {
  int selectedDomain = 1;
  List<Domain> domains = [];
  bool isLoading = true;
  loadData() async {
    List<Domain> allDomains = await FormationsController.loadDomains();
    setState(() {
      domains = allDomains;
      FormationsController.selectedDomain = domains.first.id!;
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormationsController>(
        builder: (context, formationsController, child) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFCECAFF), Color(0x739CAADD)],
          ),
        ),
        child: Column(children: [
          LibraryAppBar(
            title: "Les Formations",
            bgColor: Colors.transparent,
            titleColor: const Color(0xFF414243),
            onBack: () {
              Navigator.pop(context);
            },
            backColor: const Color(0xFFDCDAFF),
            backBgColor: const Color(0x516240C1),
            showNotif: false,
          ),
          Container(
            height: 110,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0x8898B5FF),
                  Color(0x256240C1)
                ], // Adjust gradient colors as needed
              ),
            ),
            child: isLoading
                ? const Center()
                : DomainsSectionOut(
                    domains: domains,
                    onSelectDomain: (id) {
                      formationsController.selectDomain(id);
                    },
                  ),
          ),
          Expanded(
            child: isLoading
                ? const Center()
                : FutureBuilder<List<Formation>>(
                    future: formationsController.loadFormations(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          List<Formation> formations = snapshot.data!;
                          return SingleChildScrollView(
                            child: Center(
                              child: Column(
                                children: List.generate(
                                  formations.length,
                                  (index) => FormationCardOutdOut(
                                    formation: formations[index],
                                    onClick: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FormationScreenOut(
                                            formation: formations[index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        default:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                      }
                    },
                  ),
          ),
        ]),
      );
    });
  }
}

class DomainsSectionOut extends StatefulWidget {
  final List<Domain> domains;
  final Function(int) onSelectDomain;
  const DomainsSectionOut(
      {super.key, required this.domains, required this.onSelectDomain});

  @override
  State<DomainsSectionOut> createState() => _DomainsSectionOutState();
}

class _DomainsSectionOutState extends State<DomainsSectionOut> {
  CarouselController ctrl = CarouselController();
  int activeIndex = 0;
  late List<Domain> domains;

  @override
  void initState() {
    super.initState();
    domains = widget.domains;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CarouselSlider.builder(
            carouselController: ctrl,
            itemCount: domains.length,
            itemBuilder: (context, index, realIndex) => List.generate(
              domains.length,
              (index) => FormationCategoryCardOut(
                categoryName: "${domains[index].title}",
              ),
            )[index],
            options: CarouselOptions(
              viewportFraction: .3,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    activeIndex = index;
                  },
                );
                widget.onSelectDomain(domains[index].id!);
              },
              enlargeCenterPage: true,
            ),
          ),
        ),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: 3,
            effect: const WormEffect(
              dotHeight: 7,
              dotWidth: 7,
              activeDotColor: Color(0xFF5E4397),
              strokeWidth: 2,
              paintStyle: PaintingStyle.stroke,
            ),
            onDotClicked: (index) {
              ctrl.animateToPage(index);
              widget.onSelectDomain(domains[index].id!);
            },
          ),
        ),
      ],
    );
  }
}

class FormationCardOutdOut extends StatelessWidget {
  final Function()? onClick;
  final Formation formation;
  const FormationCardOutdOut({
    super.key,
    required this.onClick,
    required this.formation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 160,/
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(30),
              ),
              child: SizedBox(
                height: 160,
                child: FadeInImage.assetNetwork(
                  image: "${formation.image}",
                  placeholder: "${formation.image}",
                  fit: BoxFit.fill,
                  imageErrorBuilder: (context, _, __) => Image.asset(
                    Assets.imagify("web"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${formation.title}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    formation.description!.substring(0, 50),
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  ...formation.additionalDiplomas
                      .map(
                        (diploma) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${diploma.diploma}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            Text(
                              "${diploma.price} DH",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Prix: ${formation.price} DH",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text(
                        "la durée: ${formation.period} ${formation.units}",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF687C8A),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: LibraryTextButton(
                      color: const Color(0xFF3B64CE),
                      height: 30,
                      width: 155,
                      onPressed: onClick,
                      label: "S'inscrire",
                      labelSize: 20,
                    ),
                  ),
                ]
                    .map(
                      (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: e),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormationCategoryCardOut extends StatelessWidget {
  final String categoryName;
  const FormationCategoryCardOut({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      width: 150,
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFF5E4397),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          categoryName,
          style: const TextStyle(
            color: white,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class FormationCardOut extends StatelessWidget {
  const FormationCardOut({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MyFormationCardOut extends StatelessWidget {
  final Formation formation;
  const MyFormationCardOut({
    super.key,
    required this.formation,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 110,
              width: MediaQuery.of(context).size.width - 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "${formation.image}",
                            ),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${formation.title}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${formation.domain}",
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              const Text(
                                "En cours",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const LinearProgressIndicator(
                            color: Colors.black,
                            value: .6,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "la durée: 3 Mois",
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                              Text(
                                "Restant: 2 Mois",
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

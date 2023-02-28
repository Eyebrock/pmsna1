import 'package:pmsna1/main.dart';
import 'package:pmsna1/widgets/card_planet.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final data = [
    CardPlanetData(
      title: "Ingenieria en sistemas computacionales",
      subtitle:
          "El y la Ingeniero/a en Sistemas Computacionales, tiene conocimientos de alto nivel tecnológico y científico para ser un profesionista con visión innovadora capaz de crear y proveer soluciones de software e infraestructura computacional de vanguardia en la nueva y dinámica sociedad dela era digital.",
      image: const AssetImage("assets/plan.jpg"),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/bg-1.json"),
    ),
    CardPlanetData(
      title: "Perfil de Ingreso",
      subtitle: "El y la estudiante al ingresar, deberá tener habilidades matemáticas y lógicas, capacidad de análisis y síntesis de información, habilidades de investigación, así como interés por la computación y la programación, disposición para trabajar en equipo y sentido de compromiso social.",
      image: const AssetImage("assets/perfil.jpg"),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      background: LottieBuilder.asset("assets/animation/bg-2.json"),
    ),
    CardPlanetData(
      title: "Residencias Profesionales",
      subtitle: "A partir del 80% de créditos podrá realizar residencias profesionales, en donde pondrá en práctica sus conocimientos adquiridos en organizaciones gubernamentales, privadas, así como en la industria de software.",
      image: const AssetImage("assets/mats.jpg"),
      backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/bg-3.json"),
    ),
    CardPlanetData(
      title: "Al egresar",
      subtitle: "El y la Ingeniero/a en Sistemas Computacionales cuenta un amplio campo de trabajo, dado quela industrial del software requiere profesionistas creativos con capacidades para desarrollar sistemas, diseñar y administrar redes de computadoras, diseño de sitios web, tecnologías móviles, internet, videojuegos y seguridad de información tanto en el sector público, privado o como consultor/a especializado.",
      image: const AssetImage("assets/egreso.jpg"),
      backgroundColor: Color.fromARGB(255, 7, 138, 186),
      titleColor: Color.fromARGB(255, 59, 255, 170),
      subtitleColor: Color.fromARGB(255, 250, 243, 249),
      background: LottieBuilder.asset("assets/animation/bg-3.json"),
    ),
    CardPlanetData(
      title: "Modulos de Especialidad",
      subtitle: "Tecnologias emergentes para la toma de decisiones & Gestion de datos y tecnologias e informacion",
      image: const AssetImage("assets/carrera.jpg"),
      backgroundColor: Color.fromARGB(255, 112, 29, 15),
      titleColor: Color.fromARGB(255, 206, 52, 5),
      subtitleColor: Color.fromARGB(255, 242, 238, 163),
      background: LottieBuilder.asset("assets/animation/bg-3.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardPlanet(data: data[index]);
        },
        onFinish: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  const PMSNApp()),
          );
        },
      ),
    );
  }
}
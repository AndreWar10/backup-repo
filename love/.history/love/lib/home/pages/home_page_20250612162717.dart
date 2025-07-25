import 'package:flutter/material.dart';
import 'package:love/core/fonts/app_fonts.dart';
import 'package:love/home/components/photo_carousel.dart';
import 'package:love/ui/controllers/ui_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final photos = [
      'assets/we/photo1.jpg',
      'assets/we/photo1.jpg',
      'assets/we/photo1.jpg',
    ];
    return Consumer<UiController>(
      builder: (context, uiController, __) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 36),
              Text(
                'Feliz Dia dos Namorados',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: uiController.isMobile ? 24 : 50,
                  fontFamily: AppFonts.way,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Andre ❤️ Juliana',
                style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: AppFonts.way,),
              ),
              const SizedBox(height: 30),
              PhotoCarousel(imageUrls: photos),
              const SizedBox(height: 16),
              Text(
                '💌 Feliz Dia dos Namorados, meu amor 💌 ',
                style: TextStyle(
                  fontFamily: AppFonts.way,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Hoje é o dia em que o mundo celebra o amor, mas eu celebro você todos os dias. Seu sorriso é o meu porto seguro, seu abraço é o lugar onde o tempo para, e seu amor é o presente mais bonito que a vida me deu. Não é só no Dia dos Namorados que meu coração bate mais forte por você — é em cada manhã ao acordar e em cada noite antes de dormir. É nos detalhes do dia, nas palavras que você diz sem perceber, nos gestos que me mostram que amor é cuidado, paciência e presença. Você é meu lar, meu riso mais sincero, meu melhor momento. Obrigada(o) por caminhar ao meu lado, por fazer dos dias simples os mais especiais, e por me lembrar o que é amar de verdade. Que este seja apenas mais um capítulo da nossa linda história. E que ela dure... o tempo todo que a eternidade permitir.',
                  style: TextStyle(
                    fontFamily: AppFonts.poppins600,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,),
                child: Row(
                  children: [
                    Text(
                      'Com todo o meu amor ❤️',
                      style: TextStyle(
                          fontFamily: AppFonts.poppins600,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
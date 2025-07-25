import 'package:flutter/material.dart';
import 'package:love/core/fonts/app_fonts.dart';

class TextOfLove extends StatelessWidget {
  const TextOfLove({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(
                'André.',
                style: TextStyle(
                  fontFamily: AppFonts.poppins700,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

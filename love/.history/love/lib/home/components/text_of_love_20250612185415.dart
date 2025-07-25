import 'package:flutter/material.dart';
import 'package:love/core/fonts/app_fonts.dart';

class TextOfLove extends StatelessWidget {
  const TextOfLove({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 244, 128, 255), Color.fromARGB(255, 220, 82, 255)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.red.withOpacity(0.25),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '💌 Feliz Dia dos Namorados, meu amor 💌 ',
                style: TextStyle(
                  fontFamily: AppFonts.way,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: Text(
                  'Hoje é o dia em que o mundo celebra o amor, mas eu celebro você todos os dias. Seu sorriso é o meu porto seguro, seu abraço é o lugar onde o tempo para, e seu amor é o presente mais bonito que a vida me deu. Não é só no Dia dos Namorados que meu coração bate mais forte por você, é em cada manhã ao acordar e em cada noite antes de dormir. É nos detalhes do dia, nas palavras que você diz sem perceber, nos gestos que me mostram que amor é cuidado, paciência e presença. Você é meu lar, meu riso mais sincero, meu melhor momento. Obrigado por caminhar ao meu lado, por fazer dos dias simples os mais especiais, e por me lembrar o que é amar de verdade. Que este seja apenas mais um capítulo da nossa linda história. E que ela dure... o tempo todo que a eternidade permitir.',
                  style: TextStyle(
                    fontFamily: AppFonts.poppins600,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
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
              Padding(
                padding: const EdgeInsets.only(top: 8),
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
          ),
        ),
      ),
    );
  }
}

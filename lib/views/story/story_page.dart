import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  final String? story;
  const StoryPage({super.key, this.story});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int _currentIndex = 0;

  List<Map<String, dynamic>> get _sintomasStories => [
    {
      'image': 'assets/sintomas1.png',
      'text': 'Seus principais sintomas são:\nManchas na pele do tipo',
    },
    {
      'image': 'assets/sintomas2.png',
      'text': 'ATENÇÃO!\nEssas manchas apresentam\ndiminuição da sensibilidade',
    },
    {
      'image': 'assets/sintomas3.png',
      'text': 'Mas ainda não acabou!\nAinda há outros sintomas, como:',
    },
  ];

  List<Map<String, dynamic>> get _diagnosticoStories => [
    {
      'image': 'assets/diagnostico1.png',
      'text':
          'O diagnóstico é feito na Unidade Básica de Saúde por meio de um exame chamado teste dermatoneurológico.',
    },
    {
      'image': 'assets/diagnostico2.png',
      'text': 'Esse teste identifica\nÁreas de pele com alteração de sensibilidade:',
    },
  ];

  List<Map<String, dynamic>> get _otherStories {
    switch (widget.story) {
      case 'conceito':
        return [
          {
            'image': null,
            'text': 'A hanseníase é uma doença infecciosa crônica que afeta principalmente a pele e os nervos periféricos, causada pela bactéria Mycobacterium leprae. É muito comum no Brasil, especialmente no estado do Maranhão.'
          },
          {
            'image': null,
            'text': 'Também conhecida como lepra, a hanseníase é uma das doenças mais antigas da humanidade. Apesar do estigma histórico, é totalmente curável quando diagnosticada e tratada precocemente.'
          },
          {
            'image': null,
            'text': 'A doença afeta pessoas de todas as idades, mas é mais comum em adultos. O tratamento é gratuito no Sistema Único de Saúde (SUS) e pode durar de 6 meses a 2 anos, dependendo da forma clínica.'
          },
        ];
      case 'transmissao':
        return [
          {'image': 'assets/transmissao.png', 'text': null},
        ];
      case 'tratamento':
        return [
          {
            'image': 'assets/tratamento.png',
            'text':
                'É feito por meio de uma combinação medicamentosa de antibióticos, a chamada poliquimioterapia (PQT)',
          },
        ];
      case 'conhecer':
        return [
          {
            'image': 'assets/conhecer.png',
            'text': null, // Adicione texto opcional aqui se desejar
          },
        ];
      default:
        return [];
    }
  }

  List<Map<String, dynamic>> get _storySlides {
    if (widget.story == 'sintomas') {
      return _sintomasStories;
    } else if (widget.story == 'diagnostico') {
      return _diagnosticoStories;
    } else {
      return _otherStories;
    }
  }

  void _next() {
    if (_currentIndex < _storySlides.length - 1) {
      setState(() => _currentIndex++);
    }
  }

  void _prev() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final slides = _storySlides;
    final slide = slides.isNotEmpty ? slides[_currentIndex] : null;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height:
              size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/linear.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Imagem centralizada e proporcional
              if (slide != null)
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Add top padding to prevent overlap with header
                        const SizedBox(height: 80),
                        if (slide['text'] != null && slide['image'] != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            margin: const EdgeInsets.only(bottom: 18.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              slide['text'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                height: 1.2,
                                shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
                              ),
                            ),
                          ),
                        Expanded(
                          child: Center(
                            child: slide['image'] == null
                                ? Container(
                                    padding: const EdgeInsets.all(24),
                                    child: Text(
                                      slide['text'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        height: 1.4,
                                        shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Image.asset(
                                      slide['image'],
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              // Profile picture and name
              Positioned(
                top: 24,
                left: 24,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: const AssetImage('assets/profilepic.png'),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Detect-Hans',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
                      ),
                    ),
                  ],
                ),
              ),
              // Navigation arrows
              if (_currentIndex > 0)
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: _prev,
                    ),
                  ),
                ),
              if (_currentIndex < slides.length - 1)
                Positioned(
                  right: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: _next,
                    ),
                  ),
                ),
              // Close button
              Positioned(
                top: 24,
                right: 24,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presentazione Social Media & AI',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Slideshow(),
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
          background: Color(0xFF1E1E2C),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white),
          displayMedium: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white70),
          headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 24, height: 1.5, color: Colors.white70),
        ),
      ),
    );
  }
}

class Slideshow extends StatefulWidget {
  const Slideshow({super.key});

  @override
  State<Slideshow> createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  final PageController _pageController = PageController();
  final FocusNode _focusNode = FocusNode();
  int _currentPage = 0;

  final List<Widget> _slides = [
    const TitleSlide(),
    const IntroSlide(),
    const PlatformSlide(
      platform: 'Instagram',
      description: 'Estetica, community e visual storytelling.\\nInfluencer marketing, Stories e Reels per la conversione.',
      icon: Icons.camera_alt,
      color: Colors.pinkAccent,
    ),
    const PlatformSlide(
      platform: 'TikTok',
      description: 'Intrattenimento allo stato puro.\\nL\\'algoritmo di raccomandazione e l\\'UGC (User Generated Content).',
      icon: Icons.music_note,
      color: Colors.cyanAccent,
    ),
    const PlatformSlide(
      platform: 'YouTube',
      description: 'Contenuti long-form e motore di ricerca.\\nApprofondimento, tutorial e fiducia a lungo termine.',
      icon: Icons.play_circle_fill,
      color: Colors.redAccent,
    ),
    const PlatformSlide(
      platform: 'LinkedIn',
      description: 'Il mondo del B2B.\\nPersonal branding, lead generation e networking professionale.',
      icon: Icons.work,
      color: Colors.blue,
    ),
    const AISlide(),
    const VirtualModelSlide(),
    const AnecdoteSlide(),
    const ConclusionSlide(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _nextSlide() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _prevSlide() {
    if (_currentPage > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight || event.logicalKey == LogicalKeyboardKey.space) {
        _nextSlide();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _prevSlide();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return Scaffold(
      body: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: _handleKeyEvent,
        autofocus: true,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Disabilita lo swipe su mobile per mantenere l'effetto slide click/key
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _slides.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: _nextSlide,
                  child: Container(
                    color: Colors.black,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E2C),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black87,
                                blurRadius: 20,
                                spreadRadius: 5,
                              )
                            ],
                          ),
                          padding: const EdgeInsets.all(60.0),
                          child: _slides[index],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            
            // Indicatori e controlli in basso (discreti)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white30),
                    onPressed: _currentPage > 0 ? _prevSlide : null,
                  ),
                  Text(
                    '${_currentPage + 1} / ${_slides.length}',
                    style: const TextStyle(color: Colors.white30, fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.white30),
                    onPressed: _currentPage < _slides.length - 1 ? _nextSlide : null,
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

// --- SLIDE WIDGETS ---

class TitleSlide extends StatelessWidget {
  const TitleSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.campaign, size: 100, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 30),
        Text(
          'Marketing & Social Media',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 20),
        Text(
          'Dalla pubblicità tradizionale all\\'era dell\\'Intelligenza Artificiale',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}

class IntroSlide extends StatelessWidget {
  const IntroSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('La Pubblicità nei Social Media', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 40),
        Text('• Non si tratta più solo di vendere, ma di intrattenere e creare community.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        Text("• Attenzione dell'utente ridotta: i primi 3 secondi sono fondamentali.", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        Text('• Targeting avanzato: i social sanno cosa vogliamo prima di noi.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 40),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.play_circle_outline, size: 50, color: Colors.white54),
                SizedBox(width: 15),
                Text('Placeholder: Video "L\\'Evoluzione dell\\'Ad"', style: TextStyle(color: Colors.white54, fontSize: 20)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PlatformSlide extends StatelessWidget {
  final String platform;
  final String description;
  final IconData icon;
  final Color color;

  const PlatformSlide({super.key, required this.platform, required this.description, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Icon(icon, size: 200, color: color),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(platform, style: Theme.of(context).textTheme.displayLarge?.copyWith(color: color)),
              const SizedBox(height: 30),
              ...description.split('\\n').map((line) => Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text('• $line', style: Theme.of(context).textTheme.bodyLarge),
              )),
            ],
          ),
        ),
      ],
    );
  }
}

class AISlide extends StatelessWidget {
  const AISlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('L\\'Intelligenza Artificiale nel Marketing', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 40),
        Text('Come l\\'AI sta cambiando le regole del gioco:', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 30),
        Text('1. Generazione di copy e asset visivi (Midjourney, DALL-E).', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 15),
        Text('2. Ottimizzazione delle campagne in tempo reale.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 15),
        Text('3. Personalizzazione estrema dell\\'esperienza utente.', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

class VirtualModelSlide extends StatelessWidget {
  const VirtualModelSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('I Modelli Virtuali (AI Influencers)', style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(height: 30),
              Text('• Cosa sono: Avatar generati digitalmente (CGI e AI) che operano come veri influencer.', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 15),
              Text('• Vantaggi per i Brand: Controllo totale sull\\'immagine, zero scandali, disponibilità 24/7.', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 15),
              Text('• Case Study: Aitana Lopez (agenzia The Clueless) guadagna migliaia di euro al mese come modella virtuale su Instagram.', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.smart_toy, size: 80, color: Colors.purpleAccent),
                  SizedBox(height: 10),
                  Text('Placeholder: Foto Modello AI', style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AnecdoteSlide extends StatelessWidget {
  const AnecdoteSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Aneddoti & Curiosità', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orangeAccent, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lo sapevi che...', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.orangeAccent)),
              const SizedBox(height: 20),
              Text('Lil Miquela, una delle prime virtual influencer, è stata inserita dal Time tra le 25 persone più influenti del web. Molti dei suoi follower inizialmente credevano fosse una persona reale, innescando un enorme dibattito sull\\'autenticità sui social media.', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}

class ConclusionSlide extends StatelessWidget {
  const ConclusionSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Grazie per l\\'attenzione!', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 30),
        Text('Domande?', style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 60),
        const Icon(Icons.forum, size: 100, color: Colors.blueAccent),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const SlideshowApp());
}

class SlideshowApp extends StatelessWidget {
  const SlideshowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presentazione Social Media & AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SlideshowScreen(),
      },
    );
  }
}

class SlideshowScreen extends StatefulWidget {
  const SlideshowScreen({super.key});

  @override
  State<SlideshowScreen> createState() => _SlideshowScreenState();
}

class _SlideshowScreenState extends State<SlideshowScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideContent> _slides = [
    SlideContent(
      title: 'Pubblicità sui Social Media\ne Modelli Virtuali AI',
      body: 'Esplorazione degli ecosistemi pubblicitari su TikTok, Instagram, YouTube, LinkedIn\ne l\'impatto dell\'Intelligenza Artificiale.',
      type: SlideType.title,
    ),
    SlideContent(
      title: '1. L\'Evoluzione della Pubblicità',
      body: 'Dalla TV ai Social Media.\n\n• Interattività: L\'utente non è più uno spettatore passivo.\n• Micro-targeting: Annunci mostrati in base a interessi e comportamenti.\n• Metriche precise: ROAS, CPC, CTR al posto dei vecchi indici d\'ascolto.',
      type: SlideType.bullet,
    ),
    SlideContent(
      title: '2. Come funziona l\'Ad Tech Social',
      body: 'Il motore sotto il cofano.\n\n• Aste in tempo reale (RTB).\n• L\'importanza del Pixel e dei Cookie (verso l\'era cookieless).\n• Machine Learning: gli algoritmi decidono a chi mostrare cosa per massimizzare le conversioni.',
      type: SlideType.bullet,
    ),
    SlideContent(
      title: '3. TikTok: Autenticità e Viralità',
      body: '• Formato: Video brevi, verticali, audio-first.\n• Strategia Ad: "Don\'t make ads, make TikToks".\n• Hashtag Challenges, Branded Effects e Spark Ads.\n• Aneddoto: Il caso Ocean Spray - un video organico virale che ha superato ogni campagna a pagamento.',
      type: SlideType.bullet,
    ),
    SlideContent(
      title: '4. Instagram: Estetica e Conversione',
      body: '• Formato: Feed, Stories, Reels.\n• Strategia Ad: Focus sull\'impatto visivo e Influencer Marketing.\n• Shopping integrato: dal contenuto all\'acquisto in un tap.\n• Dinamica: L\'uso dei Reels per competere con TikTok sull\'attenzione veloce.',
      type: SlideType.bullet,
    ),
    SlideContent(
      title: '5. YouTube: Storytelling e Intento',
      body: '• Formato: Video lunghi, Shorts, Bumper Ads (6s).\n• Strategia Ad: Pubblicità basata sull\'intento di ricerca (come Google Search) e brand awareness.\n• TrueView: L\'utente può saltare l\'annuncio, l\'inserzionista paga solo se l\'utente guarda.\n• Aneddoto: "Skip Ad" è diventato un elemento culturale, usato persino in campagne meta-pubblicitarie.',
      type: SlideType.bullet,
    ),
    SlideContent(
      title: '6. LinkedIn: B2B e Lead Generation',
      body: '• Formato: Sponsored Content, InMail, Lead Gen Forms.\n• Strategia Ad: Targeting professionale (qualifica, azienda, settore).\n• Costi: Più alti rispetto agli altri social, ma ROI potenziale enorme nel B2B.\n• Approccio: Condivisione di valore, whitepaper, webinar.',
      type: SlideType.bullet,
    ),
    SlideContent(
      title: '7. L\'Impatto dell\'AI: Modelli Virtuali',
      body: 'La nuova frontiera dell\'Influencer Marketing.\n\n• Modelli generati dall\'AI: Lil Miquela, Aitana Lopez.\n• Vantaggi: Controllo totale del brand, nessun rischio di scandali personali, operatività h24.\n• Creazione e mantenimento: Generazione di immagini tramite AI (Midjourney, Stable Diffusion) e gestione di community tramite LLM.',
      type: SlideType.bullet,
    ),
    SlideContent(
      title: '8. Aneddoti e Casi Studio AI',
      body: '• Aitana Lopez (Spagna): Genera migliaia di euro al mese sponsorizzando brand, creata da un\'agenzia stanca degli influencer umani.\n• Sfide Etiche: Trasparenza, deepfake e aspettative irreali di bellezza.\n• Il futuro: Pubblicità iper-personalizzata generata in tempo reale per il singolo utente.',
      type: SlideType.bullet,
    ),
    SlideContent(
      title: 'Q&A e Conclusione',
      body: 'Grazie per l\'attenzione.\n\nDomande?\n\n(Durata stimata esposizione: ~50 minuti)',
      type: SlideType.title,
    ),
  ];

  void _nextSlide() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousSlide() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CallbackShortcuts(
        bindings: <ShortcutActivator, VoidCallback>{
          const SingleActivator(LogicalKeyboardKey.arrowRight): _nextSlide,
          const SingleActivator(LogicalKeyboardKey.space): _nextSlide,
          const SingleActivator(LogicalKeyboardKey.arrowLeft): _previousSlide,
        },
        child: Focus(
          autofocus: true,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return SlideWidget(slide: _slides[index]);
                },
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: _currentPage > 0 ? _previousSlide : null,
                      color: _currentPage > 0 ? Colors.black54 : Colors.black12,
                    ),
                    Text(
                      '${_currentPage + 1} / ${_slides.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: _currentPage < _slides.length - 1 ? _nextSlide : null,
                      color: _currentPage < _slides.length - 1 ? Colors.black54 : Colors.black12,
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

enum SlideType { title, bullet }

class SlideContent {
  final String title;
  final String body;
  final SlideType type;

  SlideContent({
    required this.title,
    required this.body,
    required this.type,
  });
}

class SlideWidget extends StatelessWidget {
  final SlideContent slide;

  const SlideWidget({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24.0 : constraints.maxWidth * 0.15,
            vertical: 40.0,
          ),
          child: slide.type == SlideType.title
              ? _buildTitleSlide(isMobile)
              : _buildBulletSlide(isMobile),
        );
      },
    );
  }

  Widget _buildTitleSlide(bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          slide.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 32 : 56,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          slide.body,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 18 : 28,
            color: const Color(0xFF64748B),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBulletSlide(bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          slide.title,
          style: TextStyle(
            fontSize: isMobile ? 28 : 48,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              slide.body,
              style: TextStyle(
                fontSize: isMobile ? 18 : 26,
                color: const Color(0xFF334155),
                height: 1.8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

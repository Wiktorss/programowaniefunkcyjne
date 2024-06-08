import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generator Horoskopów',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HoroscopePage(),
    );
  }
}

class HoroscopePage extends StatefulWidget {
  const HoroscopePage({super.key});

  @override
  _HoroscopePageState createState() => _HoroscopePageState();
}

class _HoroscopePageState extends State<HoroscopePage> {
  final List<String> zodiacSigns = [
    'Baran', 'Byk', 'Bliźnięta', 'Rak', 'Lew', 'Panna',
    'Waga', 'Skorpion', 'Strzelec', 'Koziorożec', 'Wodnik', 'Ryby'
  ];

  final List<String> positiveHoroscopes = const [
    'Spotkasz przystojnego bruneta wieczorową porą.',
    'Gratulacje! Wygrałeś Big Milka!',
    'Tajemniczy wielbiciel wkrótce da ci jakiś znak.',
    'Rozpoczniesz biznes za milion złotych i staniesz się bardzo bogaty.',
    'Twoje nazwisko zacznie być cenioną marką',
    'Twój przełożony zauważy Cię i zaprosi z powrotem do swojego projektu',
    'nie czekaj - działaj',
    'Dzisiaj otrzymasz wzruszającą wiadomość.',
    'Otrzymasz od prezesa pakiet udziałów',
    'Wygrasz na loterii. Twoje zwycięskie liczby to 8, 3, 4, 7, 13, 67. ',
    'Dzisiaj kady kod będzie Ci się kompilował.',
    'Twoje marzenie się spełni!'
  ];

  final List<String> negativeHoroscopes = const [
    'UWAGA! Ktoś Cię obserwuje!',
    'uważaj, już niedługo mogą spotkać Cię kłopoty.',
    'Twój pracodawca szuka kogoś na Twoje miejsce.',
    'Czeka Cię duzo debugowania kodu!',
    'HTML zostanie uznany za język programowania.',
    'Będziesz ociężały umysłowo i z trudem będziesz uczyć się najprostszych czynności.',
    'Rozpoczniesz biznes za milion złotych i staniesz się bardzo BIEDNY!',
    'Nadmiar napojów procentowych może szybko zniszczyć Twoją opinię ',
    'możesz spaść nisko w hierarchii firmowej, albo co gorsze, nawet konkurencja nie będzie Cię chciała zatrudnić',
    'Prędzej zostaniesz zwykłym seniorem, niz osiągniesz to w IT',
    'Ona to wie, uciekaj!',
    'On to wie, uciekaj!'
  ];

  final Map<String, double> positiveProbabilities = {
    'Baran': 0.5,
    'Byk': 0.6,
    'Bliźnięta': 0.95, // Jestem bliźniakiem :)
    'Rak': 0.5,
    'Lew': 0.7,
    'Panna': 0.4,
    'Waga': 0.6,
    'Skorpion': 0.5,
    'Strzelec': 0.65,
    'Koziorożec': 0.5,
    'Wodnik': 0.55,
    'Ryby': 0.45,
  };

  final Random random = Random();

  String? selectedSign;
  String _horoscopeText = '';

  final List<String> weekDays = [
    'Poniedziałek', 'Wtorek', 'Środa', 'Czwartek', 'Piąteczek', 'Sobota', 'Niedziela'
  ];

  String getRandomHoroscope(bool isPositive) =>
      (isPositive ? positiveHoroscopes : negativeHoroscopes)
          .elementAt(random.nextInt(isPositive ? positiveHoroscopes.length : negativeHoroscopes.length));

  bool isPositiveHoroscope(String zodiacSign) =>
      random.nextDouble() < positiveProbabilities[zodiacSign]!;

  String generateHoroscope(String? zodiacSign) {
    if (zodiacSign == null) return '';
    final isPositive = isPositiveHoroscope(zodiacSign);
    final horoscope = getRandomHoroscope(isPositive);
    return '''
      Twój horoskop na dzisiaj (${weekDays[DateTime.now().weekday - 1]}):
      $zodiacSign: $horoscope
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generator Horoskopów'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                value: selectedSign,
                hint: const Text('Wybierz swój znak zodiaku'),
                items: zodiacSigns.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSign = newValue;
                    _horoscopeText = generateHoroscope(selectedSign);
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _horoscopeText = generateHoroscope(selectedSign);
                  });
                },
                child: const Text('Generuj horoskop'),
              ),
              const SizedBox(height: 20),
              Text(
                _horoscopeText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avalia Coração',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isPulsing = false;
  double heartSize = 100;

  @override
  void initState() {
    super.initState();
    _startPulseAnimation();
  }

  void _startPulseAnimation() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        isPulsing = true;
      });

      Timer(const Duration(seconds: 1), () {
        setState(() {
          isPulsing = false;
        });
      });

      if (heartSize == 120) {
        heartSize = 100;
      } else {
        heartSize = 120;
      }
    });
  }

  void _navigateToSecondPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Avalia Coração',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              width: heartSize,
              height: heartSize,
              child: isPulsing
                  ? const Icon(
                      Icons.favorite,
                      size: 120,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite,
                      size: 100,
                      color: Colors.red,
                    ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Seu Aplicativo de Saúde Cardíaca',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: FloatingActionButton.extended(
          onPressed: _navigateToSecondPage,
          backgroundColor: Colors.deepPurple,
          label: const Text(
            'Avançar',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Avalia Coração',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Esse é um aplicativo voltado à análise cardíaca. Com o objetivo de prever a existência de doença cardiovascular. Você deverá responder a um questionário para que se possa fazer as devidas análises.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 16),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.red,
                    label: const Text(
                      'Voltar',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 16),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QuestionarioPage()),
                      );
                    },
                    backgroundColor: Colors.purple,
                    label: const Text(
                      'Começar',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionarioPage extends StatefulWidget {
  const QuestionarioPage({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionarioPageState createState() => _QuestionarioPageState();
}

class _QuestionarioPageState extends State<QuestionarioPage> {
  int? idade;
  String? genero;
  double? altura;
  double? peso;
  String? colesterol;
  String? glicose;
  bool? consomeAlcool;
  bool? fuma;
  bool? praticaExercicio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Questionário',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Diga a sua idade:'
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  idade = int.tryParse(value);
                });
              },
            ),
            _buildDropdownFormField('Qual o seu gênero?', ['Masculino', 'Feminino'], (String? value) {
              setState(() {
                genero = value;
              });
            }),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Diga sua altura (m):',
                helperText: 'Ex: 1.70',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  altura = double.tryParse(value);
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Diga o seu peso (kg):',
                helperText: 'Ex: 80.0',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  peso = double.tryParse(value);
                });
              },
            ),
            _buildDropdownFormField('Como está a sua taxa de colesterol?', ['Normal', 'Acima do Normal', 'Muito Acima do Normal'], (String? value) {
              setState(() {
                colesterol = value;
              });
            }),
            _buildDropdownFormField('Como está a taxa da sua glicose?', ['Normal', 'Acima do Normal', 'Muito Acima do Normal'], (String? value) {
              setState(() {
                glicose = value;
              });
            }),
            _buildDropdownFormField('Você consome álcool?', ['Não', 'Sim'], (String? value) {
              setState(() {
                consomeAlcool = value == 'Sim';
              });
            }),
            _buildDropdownFormField('Você tem o costume de fumar?', ['Não', 'Sim'], (String? value) {
              setState(() {
                fuma = value == 'Sim';
              });
            }),
            _buildDropdownFormField('Pratica algum exercício físico?', ['Não', 'Sim'], (String? value) {
              setState(() {
                praticaExercicio = value == 'Sim';
              });
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultadoPage(
                      idade: idade ?? 0,
                      genero: genero ?? '',
                      altura: altura ?? 0.0,
                      peso: peso ?? 0.0,
                      colesterol: colesterol ?? '',
                      glicose: glicose ?? '',
                      consomeAlcool: consomeAlcool ?? false,
                      fuma: fuma ?? false,
                      praticaExercicio: praticaExercicio ?? false,
                    ),
                  ),
                );
              },
              child: const Text('Enviar Respostas'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownFormField(String labelText, List<String> options, void Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: labelText),
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class ResultadoPage extends StatelessWidget {
  final int idade;
  final String genero;
  final double altura;
  final double peso;
  final String colesterol;
  final String glicose;
  final bool consomeAlcool;
  final bool fuma;
  final bool praticaExercicio;

  const ResultadoPage({
    Key? key,
    required this.idade,
    required this.genero,
    required this.altura,
    required this.peso,
    required this.colesterol,
    required this.glicose,
    required this.consomeAlcool,
    required this.fuma,
    required this.praticaExercicio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool temDoencaCardiovascular = false;
    double probabilidade = 0.0;

    
    if (idade > 50) {
      probabilidade += 0.2;
    }

    if (genero == 'Feminino') {
      probabilidade += 0.1;
    }

    double imc = peso / (altura * altura);
    if (imc >= 25) {
      probabilidade += 0.15;
    }

    if (colesterol == 'Normal') {
      probabilidade += 0.05;
    } else if (colesterol == 'Acima do Normal') {
      probabilidade += 0.15;
    } else if (colesterol == 'Muito Acima do Normal') {
      probabilidade += 0.3;
    }

    if (glicose == 'Normal') {
      probabilidade += 0.05;
    } else if (glicose == 'Acima do Normal') {
      probabilidade += 0.15;
    } else if (glicose == 'Muito Acima do Normal') {
      probabilidade += 0.3;
    }

    if (consomeAlcool) {
      probabilidade += 0.15;
    }

    if (fuma) {
      probabilidade += 0.3;
    }

    if (praticaExercicio) {
      probabilidade -= 0.2;
    }

  
    if (probabilidade >= 0.7) {
      temDoencaCardiovascular = true;
    }

    String resultado = temDoencaCardiovascular
        ? 'Alta probabilidade de doença cardiovascular'
        : 'Baixa probabilidade de doença cardiovascular';

    int porcentagem = (probabilidade * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resultados',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              resultado,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Probabilidade: $porcentagem%',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar ao Questionário'),
            ),
          ],
        ),
      ),
    );
  }
}
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
  // ignore: library_private_types_in_public_api
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

class QuestionarioPage extends StatelessWidget {
  const QuestionarioPage({Key? key});

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
            ),
            _buildDropdownFormField('Qual o seu gênero?', ['Feminino', 'Masculino']),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Diga sua altura (m):',
                helperText: 'Ex: 1.70',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Diga o seu peso (kg):',
                helperText: 'Ex: 80.0',
              ),
            ),
            _buildDropdownFormField('Como está a sua taxa de colesterol?', ['Normal', 'Acima do Normal', 'Muito Acima do Normal']),
            _buildDropdownFormField('Como está a taxa da sua glicose?', ['Normal', 'Acima do Normal', 'Muito Acima do Normal']),
            _buildDropdownFormField('Você consome álcool?', ['Não', 'Sim']),
            _buildDropdownFormField('Você tem o costume de fumar?', ['Não', 'Sim']),
            _buildDropdownFormField('Pratica algum exercício físico?', ['Não', 'Sim']),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text('Enviar Respostas'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownFormField(String labelText, List<String> options) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: labelText),
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (String? value) {
      },
    );
  }
}

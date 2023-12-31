import 'package:flutter/material.dart';
import 'package:evently/models/quiz_answers.dart';
import 'main_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final questions = [
    {
      'question': 'Czy chcesz spędzić czas z dziećmi?',
      'answers': [
        'Tak',
        'Nie',
      ]
    },
    {
      'question': 'Czy preferujesz warsztaty?',
      'answers': [
        'Tak',
        'Nie',
      ]
    },
    {
      'question': 'Czy preferujesz spędzenie czasu z muzyką?',
      'answers': [
        'Tak',
        'Nie',
      ]
    },
  ];

  int questionIndex = 0;
  List<bool> isSelected = [false, false, false, false];
  List<bool> answers = [];
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz preferencji aktywności",
            style: TextStyle(
                fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFF73AEF5),
              Color(0xFF61A4F1),
              Color(0xFF478DE0),
              Color(0xFF398AE5),
            ])),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          OutlinedButton(
            onPressed: _pickDate,
            style: _buttonStyle(),
            child: Text(
                "Data: ${selectedDate.toLocal().toIso8601String().substring(0, 10)}",
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _dateButtons())),
          const SizedBox(height: 20),
          Text((questions[questionIndex]['question'] as String),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 20),
          ..._answersList(),
          const SizedBox(height: 20),
          _navigationButtons(),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  uncheckAll() {
    setState(() {
      isSelected = List.filled(isSelected.length, false);
      _isAnswerSelected = false;
    });
  }

  bool _isAnswerSelected = false;
  List<Widget> _answersList() =>
      (questions[questionIndex]['answers'] as List<String>)
          .asMap()
          .entries
          .map((entry) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3))
                  ]),
              child: CheckboxListTile(
                  title: Text(entry.value,
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  value: isSelected[entry.key],
                  onChanged: (bool? value) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        if (i != entry.key) {
                          isSelected[i] = false;
                        }
                      }
                      isSelected[entry.key] = value!;
                      _isAnswerSelected = value;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.blue)))
          .toList();

  ButtonStyle _buttonStyle() => OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      side: const BorderSide(color: Colors.blue),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20));

  List<Widget> _dateButtons() => ["Dzisiaj", "Piątek", "Sobota"]
      .map((label) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: OutlinedButton(
                onPressed: () => _setDate(label),
                style: _buttonStyle(),
                child: Text(label,
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.bold))),
          ))
      .toList();

  Widget _navigationButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (questionIndex > 0)
            ElevatedButton(
                onPressed: () {
                  setState(() => questionIndex--);
                  answers.removeLast();
                  uncheckAll();
                },
                child: const Text("Wróć",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.bold))),
          ElevatedButton(
              onPressed: _isAnswerSelected ? _nextQuestionOrScreen : null,
              child: Text(
                  questionIndex < questions.length - 1
                      ? "Następne pytanie"
                      : "Dalej",
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.bold)))
        ],
      );

  _nextQuestionOrScreen() {
    if (answers.length > 2) {
      answers.removeAt(0);
    }
    answers.add(isSelected[0]);

    if (questionIndex == 0 && isSelected[0]) {
      QuizAnswers quizAnswers = QuizAnswers(
        spendTimeWithKids: answers[0],
        workshops: false,
        listenToMusic: false,
      );

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainScreen(
              selectedDate: selectedDate, quizAnswers: quizAnswers)));
      return;
    }

    if (questionIndex < questions.length - 1) {
      uncheckAll();
      setState(() => questionIndex++);
    } else {
      QuizAnswers quizAnswers = QuizAnswers(
        spendTimeWithKids: answers[0],
        workshops: answers[1],
        listenToMusic: answers[2],
      );

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainScreen(
              selectedDate: selectedDate, quizAnswers: quizAnswers)));
    }
  }

  _pickDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 30)));
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  _setDate(String label) {
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 0, 0, 0, 0, 0);
    setState(() {
      if (label == "Dzisiaj") {
        selectedDate = now;
      } else if (label == "Piątek") {
        selectedDate = now.add(Duration(days: (5 - now.weekday + 7) % 7));
      } else if (label == "Sobota") {
        selectedDate = now.add(Duration(days: (6 - now.weekday + 7) % 7));
      }
      // selectedDate time must be set to 0:00:00 to compare it with events dates
      selectedDate = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, 0, 0, 0, 0, 0);
    });
  }
}

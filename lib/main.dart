import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizApp(),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'What language is Flutter written in?',
      'answers': [
        {'text': 'Java', 'score': 0},
        {'text': 'Dart', 'score': 1},
        {'text': 'JavaScript', 'score': 0},
        {'text': 'Python', 'score': 0},
      ],
    },
    {
      'questionText': 'What does SDK stand for in Flutter?',
      'answers': [
        {'text': 'Software Development Kit', 'score': 1},
        {'text': 'System Development Kit', 'score': 0},
        {'text': 'Source Development Kit', 'score': 0},
        {'text': 'Script Development Kit', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the primary programming language used for Android app development?',
      'answers': [
        {'text': 'Java', 'score': 1},
        {'text': 'Kotlin', 'score': 0},
        {'text': 'Dart', 'score': 0},
        {'text': 'C++', 'score': 0},
      ],
    },
    {
      'questionText': 'What does API stand for?',
      'answers': [
        {'text': 'Application Programming Interface', 'score': 1},
        {'text': 'Advanced Program Integration', 'score': 0},
        {'text': 'Automated Program Interaction', 'score': 0},
        {'text': 'Application Process Interface', 'score': 0},
      ],
    },
    {
      'questionText': 'Which programming language is known for its use in machine learning and data analysis?',
      'answers': [
        {'text': 'Java', 'score': 0},
        {'text': 'Python', 'score': 1},
        {'text': 'C#', 'score': 0},
        {'text': 'JavaScript', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the purpose of the "git clone" command in Git?',
      'answers': [
        {'text': 'Create a new Git repository', 'score': 0},
        {'text': 'Copy a repository into a new directory', 'score': 1},
        {'text': 'Delete a Git repository', 'score': 0},
        {'text': 'Merge branches in a repository', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the significance of the keyword "final" in Dart?',
      'answers': [
        {'text': 'Declares a variable that can be modified later', 'score': 0},
        {'text': 'Declares a constant variable', 'score': 1},
        {'text': 'Indicates the start of a function', 'score': 0},
        {'text': 'Specifies the access level of a class', 'score': 0},
      ],
    },
    {
      'questionText': 'Which of the following is a relational database management system?',
      'answers': [
        {'text': 'MongoDB', 'score': 0},
        {'text': 'SQLite', 'score': 1},
        {'text': 'Firebase', 'score': 0},
        {'text': 'Redis', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the primary purpose of the "setState" method in Flutter?',
      'answers': [
        {'text': 'Update the state of a widget and trigger a rebuild', 'score': 1},
        {'text': 'Define the initial state of a widget', 'score': 0},
        {'text': 'Retrieve the current state of a widget', 'score': 0},
        {'text': 'Delete the state of a widget', 'score': 0},
      ],
    },
    {
      'questionText': 'In object-oriented programming, what is encapsulation?',
      'answers': [
        {'text': 'A programming language feature for inheritance', 'score': 0},
        {'text': 'A way to bundle data and methods that operate on that data', 'score': 1},
        {'text': 'A mechanism for code organization', 'score': 0},
        {'text': 'A form of code optimization', 'score': 0},
      ],
    },
    // Add more questions as needed
  ];

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _questionIndex += 1;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programming Quiz App'),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
        questionIndex: _questionIndex,
        questions: _questions,
        answerQuestion: _answerQuestion,
      )
          : Result(_score, _resetQuiz),
    );
  }
}

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, Object>> questions;
  final Function(int) answerQuestion;

  Quiz({
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText'] as String),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
            text: answer['text'] as String,
            onPressed: () => answerQuestion(answer['score'] as int),
          );
        }).toList(),
      ],
    );
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  Answer({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int score;
  final VoidCallback onReset;

  Result(this.score, this.onReset);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your Score: $score',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onReset,
            child: Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}

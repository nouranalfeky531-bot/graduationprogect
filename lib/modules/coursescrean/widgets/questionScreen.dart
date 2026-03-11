import 'package:flutter/material.dart';

class Question extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
    );
  }
}





// كلاس النموذج (Model) لتمثيل السؤال الواحد
class Questionmodel {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex; // index الإجابة الصحيحة (يبدأ من 0)

  Questionmodel({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuestionsHomePage extends StatefulWidget {


  @override
  State<QuestionsHomePage> createState() => _QuestionsHomePageState();
}

class _QuestionsHomePageState extends State<QuestionsHomePage> {
  // قائمة الأسئلة
  final List<Questionmodel> _questions = [
    Questionmodel(
      questionText: 'what is the basic unit of life   ؟',
      options: [' others', ' the cell', 'call', 'heart'],
      correctAnswerIndex: 1,
    ),
    Questionmodel(
      questionText: 'Name the organ that pumps blood throughout the human body ',
      options: ['the skin', 'the heart', 'cell', 'other'],
      correctAnswerIndex: 1,
    ),
    Questionmodel(
      questionText: ' what is the largest organ in human body    ؟',
      options: [
        'DNA  ',
        ' the skin  ',
        'cell  ',
       ' heart  '
      ],
      correctAnswerIndex: 1,
    ),
    Questionmodel(
      questionText: '    what is the process by which plants make their food ؟',
      options: [
        ' heart',
        'cell ',
        ' photosynthesis',
        '  DNA'
      ],
      correctAnswerIndex: 2,
    ),
    // يمكنك إضافة المزيد من الأسئلة هنا...
  ];

  int _currentQuestionIndex = 0;
  String? _feedbackMessage; // رسالة التغذية الراجعة (صح/غلط)
  bool _isAnswered = false; // هل تمت الإجابة على السؤال الحالي؟

  // دالة للتحقق من الإجابة
  void _checkAnswer(int selectedIndex) {
    // إذا كان قد تمت الإجابة مسبقاً، لا تفعل شيئاً
    if (_isAnswered) return;

    setState(() {
      _isAnswered = true;
      if (selectedIndex ==
          _questions[_currentQuestionIndex].correctAnswerIndex) {
        _feedbackMessage = '✅ true!';
      } else {
        _feedbackMessage =
        '❌ false!correct  is: ${_questions[_currentQuestionIndex]
            .options[_questions[_currentQuestionIndex].correctAnswerIndex]}';
      }
    });
  }

  // دالة للانتقال إلى السؤال التالي
  void _nextQuestion() {
    setState(() {
      // التأكد من أننا لم نصل إلى نهاية الأسئلة
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _feedbackMessage = null;
        _isAnswered = false;
      } else {
        // إذا انتهت الأسئلة، يمكن عرض رسالة أو إعادة تعيين
        _showDialog();
      }
    });
  }

  // دالة لعرض حوار عند الانتهاء
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("good"),
          content: const Text('You  answered  all question'),
          actions: [
            TextButton(
              child: Text(" again"),
              onPressed: () {
                setState(() {
                  _currentQuestionIndex = 0;
                  _feedbackMessage = null;
                  _isAnswered = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على السؤال الحالي
    Questionmodel currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
        appBar: AppBar(
          title: const Text('📝  test'),
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // عرض رقم السؤال
            Text(
              'question ${_currentQuestionIndex + 1} to ${_questions.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // عرض نص السؤال
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                currentQuestion.questionText,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),

            // عرض خيارات الإجابة
            ...List.generate(currentQuestion.options.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: () => _checkAnswer(index),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    currentQuestion.options[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // عرض رسالة التغذية الراجعة (صح/غلط)
            if (_feedbackMessage != null)
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: _feedbackMessage!.contains('✅')
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _feedbackMessage!.contains('✅')
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                child: Text(
                  _feedbackMessage!,
                  style: TextStyle(
                    fontSize: 18,
                    color: _feedbackMessage!.contains('✅')
                        ? Colors.green.shade900
                        : Colors.red.shade900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            const Spacer(),

            // زر الانتقال للسؤال التالي (يظهر فقط بعد الإجابة)
            if (_isAnswered)
              ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  _currentQuestionIndex < _questions.length - 1
                      ? ' next question ⬅️'
                      : ' finish 🏁',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


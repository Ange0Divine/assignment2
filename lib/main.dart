
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tab Navigation',
      theme: ThemeData.dark(),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tab Navigation'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.lock)),
                Tab(icon: Icon(Icons.person_add)),
                Tab(icon: Icon(Icons.calculate)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SignInScreen(),
              SignUpScreen(),
              CalculatorScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username='Divine', _password='abcde';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) => _username = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('SignIn'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Call your API or authentication logic here
                    print('Username: $_username, Password: $_password');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username='Divine', _password='abcde', _confirmPassword='abcde';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) => _username = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onSaved: (value) => _confirmPassword = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('SignUp'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Call your API or authentication logic here
                    print('Username: $_username, Password: $_password');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleCalculator();
  }
}

class SimpleCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Calculation(),
      theme: ThemeData.dark(),
    );
  }
}

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}





  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  title: 'Calculator',
  home: Calculation(),
  theme: ThemeData.dark()
  );
  }




  class _CalculationState extends State<Calculation> {
  List<dynamic> inputList = [0];
  String output = '0';

  void _handleClear() {
  setState(() {
  inputList = [0];
  output = '0';
  });
  }

  void _handlePress(String input) {
  setState(() {
  if (_isOperator(input)) {
  if (inputList.last is int) {
  inputList.add(input);
  output += input;
  }
  } else if (input == '=') {
  while (inputList.length > 2) {
  int firstNumber = inputList.removeAt(0) as int;
  String operator = inputList.removeAt(0);
  int secondNumber = inputList.removeAt(0) as int;
  int partialResult = 0;

  if (operator == '+') {
  partialResult = firstNumber + secondNumber;
  } else if (operator == '-') {
  partialResult = firstNumber - secondNumber;
  } else if (operator == '*') {
  partialResult = firstNumber * secondNumber;
  } else if (operator == '/') {
  partialResult = firstNumber ~/ secondNumber;
  // Protect against division by zero
  if(secondNumber == 0) {
  partialResult = firstNumber;
  }
  }

  inputList.insert(0, partialResult);
  }

  output = '${inputList[0]}';
  } else {
  int? inputNumber = int.tryParse(input);
  if (inputNumber != null) {
  if (inputList.last is int && !_isOperator(output[output.length - 1])) {
  int lastNumber = (inputList.last as int);
  lastNumber = lastNumber * 10 + inputNumber;
  inputList.last = lastNumber;

  output = output.substring(0, output.length - 1) + lastNumber.toString();
  } else {
  inputList.add(inputNumber);
  output += input;
  }
  }
  }
  });
  }

  bool _isOperator(String input) {
  if (input == "+" || input == "-" || input == "*" || input == "/") {
  return true;
  }
  return false;
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
      title: Text(
          "CALCULATOR",
      style: TextStyle(color:Colors.amberAccent))),
  body: Container(
  child: Column(
  children: <Widget>[
  Container(
  child: TextField(
  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  textAlign: TextAlign.right,
  decoration: InputDecoration(border: InputBorder.none),
  controller: TextEditingController()..text = output,
  readOnly: true,
  ),
  ),
  Expanded(
  child: GridView.count(
  crossAxisCount: 4,
  children: <Widget>[
  for(var i = 0; i <= 9; i++)
  TextButton(
  child: Text("$i", style: TextStyle(fontSize: 20)),
  onPressed: () => _handlePress("$i"),
  ),
  TextButton(
  child: Text("C", style: TextStyle(fontSize: 20)),
  onPressed: _handleClear,
  ),
  TextButton(
  child: Text("+", style: TextStyle(fontSize: 20)),
  onPressed: () => _handlePress("+"),
  ),
  TextButton(
  child: Text("-", style: TextStyle(fontSize: 20)),
  onPressed: () => _handlePress("-"),
  ),
  TextButton(
  child: Text("*", style: TextStyle(fontSize: 20)),
  onPressed: () => _handlePress("*"),
  ),
  TextButton(
  child: Text("/", style: TextStyle(fontSize: 20)),
  onPressed: () => _handlePress("/"),
  ),
  TextButton(
  child: Text("=", style: TextStyle(fontSize: 20)),
  onPressed: () => _handlePress("="),
  ),
  ],
  ),
  )
  ],
  ),
  ),
  );
  }
  }

  // Your calculator logic here
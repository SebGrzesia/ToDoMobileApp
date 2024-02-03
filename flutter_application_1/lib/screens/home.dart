import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _nameController = TextEditingController();
  bool _isNameEntered = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _checkIfNameIsEntered();
  }

  Future<void> _checkIfNameIsEntered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('user_name') ?? '';

    setState(() {
      _isNameEntered = userName.isNotEmpty;
    });
  }

  Future<void> _saveNameToSharedPreferences(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', name);
    setState(() {
      _isNameEntered = true;
    });
  }

  Future<void> _clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      _isNameEntered = false;
      _nameController.clear();
      _errorMessage = '';
    });
  }

  void _validateAndSaveName() {
    String enteredName = _nameController.text.trim();

    if (enteredName.length >= 3) {
      _saveNameToSharedPreferences(enteredName);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TodoScreen(userName: enteredName)),
      );
    } else {
      setState(() {
        _errorMessage = 'Name must be 3 characters or longer';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGray,
      appBar: AppBar(
        backgroundColor: colorGray,
        title: Text(
          'Task List App',
          style: TextStyle(color: colorBlack),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isNameEntered) ...[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter your firstname',
                  hintStyle: TextStyle(color: colorBlack),
                  errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _validateAndSaveName,
                child: Text('Submit'),
              ),
            ],
            if (_isNameEntered) ...[
              ElevatedButton(
                onPressed: _clearSharedPreferences,
                child: Text('Clear SharedPreferences'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

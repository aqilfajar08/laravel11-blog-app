// STRINGS
import 'package:flutter/material.dart';

const baseURL = 'http://127.0.0.1:8000/api/login';
const loginURL = baseURL + '/login';
const registerURL = baseURL + '/register';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/user';
const postsURL = baseURL + '/posts';
const commentsURL = baseURL + '/comments';

// ERROR
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, please try again!';

// Input Decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    contentPadding: EdgeInsets.all(10),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(width: 1, color: Colors.black)),
  );
}

// button

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
          (states) => Colors.blue,
        ),
        padding: MaterialStateProperty.resolveWith(
          (states) => EdgeInsets.symmetric(vertical: 10),
        ),
      ),
      onPressed: () => onPressed());
}

//loginRegisterHint

Row kLoginRegisterHint(String text, String label, Function onTap ){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(
          label,
          style: TextStyle(color: Colors.blue),
        ),
        onTap: () {},
      )
    ],
  );
}

import 'package:flutter/material.dart';
import 'LoginAndSignupScreenViewModel.dart';

class LoginAndSignupScreen extends StatelessWidget {
    LoginAndSignupScreen({@required this.viewModel});

  final LoginAndSignupScreenViewModelType viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter login demo'),
        ),
        body: Stack(
          children: <Widget>[
            formFields(),
            circularProgressIndicator(),
          ],
        ));
  }

  Widget circularProgressIndicator() {
    return StreamBuilder<bool>(
      stream: viewModel.isLoading.stream,
      initialData: false,
      builder: (context, snapshot) {
        return snapshot.data ? Center(child: CircularProgressIndicator()) : noView();
      }
    );
  }

  Widget noView() {
    return Container(height: 0, width: 0);
  }

//  void _showVerifyEmailSentDialog() {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Verify your account"),
//          content:
//              new Text("Link to verify account has been sent to your email"),
//          actions: <Widget>[
//            new FlatButton(
//              child: new Text("Dismiss"),
//              onPressed: () {
//                toggleFormMode();
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

  Widget formFields() {
        return StreamBuilder<FormType>(
          stream: viewModel.formType.stream,
          initialData: FormType.login,
          builder: (context, snapshot) {
            List<Widget> formFields = [emailField(),
                                       passwordField(),
                                       toggleButton(),
                                       submitButton(),
                                       errorMessage()];
            if (snapshot.data == FormType.signUp) {
              List<Widget> nameFields = [firstNameField(), lastNameField()];
              formFields.insertAll(0, nameFields);
            }
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Form(
                child: ListView(
                  shrinkWrap: true,
                  children: formFields,
                ),
              ));
          }
        );
  }

  Widget errorMessage() {
    return StreamBuilder<String>(
      stream: viewModel.errorMessage.stream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Text(
                  snapshot.data,
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.red,
                      height: 1.0,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
              )
          );
        } else {
          return noView();
        }
      }
    );
  }

    Widget firstNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            hintText: 'First Name',
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            )),
        onChanged: (value) => viewModel.firstName = value.trim(),
      ),
    );
  }

  Widget lastNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            hintText: 'Last Name',
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            )),
        onChanged: (value) => viewModel.lastName = value.trim(),
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Email',
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        onChanged: (value) => viewModel.email = value.trim(),
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Password',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        onChanged: (value) => viewModel.password = value.trim(),
      ),
    );
  }

  Widget toggleButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: FlatButton(
                child: Text(
                    viewModel.isLoginForm() ? 'Create an account' : 'Have an account? Sign in',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
                onPressed: viewModel.toggleView
            )
    );
  }

  Widget submitButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: Text(viewModel.isLoginForm() ? 'Login' : 'Create account',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: viewModel.onSubmit,
          ),
        )
      );
  }
}
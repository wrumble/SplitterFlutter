import 'package:flutter/material.dart';
import 'LoginAndSignupScreenViewModel.dart';

class LoginAndSignupScreen extends StatefulWidget {
  LoginAndSignupScreen({@required this.viewModel});

  final LoginAndSignupScreenViewModelType viewModel;

  @override
  State<StatefulWidget> createState() => new _LoginAndSignupScreenState();
}

class _LoginAndSignupScreenState extends State<LoginAndSignupScreen> {
  final _formKey = new GlobalKey<FormState>();

  String _firstName;
  String _lastName;
  String _email;
  String _password;

  bool _isLoginForm;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() {
    final user = new User(id)
  }

  @override
  void initState() {
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Splitter'),
        ),
        body: Stack(
          children: <Widget>[
            _showForm(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    return StreamBuilder<bool>(
      initialData: false,
      stream: widget.viewModel.isLoading,
      builder: (context, snapshot) {
        return Visibility(
          child: Center(child: CircularProgressIndicator()),
          visible: snapshot.data
        );
      }
    );
  }

  Widget _showForm() {
    bool notNull(Object o) => o != null;
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _isLoginForm ? null : showFirstNameInput(),
              _isLoginForm ? null : showLastNameInput(),
              showEmailInput(),
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(),
              showErrorMessage(),
            ].where(notNull).toList(),
          ),
        ));
  }

  Widget showErrorMessage() {
    return StreamBuilder<String>(
      stream: widget.viewModel.errorText,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Text(
              snapshot.data,
              style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.red,
                  height: 1.0,
                  fontWeight: FontWeight.w300
              ),
          );
        } else {
          return SizedBox.shrink();
        }
      }
    );
  }

    Widget showFirstNameInput() {
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
        validator: (value) => value.isEmpty ? 'First Name can\'t be empty' : null,
        onSaved: (value) => _firstName = value.trim(),
      ),
    );
  }

  Widget showLastNameInput() {
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
        validator: (value) => value.isEmpty ? 'Last Name can\'t be empty' : null,
        onSaved: (value) => _lastName = value.trim(),
      ),
    );
  }

  Widget showEmailInput() {
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
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
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
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return FlatButton(
        child: Text(
            _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: toggleFormMode);
  }

  Widget showPrimaryButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: Text(_isLoginForm ? 'Login' : 'Create account',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        )
      );
  }

   @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }
}
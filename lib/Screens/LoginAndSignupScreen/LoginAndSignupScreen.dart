import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:splitter/Widgets/LoginErrorMessage.dart';
import 'package:splitter/Widgets/LoginTextField.dart';
import 'package:splitter/Widgets/NullWidget.dart';
import 'package:splitter/Widgets/PrimaryButton.dart';
import 'package:splitter/Widgets/SecondaryButton.dart';
import 'package:splitter/Widgets/WaitingIndicator.dart';
import 'package:splitter/Screens/LoginAndSignupScreen/LoginAndSignupScreenViewModel.dart';

class LoginAndSignupScreen extends StatelessWidget {
  LoginAndSignupScreen({@required this.viewModel});

  final LoginAndSignupScreenViewModelType viewModel;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        backgroundColor: Colors.white,
        appBar: PlatformAppBar(
          android: (_) => MaterialAppBarData(centerTitle: true),
          title: PlatformText('Splitter', 
                      style: TextStyle(color: Colors.white, 
                                       fontSize: 26
                             )
                ),
        ),
        body: Stack(
          children: <Widget>[
            formFields(),
            waitingIndicator(),
          ],
        ));
  }

  Widget waitingIndicator() {
    return StreamBuilder<bool>(
      stream: viewModel.isLoading.stream,
      initialData: false,
      builder: (context, snapshot) {
        return snapshot.data ? WaitingIndicator() : NullWidget();
      }
    );
  }

  Widget formFields() {
        return StreamBuilder<FormType>(
          stream: viewModel.formType.stream,
          initialData: FormType.login,
          builder: (context, snapshot) {
            List<Widget> formFields = [emailField(),
                                       passwordField(),
                                       submitButton(),
                                       toggleButton(),
                                       errorMessage()];
            if (snapshot.data == FormType.signUp) {
              List<Widget> nameFields = [firstNameField(), lastNameField()];
              formFields.insertAll(2, nameFields);
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
    return LoginErrorMessage(stream: viewModel.errorMessage.stream);
  }

  Widget firstNameField() {
    Function(String) onChanged = (value) => viewModel.user.firstName = value.trim();
      return LoginTextField(Icons.person,
                            'First Name',
                            onChanged,
                            textCapitalization: TextCapitalization.words);
  }

  Widget lastNameField() {
    Function(String) onChanged = (value) => viewModel.user.lastName = value.trim();
    return LoginTextField(Icons.person,
                          'Last Name',
                          onChanged,
                          textCapitalization: TextCapitalization.words);
  }

  Widget emailField() {
    Function(String) onChanged = (value) => viewModel.user.email = value.trim();
    return LoginTextField(Icons.email,
                          'Email',
                          onChanged, 
                          keyboardType: TextInputType.emailAddress);
  }

  Widget passwordField() {
    Function(String) onChanged = (value) => viewModel.password = value.trim();
    return LoginTextField(Icons.lock,
                          'Password', 
                          onChanged, 
                          obscureText: true);
  }

  Widget toggleButton() {
    String text = viewModel.isLoginForm() ? 'Create an account' : 'Have an account? Sign in';
    return SecondaryButton(text: text, onPressed: viewModel.toggleView);
  }

  Widget submitButton() {
    String text = viewModel.isLoginForm() ? 'Login' : 'Create account';
    return PrimaryButton(text: text, 
                         onPressed: viewModel.onSubmit);
  }
}
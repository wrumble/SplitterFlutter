import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import 'package:splitter/Models/AuthenticationState.dart';
import 'package:splitter/Screens/LoginAndSignupScreen/LoginAndSignupScreenViewModel.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';


class FirebaseAuthMock extends Mock implements FirebaseAuth { }

class AuthenticationServiceMock extends Mock implements AuthenticationServiceType {}

class CloudStoreServiceMock extends Mock implements CloudStoreServiceType {}

void main() {
  final authenticationService = AuthenticationServiceMock();
  final cloudStoreService = CloudStoreServiceMock();

  LoginAndSignupScreenViewModel viewModel; 
  BehaviorSubject<AuthenticationState> authenticationServiceState;

  setUpAll(() {
    when(authenticationService.authenticationState).thenAnswer((_) => 
      authenticationServiceState);                                     

    when(authenticationService.listenToAuthStateChange()).thenAnswer((_) =>
      Future<AuthenticationServiceMock>.value(authenticationService));
  });

  setUp(() {
    authenticationServiceState = BehaviorSubject<AuthenticationState>.seeded(AuthenticationState.loading);
    viewModel = LoginAndSignupScreenViewModel(authenticationService: authenticationService,
                                              cloudStoreService: cloudStoreService);
  });

  group('Setup', () {
    test('ViewModel streams seeded correctly on init', () async {
      expect(viewModel.formType, emits(FormType.login));
      expect(viewModel.errorMessage, emits(null));
      expect(viewModel.isLoading, emits(false));
    });

    test('ViewModel variables set correctly on init', () async {
      expect(viewModel.password, null);
      expect(viewModel.user.id, null);
      expect(viewModel.user.firstName, null);
      expect(viewModel.user.lastName, null);
      expect(viewModel.user.email, null);
    });
  });
}
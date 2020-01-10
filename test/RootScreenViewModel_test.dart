import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splitter/Models/AuthenticationState.dart';
import 'package:splitter/Screens/RootScreen/RootScreenViewModel.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class AuthenticationServiceMock extends Mock implements AuthenticationService {}

class CloudStoreServiceMock extends Mock implements CloudStoreService {}

void main() {

  group('AuthenticationState', () {
    test('Initial AuthenticationState is loading', () async {
      final authenticationService = AuthenticationServiceMock();
      final cloudStoreService = CloudStoreServiceMock();
      final viewModel = RootScreenViewModel(authenticationService: authenticationService,
                                            cloudStoreService: cloudStoreService);
        
      when(authenticationService.firebaseAuthentication).thenAnswer((_) => 
        FirebaseAuthMock());   

      when(authenticationService.authenticationState).thenAnswer((_) => 
        BehaviorSubject<AuthenticationState>.seeded(AuthenticationState.loading));                                     

      when(authenticationService.listenToAuthStateChange()).thenAnswer((_) =>
        Future<AuthenticationServiceMock>.value(authenticationService));

      expect(viewModel.authenticationState, AuthenticationState.loading);
    });
  });
}
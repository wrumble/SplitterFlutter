import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splitter/Models/AuthenticationState.dart';
import 'package:splitter/Models/User.dart';
import 'package:splitter/Screens/RootScreen/RootScreenViewModel.dart';
import 'package:splitter/Services/AuthenticationService.dart';
import 'package:splitter/Services/CloudStoreService.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth { }

class AuthenticationServiceMock extends Mock implements AuthenticationServiceType {}

class CloudStoreServiceMock extends Mock implements CloudStoreServiceType {}

void main() {
  final authenticationService = AuthenticationServiceMock();
  final cloudStoreService = CloudStoreServiceMock();

  RootScreenViewModel viewModel; 
  BehaviorSubject<AuthenticationState> authenticationServiceState;

  setUpAll(() {
    when(authenticationService.authenticationState).thenAnswer((_) => 
      authenticationServiceState);                                     

    when(authenticationService.listenToAuthStateChange()).thenAnswer((_) =>
      Future<AuthenticationServiceMock>.value(authenticationService));
  });

  setUp(() {
    authenticationServiceState = BehaviorSubject<AuthenticationState>.seeded(AuthenticationState.loading);
    viewModel = RootScreenViewModel(authenticationService: authenticationService,
                                    cloudStoreService: cloudStoreService);
  });

  group('AuthenticationState', () {
    group('On Success', () {
      test('ViewModel Initial AuthenticationState is loading', () async {
        expect(viewModel.authenticationState, emits(AuthenticationState.loading));
      });

      test('ViewModel AuthenticationState is loggedOut when authService emits loggedOut', () async {
        authenticationServiceState.add(AuthenticationState.loggedOut);

        List<AuthenticationState> expectation = [AuthenticationState.loading, AuthenticationState.loggedOut];

        expect(viewModel.authenticationState, emitsInOrder(expectation));
      });

      test('ViewModel AuthenticationState is loggedIn when authService emits loggedIn', () async {
        String userID = "mockUserID";
        User userStub = TestUser.stub();
        List<AuthenticationState> expectation = [AuthenticationState.loading, AuthenticationState.loggedIn];

        when(authenticationService.currentUserId()).thenAnswer((_) =>
          Future<String>.value(userID));
        when(cloudStoreService.fetchUserWithId(userID)).thenAnswer((_) =>
          Future<User>.value(userStub));

        authenticationServiceState.add(AuthenticationState.loggedIn);

        expect(viewModel.authenticationState, emitsInOrder(expectation));
      });
    });

    group('On Error', () {
      test('ViewModel AuthenticationState is loggedOut when currentUserId errors', () async {
        List<AuthenticationState> expectation = [AuthenticationState.loading, AuthenticationState.loggedOut];

        when(authenticationService.currentUserId()).thenThrow((_) =>
          Future<String>.value("error"));

        authenticationServiceState.add(AuthenticationState.loggedIn);

        expect(viewModel.authenticationState, emitsInOrder(expectation));
      });

      test('ViewModel AuthenticationState is loggedOut when fetchUserWithId errors', () async {
        User testUser = TestUser.stub();
        List<AuthenticationState> expectation = [AuthenticationState.loading, AuthenticationState.loggedOut];

        when(authenticationService.currentUserId()).thenAnswer((_) =>
          Future<String>.value(testUser.id));

        when(cloudStoreService.fetchUserWithId(testUser.id)).thenThrow((_) =>
          Future<String>.value("error"));

        authenticationServiceState.add(AuthenticationState.loggedIn);

        expect(viewModel.authenticationState, emitsInOrder(expectation));
      });
    });
  });
}

extension TestUser on User {
    static User stub([String id = "mockId", 
                      String firstName = "mockFirstName",
                      String lastName = "mockLastName",
                      String email = "mockEmail"]) {
      return User(id: id,
                  firstName: firstName, 
                  lastName: lastName, 
                  email: email);
    }
}
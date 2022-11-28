abstract class LoginState {}


// login with url screen


class LoginInitialState extends LoginState {}

class LoginWithUrlLoadingState extends LoginState {}

class LoginWithUrlSuccessState extends LoginState {}

class LoginWithUrlErrorState extends LoginState {}


// login with email and password screen


class LoginWithEmailAndPasswordHiddenPassState extends LoginState {}
class LoginWithEmailAndPasswordLoadingState extends LoginState {}

class LoginWithEmailAndPasswordSuccessState extends LoginState {}

class LoginWithEmailAndPasswordErrorState extends LoginState {}
class ClintNameErrorState extends LoginState {}

class LoginCheckConnectionNoInternetState extends LoginState {}
class LoginCheckConnectionNoInternetMobileDataState extends LoginState {}
class LoginCheckConnectionNoInternetWifiState extends LoginState {}



class LoginInitialCheckConnectionNoInternetState extends LoginState {}
class LoginInitialCheckConnectionNoInternetMobileDataState extends LoginState {}
class LoginInitialCheckConnectionNoInternetWifiState extends LoginState {}
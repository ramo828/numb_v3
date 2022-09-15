class Account {
  String login1 = "Ramo828";
  String pass1 = "ramiz123";
  bool status = false;
  final String login;
  final String pass;
  Account({required this.login, required this.pass});

  void contrl() {
    status = (login == login1 && pass == pass1);
  }
}

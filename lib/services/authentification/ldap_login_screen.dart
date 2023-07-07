import 'package:flutter/material.dart';

import 'ldap_auth.dart';

class LDAPLoginScreen extends StatelessWidget {
  LDAPAuth auth = LDAPAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LDAP Login Test"),
      ),
      body: Center(
        child: Container(
          child: ElevatedButton(
            child: Text("Login"),
            onPressed: () async {
              List<String>? results = await showDialog<List<String>>(
                context: context,
                builder: (context) => createFormDialog(context),
              );
              if (results != null) {
                //print("${results[0]}:${results[1]}");
                await _callLogin(results[0], pw: results[1]);
              }
            },
          ),
        ),
      ),
    );
  }

  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  Widget createFormDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Authentifizierung"),
      content: Container(
        height: 120,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.tealAccent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextFormField(
                controller: _controllerUser,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    //focusedBorder: InputBorder.none,
                    //enabledBorder: InputBorder.none,
                    //errorBorder: InputBorder.none,
                    //disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                    hintText: "FD-Nummer"),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.tealAccent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextFormField(
                  obscureText: true,
                  controller: _controllerPassword,
                  decoration: new InputDecoration(
                      //border: InputBorder.none,
                      //focusedBorder: InputBorder.none,
                      //enabledBorder: InputBorder.none,
                      //errorBorder: InputBorder.none,
                      //disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 0, top: 0, right: 15),
                      hintText: "Passwort")),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 8),
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                //primary: Color(0xFF6200EE),
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                _controllerPassword.clear();
                _controllerUser.clear();
              },
              child: Text('clear'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 8),
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                //primary: Color(0xFF6200EE),
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                String username = _controllerUser.text;
                String password = _controllerPassword.text;
                _controllerUser.clear();
                _controllerPassword.clear();
                Navigator.pop(context, [username.trim(), password.trim()]);
              },
              child: Text('Einloggen'),
            ),
          ),
        ),
      ],
    );
  }

  Future _callLogin(String user, {String pw = "passwort"}) async {
    bool ok = await auth.loginFulda(user: user, password: pw);
    print("login ist ${ok}");
  }
}

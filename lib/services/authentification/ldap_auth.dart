import 'package:dartdap/dartdap.dart';

class LDAPAuth {
  var Host = 'ldap.forumsys.com';
  var Port = 389;

  LDAPAuth({
    //this.Host = "ldap.forumsys.com",
    this.Host = "ldap1.rz.hs-fulda.de",
    this.Port = 636,
  });

  // ldap search
  // dn
  //

  Future<bool> loginFulda({
    required String user,
    required String password,
    bool useSSL = true,
  }) async {
    LdapResult result;

    String DN = "cn=${user},ou=ai,o=fh-fulda";

    if (user == "") return false;
    if (password == "") return false;

    print(DN);

    var connection = LdapConnection(
        host: Host, ssl: useSSL, port: Port, bindDN: DN, password: password);
    try {
      print('start open');
      await connection.open();
      // Perform search operation
      print('start bind');
      result = await connection.bind();
      if (result != null) {
        return (result.resultCode == 0);
      } else {
        return false;
      }
    } catch (e, stacktrace) {
      print('********* Exception: $e $stacktrace');
      return false; // irgendwas lief schief
    } finally {
      // Close the connection when finished with it
      print('Closing');
      await connection.close();
    }
  }

  Future<void> _doSearch(LdapConnection connection) async {
    var base = 'o=fh-fulda';
    var filter = Filter.present('objectClass');
    var attrs = ['dn', 'objectclass'];

    var searchResult =
        await connection.search(base, filter, attrs, sizeLimit: 5);
    print('Search returned ${searchResult.stream}');

    await for (var entry in searchResult.stream) {
      // Processing stream of SearchEntry
      print('dn: ${entry.dn}');

      // Getting all attributes returned

      for (var attr in entry.attributes.values) {
        for (var value in attr.values) {
          // attr.values is a Set
          print('  ${attr.name}: $value');
        }
      }
    }
  }
}

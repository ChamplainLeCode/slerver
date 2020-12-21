# Slerver

This plugin provides a server way to interconnect flutter app.<br>
##### Learn more at [Bixterprise.com](http://flutter.bixterprise.com)
## Usage

Lets take a look at how to use `SlerverIO` to connect two Flutter app for data sharing on both Android and iOS.

Create the client that we will use to connect.
``` Dart
Slerver slerver;
```
Initilialize response from flutter Server App.
```Dart
startServer ( ) async {
   slerver = server = await Slerver.createServer('10.42.0.241',  9000);
}
```
Now we add route triggers by using  `SlerverRedirectRoute` from `Slerver`
``` Dart
onNavigate ( ) {
    var router = server.router;
    router
      ..on( '/name',  (Map m) async =>  {'received': m, 'message': 'Hello ${m['name']} ${m['surname']}'})
      ..on('/surname', (List p) async {
             await Future.delayed(Duration(seconds: 5));
             return p?.reversed?.toList();
      });
}
```
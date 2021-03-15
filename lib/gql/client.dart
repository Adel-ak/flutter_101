import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<ValueNotifier<GraphQLClient>> gqlClient() async {
  String websocketEndpoint;

  final _httpLink = HttpLink(
    'http://192.168.0.28:5000/graphql',
  );

  final _authLink = AuthLink(
    getToken: () async {
      try {
        User auth = FirebaseAuth.instance.currentUser;

        String token = auth != null ? await auth.getIdToken() : null;

        print('getToken token ------ $token');
        return 'Bearer $token';
      } catch (error) {
        print('getToken error ------ $error');
        return '';
      }
    },
  );
  Link _link = _authLink.concat(_httpLink);

  /// subscriptions must be split otherwise `HttpLink` will. swallow them
  if (websocketEndpoint != null) {
    final _wsLink = WebSocketLink(websocketEndpoint);
    _link = Link.split((request) => request.isSubscription, _wsLink, _link);
  }

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: _link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  return client;
}

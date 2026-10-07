import 'package:countries/app.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  var box = await Hive.openBox("countries");

  final HttpLink link = HttpLink("https://countries.trevorblades.com/");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore(box)),
    ),
  );

  runApp(GraphQLProvider(client: client, child: const MyApp()));
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String readCountries = """
  query Countries {
    countries {
      code
      name
      emoji
      capital
    }
  }
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [], title: const Text("Countries App")),
      body: Query(
        options: QueryOptions(document: gql(readCountries)),
        builder:
            (
              QueryResult results, {
              VoidCallback? refetch,
              FetchMore? fetchMore,
            }) {
              if (results.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (results.hasException) {
                return Center(child: Text(results.exception.toString()));
              }

              List countries = results.data?["countries"] ?? [];

              if (countries.isEmpty) {
                return const Center(child: Text("No data found"));
              }

              return ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];

                  return ListTile(
                    leading: Text(country["emoji"]),
                    title: Text(country['name']),
                    subtitle: Text(country["code"]),
                  );
                },
              );
            },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttify/models/licence.dart';

class LicensesWidget extends StatelessWidget {
  final List<License?>? licenses;

  const LicensesWidget({
    Key? key,
    @required this.licenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: EdgeInsets.only(bottom: 24),
        itemCount: licenses!.length,
        itemBuilder: (context, index) {
          final license = licenses![index];

          return ListTile(
            title: Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Text(
                    "This app uses third party libraries. The following list contains all libraries and their licences.",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    license!.title!,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
            subtitle: Text(
              license.text!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          );
        },
      );
}

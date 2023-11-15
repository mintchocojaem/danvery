import 'package:flutter/cupertino.dart';

import 'agree_terms_content.dart';

class AgreeTermsContainer extends StatelessWidget {
  final List<AgreeTermsContent> agreeTermsContents;

  const AgreeTermsContainer({Key? key, required this.agreeTermsContents})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final agreeTermsContent in agreeTermsContents)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: agreeTermsContent,
          ),
      ],
    );
  }
}
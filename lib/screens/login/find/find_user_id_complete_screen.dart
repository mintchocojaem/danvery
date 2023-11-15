import 'package:danvery/routes/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/orb/components/components.dart';

class FindUserIdCompleteScreen extends ConsumerWidget {
  const FindUserIdCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      scrollBody: false,
      body: Stack(
        children: [
          Text(
            '입력하신 휴대폰\n번호로 아이디를 전송했어요',
            style: themeData.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.check_rounded,
              color: Colors.green,
              size: 128,
            ),
          ),
        ],
      ),
      submitButton: OrbButton(
        onPressed: () async{
          ref.read(routerProvider).pop();
        },
        buttonText: '로그인하러 가기',
      ),
    );
  }
}
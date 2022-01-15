import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home.dart';

// // ユーザー情報の受け渡しを行うためのProvider
// final userProvider = StateProvider((ref) {
//   return FirebaseAuth.instance.currentUser;
// });

// エラー情報の受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final infoTextProvider = StateProvider.autoDispose((ref) {
  return '';
});

// メールアドレスの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final emailProvider = StateProvider.autoDispose((ref) {
  return '';
});

// パスワードの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final passwordProvider = StateProvider.autoDispose((ref) {
  return '';
});

// // メッセージの受け渡しを行うためのProvider
// // ※ autoDisposeを付けることで自動的に値をリセットできます
// final messageTextProvider = StateProvider.autoDispose((ref) {
//   return '';
// });

// // StreamProviderを使うことでStreamも扱うことができる
// // ※ autoDisposeを付けることで自動的に値をリセットできます
// final postsQueryProvider = StreamProvider.autoDispose((ref) {
//   return FirebaseFirestore.instance
//       .collection('posts')
//       .orderBy('date')
//       .snapshots();
// });

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  // const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerから値を受け取る
    // メッセージ表示用
    final infoText = ref.watch(infoTextProvider);
    // 入力したメールアドレス・パスワード
    // final email = watch(emailProvider).state;
    // final password = watch(passwordProvider).state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MessageApp Login Page'),
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // メールアドレス入力
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  // Providerから値を更新
                  // emailProvider.state = value;
                  ref.read(emailProvider.notifier).state = value;
                },
              ),
              // パスワード入力
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  // Providerから値を更新
                  ref.read(passwordProvider.notifier).state = value;
                },
              ),
              Container(
                padding: const EdgeInsets.all(8),
                // メッセージ表示
                child: Text(infoText),
              ),
              // Container(
              //     width: double.infinity,
              //     child: ElevatedButton(
              //       child: const Text('ユーザー登録'),
              //       onPressed: () async {
              //         try {
              //           // final FirebaseAuth auth = FirebaseAuth.instance;
              //           // final result = await auth.createUserWithEmailAndPassword(
              //           //   email: email,
              //           //   password: password,
              //           // );
              //           // // ユーザー情報を更新
              //           // context.read(userProvider).state = result.user;

              //           await Navigator.of(context).pushReplacement(
              //             MaterialPageRoute(builder: (context) {
              //               return ChatPage();
              //             }),
              //           );
              //         } catch (e) {
              //           // Providerから値を更新
              //           context.read(infoTextProvider).state =
              //               "登録に失敗しました：${e.toString()}";
              //         }
              //       },
              //     ),
              //   ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  child: const Text('ログイン'),
                  onPressed: () async {
                    try {
                      // final FirebaseAuth auth = FirebaseAuth.instance;
                      // await auth.signInWithEmailAndPassword(
                      //   email: email,
                      //   password: password,
                      // );
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return const Home();
                        }),
                      );
                    } catch (e) {
                      // Providerから値を更新
                      ref.read(infoTextProvider.notifier).state =
                          "ログインに失敗しました：${e.toString()}";
                    }
                  },
                ),
              ),
            ]),
      )),
    );
  }
}

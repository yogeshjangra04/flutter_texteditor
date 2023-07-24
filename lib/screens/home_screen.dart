import 'package:collaborative_text_editor/colors.dart';
import 'package:collaborative_text_editor/common/widgets/error_page.dart';
import 'package:collaborative_text_editor/common/widgets/loader.dart';
import 'package:collaborative_text_editor/models/document_model.dart';
import 'package:collaborative_text_editor/repository/auth_repository.dart';
import 'package:collaborative_text_editor/repository/document_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  void signOut(WidgetRef ref) {
    ref.read(authRepositoryProvider).signOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createDocument(BuildContext context, WidgetRef ref) async {
    String token = ref.read(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackBar = ScaffoldMessenger.of(context);
    final errorModel =
        await ref.read(documentRepositoryProvider).createDocument(token);
    if (errorModel.data != null) {
      navigator.push('/document/${errorModel.data.id}');
    } else {
      snackBar.showSnackBar(
        SnackBar(
          content: Text(errorModel.error!),
        ),
      );
    }
  }

  void navigateToDocument(BuildContext context, String id) {
    Routemaster.of(context).push('/document/$id');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => createDocument(context, ref),
            icon: const Icon(
              Icons.add,
              color: kBlack,
            ),
          ),
          IconButton(
            onPressed: () => signOut(ref),
            icon: const Icon(
              Icons.logout,
              color: kRed,
            ),
          ),
        ],
      ),
      body:
          ref.watch(userDocumentsProvider(ref.watch(userProvider)!.token)).when(
                data: (data) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Container(
                        height: 900,
                        width: 600,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListView.builder(
                          itemCount: data!.data.length,
                          itemBuilder: (context, ind) {
                            DocumentModel document = data.data[ind];
                            return SizedBox(
                              height: 70,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () => navigateToDocument(
                                  context,
                                  document.id,
                                ),
                                child: Card(
                                  child: Center(
                                    child: Text(
                                      document.title,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                error: (e, st) => ErrorPage(error: e.toString()),
                loading: () => const Loader(),
              ),
    );
  }
}

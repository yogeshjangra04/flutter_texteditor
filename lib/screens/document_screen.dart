import 'package:collaborative_text_editor/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentScreen extends ConsumerStatefulWidget {
  final String id;
  const DocumentScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  TextEditingController titleController = TextEditingController(
    text: "Untitled",
  );
  quill.QuillController quillController = quill.QuillController.basic();

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          foregroundColor: kBlack,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.lock,
                  size: 16,
                ),
                label: const Text('Share'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlue,
                ),
              ),
            ),
          ],
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/docs-logo.png',
                  height: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 180,
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kBlue,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: kGrey,
                  width: 0.1,
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              quill.QuillToolbar.basic(controller: quillController),
              Expanded(
                child: Card(
                  color: kWhiteColor,
                  elevation: 8,
                  child: SizedBox(
                    width: 750,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: quill.QuillEditor.basic(
                        controller: quillController,
                        readOnly: false, // true for view only mode
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/widgets/common_button.dart';
import 'package:mobilni_zpevnik/widgets/common_text_field.dart';
import 'package:mobilni_zpevnik/widgets/ui_gaps.dart';

class CreateSongbookScreen extends StatelessWidget {
  final Function(String name, List<Song> songs) onCreate;

  CreateSongbookScreen({super.key, required this.onCreate});

  final songbookNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    songbookNameController.text = '${'songbook'.i18n()} name';
    songbookNameController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: songbookNameController.text.length,
    );

    return ScreenTemplate(
      appBar: AppBar(
        title: const Text('create-songbook'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(),
              Text('enter-songbook-name'.i18n()),
              const Gap(),
              CommonTextField(
                controller: songbookNameController,
                hintText: 'songbook-name'.i18n(),
              ),
              const Gap(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonButton(
                    width: 180,
                    label: 'cancel'.i18n(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CommonButton(
                    width: 180,
                    label: 'create'.i18n(),
                    onPressed: () {
                      onCreate(songbookNameController.text, []);
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

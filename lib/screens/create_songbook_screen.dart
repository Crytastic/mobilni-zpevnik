import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/widgets/common_button.dart';
import 'package:mobilni_zpevnik/widgets/common_text_field.dart';

import '../widgets/gap.dart';

class CreateSongbookScreen extends StatelessWidget {
  final Function(String name, List<Song> songs) onCreate;

  CreateSongbookScreen({Key? key, required this.onCreate}) : super(key: key);

  final songbookNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      appBar: AppBar(
        title: const Text('Create Songbook'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(),
              const Text('Enter songbook name.'),
              const Gap(),
              CommonTextField(
                controller: songbookNameController,
                hintText: 'Songbook Name',
              ),
              const Gap(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonButton(
                    width: 200,
                    label: 'Cancel',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CommonButton(
                    width: 200,
                    label: 'Create',
                    onPressed: () {
                      onCreate(songbookNameController.text, []);
                      Navigator.pop(context);
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

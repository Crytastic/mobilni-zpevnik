import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/song_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  Song getSongByIndex(int index) {
    return Song(
      id: index.toString(),
      name: 'Song $index',
      content: '''
C              G
I'm going down the road,
Am             Em
feeling bad and cold.
F              C
I think of home,
G              C
and I feel bold.

C            G
My path is clear,
Am            Em
the stars guide me.
F              C
The night is mine,
G              C
as it's meant to be.

C               G
Under the moon's soft glow,
Am                Em
I find my pace and flow.
F                 C
The shadows dance,
G                 C
in the night's slow waltz.

C                  G
And when the dawn breaks new,
Am                 Em
the sky's a brilliant hue.
F                 C
I'm nearing end,
G                 C
of this road I choose.

Am                Em
With every step and stone,
F                 C
I've grown, I've known.
Am               Em
The journey's long,
F                 G
but this road's my own.
  
C               G
Now as I near the end,
Am              Em
around the river's bend.
F               C
I see my home,
G               C
this road's been a friend.
''',
      artists: ['Artist $index'],
      albums: ['Album $index'],
      bpm: '120',
      genre: 'Genre $index',
      strumming: 'DUDU',
      communityRating: '5',
      key: 'C',
      tuning: 'Standard',
      capo: 'None',
      tags: ['Tag1', 'Tag2'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return ListView.builder(
      itemCount: 25,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          tileColor: index.isOdd ? oddItemColor : evenItemColor,
          title: Text('${'song'.i18n()} $index'),
          onTap: () {
            Song selectedSong = getSongByIndex(index);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongScreen(song: selectedSong),
              ),
            );
          },
        );
      },
    );
  }
}

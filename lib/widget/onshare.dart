import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thehumbleplank/learnalist/challenge.dart';

shareChallenge(BuildContext context, Challenge challenge) async {
  final RenderBox box = context.findRenderObject();
  var subject = "Plank challenge";
  var text = """
${challenge.description}

Join me in a plank challenge

https://learnalist.net/challenge/${challenge.uuid}.html
""";
  print(box.size);
  print(box.localToGlobal(Offset.zero));
  print(box.localToGlobal(Offset.zero) & box.size);

  await Share.share(text,
      subject: subject,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}

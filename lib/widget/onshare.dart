import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:the_humble_plank/learnalist/challenge.dart';

shareChallenge(BuildContext context, Challenge challenge) async {
  final RenderBox box = context.findRenderObject();
  var subject = "Plank challenge";
  var text = """
${challenge.description}

Join me in a plank challenge

https://learnalist.net/challenge/${challenge.uuid}.html
""";

  await Share.share(text,
      subject: subject,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}

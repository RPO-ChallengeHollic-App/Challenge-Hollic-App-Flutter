import 'package:challange_hollic_mobile_app/models/participant.model.dart';

import 'challenge.model.dart';

class ChallengeImage {
  final Challenge? challenge;
  final Participant participant;
  final String image;
  final int likes;

  ChallengeImage(this.challenge, this.participant, this.image, this.likes);
}
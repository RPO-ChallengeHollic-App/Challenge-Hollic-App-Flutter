import 'package:challange_hollic_mobile_app/models/participant.model.dart';
import 'package:challange_hollic_mobile_app/models/tag.model.dart';

class Challenge {
  final String name;
  final DateTime startDate;
  final DateTime? deadline;
  final List<Participant> participants;
  final List<Tag> tags;

  Challenge(
      this.name, this.startDate, this.deadline, this.participants, this.tags);
}
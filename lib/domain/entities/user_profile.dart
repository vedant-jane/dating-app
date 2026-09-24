import 'package:equatable/equatable.dart';

class ProfilePrompt extends Equatable {
  final String question;
  final String answer;

  const ProfilePrompt({
    required this.question,
    required this.answer,
  });

  @override
  List<Object?> get props => [question, answer];
}

class UserProfile extends Equatable {
  final String id;
  final String name;
  final int age;
  final String dobFormatted;
  final String city;
  final String state;
  final String country;
  final int distanceKm;
  final String profession;
  final String height;
  final String relationshipGoal;
  final int matchPercentage;
  final int trustPercentage;
  final String replyTime;
  final bool isOnline;
  final bool isVerified;
  final String primaryImageUrl;
  final List<String> galleryImages;
  final String about;
  final String loveLanguage;
  final String religion;
  final String interestedIn;
  final String zodiac;
  final String zodiacTraits;
  final String motherTongue;
  final String communicationStyle;
  final String videoIntroDuration;
  final List<ProfilePrompt> prompts;
  final String education;
  final String workStyle;
  final String ambitionLevel;
  final String bigDream;
  final List<String> hobbies;
  final Map<String, String> lifestyle;
  final String datingGoalTitle;
  final String datingGoalDescription;

  const UserProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.dobFormatted,
    required this.city,
    required this.state,
    required this.country,
    required this.distanceKm,
    required this.profession,
    required this.height,
    required this.relationshipGoal,
    required this.matchPercentage,
    required this.trustPercentage,
    required this.replyTime,
    required this.isOnline,
    required this.isVerified,
    required this.primaryImageUrl,
    required this.galleryImages,
    required this.about,
    required this.loveLanguage,
    required this.religion,
    required this.interestedIn,
    required this.zodiac,
    required this.zodiacTraits,
    required this.motherTongue,
    required this.communicationStyle,
    required this.videoIntroDuration,
    required this.prompts,
    required this.education,
    required this.workStyle,
    required this.ambitionLevel,
    required this.bigDream,
    required this.hobbies,
    required this.lifestyle,
    required this.datingGoalTitle,
    required this.datingGoalDescription,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        dobFormatted,
        city,
        state,
        country,
        distanceKm,
        profession,
        height,
        relationshipGoal,
        matchPercentage,
        trustPercentage,
        replyTime,
        isOnline,
        isVerified,
        primaryImageUrl,
        galleryImages,
        about,
        loveLanguage,
        religion,
        interestedIn,
        zodiac,
        zodiacTraits,
        motherTongue,
        communicationStyle,
        videoIntroDuration,
        prompts,
        education,
        workStyle,
        ambitionLevel,
        bigDream,
        hobbies,
        lifestyle,
        datingGoalTitle,
        datingGoalDescription,
      ];
}

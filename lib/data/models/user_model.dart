import 'package:intl/intl.dart';
import '../../domain/entities/user_profile.dart';

class UserModel extends UserProfile {
  const UserModel({
    required super.id,
    required super.name,
    required super.age,
    required super.dobFormatted,
    required super.city,
    required super.state,
    required super.country,
    required super.distanceKm,
    required super.profession,
    required super.height,
    required super.relationshipGoal,
    required super.matchPercentage,
    required super.trustPercentage,
    required super.replyTime,
    required super.isOnline,
    required super.isVerified,
    required super.primaryImageUrl,
    required super.galleryImages,
    required super.about,
    required super.loveLanguage,
    required super.religion,
    required super.interestedIn,
    required super.zodiac,
    required super.zodiacTraits,
    required super.motherTongue,
    required super.communicationStyle,
    required super.videoIntroDuration,
    required super.prompts,
    required super.education,
    required super.workStyle,
    required super.ambitionLevel,
    required super.bigDream,
    required super.hobbies,
    required super.lifestyle,
    required super.datingGoalTitle,
    required super.datingGoalDescription,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, int index) {
    final nameMap = json['name'] as Map<String, dynamic>? ?? {};
    final firstName = nameMap['first']?.toString() ?? 'Shraddha';

    final dobMap = json['dob'] as Map<String, dynamic>? ?? {};
    final age = (dobMap['age'] as num?)?.toInt() ?? (21 + (index % 7));
    final rawDob = dobMap['date']?.toString() ?? '1999-02-19T00:00:00Z';
    String formattedDob = '19 Feb 1999';
    try {
      final dateTime = DateTime.parse(rawDob);
      formattedDob = DateFormat('dd MMM yyyy').format(dateTime);
    } catch (_) {}

    final locMap = json['location'] as Map<String, dynamic>? ?? {};
    final rawCity = locMap['city']?.toString() ?? 'Pune';
    final state = locMap['state']?.toString() ?? 'Maharashtra';
    final country = locMap['country']?.toString() ?? 'India';

    // Capitalize city
    final city = rawCity.isNotEmpty
        ? '${rawCity[0].toUpperCase()}${rawCity.substring(1)}'
        : 'Pune';

    final loginMap = json['login'] as Map<String, dynamic>? ?? {};
    final id = loginMap['uuid']?.toString() ?? 'user_$index';

    final pictureMap = json['picture'] as Map<String, dynamic>? ?? {};
    final primaryImageUrl = pictureMap['large']?.toString() ??
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=800&q=80';

    // Distance calculated or generated realistic
    final distanceKm = 3 + (index * 2) % 15;

    final professions = [
      'Fashion Designer • 5\'4"',
      'Product Designer • 5\'5"',
      'Content Creator • 5\'2"',
      'UX Researcher • 5\'4"',
      'Brand Strategist • 5\'6"',
      'Architect • 5\'3"',
    ];

    final goals = [
      'Serious relationship',
      "Let's see where it goes",
      'Long-term, marriage-open',
      'Something meaningful',
    ];

    final matchPercentages = [74, 88, 77, 92, 85, 94];
    final replyTimes = ['~5m Reply', '~5m Replies', '~10m Reply', '~2m Reply'];

    final galleryPool = [
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=800&q=80',
    ];

    return UserModel(
      id: id,
      name: firstName,
      age: age,
      dobFormatted: formattedDob,
      city: city,
      state: state,
      country: country,
      distanceKm: distanceKm,
      profession: professions[index % professions.length],
      height: '5\'5" (165 cm)',
      relationshipGoal: goals[index % goals.length],
      matchPercentage: matchPercentages[index % matchPercentages.length],
      trustPercentage: 98,
      replyTime: replyTimes[index % replyTimes.length],
      isOnline: true,
      isVerified: true,
      primaryImageUrl: primaryImageUrl,
      galleryImages: [
        primaryImageUrl,
        galleryPool[index % galleryPool.length],
        galleryPool[(index + 1) % galleryPool.length],
      ],
      about:
          'Building products by day, planning my next trek by night. Looking for someone equally driven and equally curious.',
      loveLanguage: 'Words of affirmation',
      religion: 'Hindu - Marathi',
      interestedIn: 'Men - Dating',
      zodiac: 'Scorpio',
      zodiacTraits: 'Loyal • Passionate • Intuitive',
      motherTongue: 'Marathi',
      communicationStyle: 'Phone calls over texts',
      videoIntroDuration: '0:28',
      prompts: const [
        ProfilePrompt(
          question: 'The way to win me over is...',
          answer: 'A good book rec and a strong chai opinion.',
        ),
        ProfilePrompt(
          question: 'My simple pleasures...',
          answer: 'Roadside chai after a long trek, no signal, good company.',
        ),
        ProfilePrompt(
          question: "We'll get along if...",
          answer: 'You can debate me for an hour and still want dessert after.',
        ),
      ],
      education: 'NIFT Pune\nB. Des Fashion Design - 3rd year',
      workStyle: 'Creative • Hybrid',
      ambitionLevel: 'HIGHLY DRIVEN',
      bigDream:
          'Launch her own sustainable Indian fashion label — handcrafted, slow fashion made with heart. Also wants to travel every fashion capital before 30.',
      hobbies: const [
        'Travel',
        'Coffee',
        'Trekking',
        'Books',
        'Yoga',
        'Indie music',
        'Cooking',
        'Photography',
      ],
      lifestyle: const {
        'Diet': 'Vegetarian',
        'Drinking': 'Socially',
        'Smoking': 'Non-smoker',
        'Fitness': 'Gym 4x/week • Yoga - Trekking',
        'Travel': '4-5 trips/year',
        'Pets': 'Cat parent',
        'Sleep': 'Night Owl',
      },
      datingGoalTitle: 'Long-term, marriage-open',
      datingGoalDescription:
          'No pressure, no timelines — just looking for the right person to build something real with.',
    );
  }

  static List<UserModel> getFallbackProfiles() {
    final names = [
      'Shraddha', 'Meera', 'Ishita', 'Aanya', 'Elena',
      'Pooja', 'Rhea', 'Ananya', 'Tara', 'Kiara',
      'Zara', 'Sneha', 'Tanya', 'Diya', 'Nisha',
      'Kavya', 'Rashi', 'Simran', 'Alia', 'Maya',
    ];

    final cities = [
      'Pune', 'Bengaluru', 'Hyderabad', 'Mumbai', 'Delhi',
      'Goa', 'Jaipur', 'Chennai', 'Kolkata', 'Ahmedabad',
    ];

    final photos = [
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?auto=format&fit=crop&w=800&q=80',
    ];

    return List.generate(20, (index) {
      final name = names[index % names.length];
      final city = cities[index % cities.length];
      final photo = photos[index % photos.length];
      final age = 21 + (index % 8);

      final json = {
        'name': {'first': name},
        'dob': {'age': age, 'date': '2001-05-14T00:00:00Z'},
        'location': {'city': city, 'state': 'State', 'country': 'India'},
        'picture': {'large': photo},
        'login': {'uuid': 'fallback_user_$index'},
      };

      return UserModel.fromJson(json, index);
    });
  }
}

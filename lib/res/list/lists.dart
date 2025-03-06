import '../../model/height_model.dart';
import '../../model/interest_model.dart';

final List<Map<String, dynamic>> countries = [
  {'name': 'Japan', 'flag': '🇯🇵',},
  {'name': 'India', 'flag': '🇮🇳',},
  {'name': 'China', 'flag': '🇨🇳',},
  {'name': 'Canada', 'flag': '🇨🇦',},
  {'name': 'Germany', 'flag': '🇩🇪',},
  {'name': 'Pakistan', 'flag': '🇵🇰',},
  {'name': 'Australia', 'flag': '🇦🇺',},
  {'name': 'United States', 'flag': '🇺🇸',},
  {'name': 'United Kingdom', 'flag': '🇬🇧',},
];

const List<String> religionsList = [
  'Muslim', 'Hindu', 'Sikh', 'Jain', 'Buddhist',
  'Spiritual', 'Christian', 'Catholic', 'Pagan',
  'Agnostic', 'Jewish', 'Zoroastrian', 'Baháʼí',
  'Taoist', 'Shinto', 'Confucian', 'Atheist',
  'Non-Religious', 'Prefer not to say',
];

const List<String> languagesList = [
  'English', 'Hindi', 'Punjabi', 'Gujarati',
  'Marathi', 'Urdu', 'Persian', 'Bengali',
  'Arabic', 'Spanish', 'German', 'Pashto',
  'French', 'Mandarin', 'Cantonese', 'Russian',
  'Portuguese', 'Italian', 'Korean', 'Japanese',
  'Turkish', 'Tamil', 'Telugu', 'Malay',
  'Swahili', 'Dutch', 'Polish', 'Thai',
  'Vietnamese', 'Greek', 'Hebrew', 'Danish',
  'Swedish', 'Norwegian', 'Finnish', 'Amharic'
];

const List<String> communitiesList = [
  'Gujarati', 'Punjabi', 'Sunni', 'Shia',
  'Hindi Speaking', 'Sindhi', 'Bengali',
  'Tamil', 'Telugu', 'Malayali',
  'Maharashtrian', 'Kannada', 'Urdu',
];

const List<String> educationLevelsList = [
  'Doctorate', 'Masters', 'Bachelors',
  'Associates', 'High School', 'Prefer not to say',
];

const List<String> genderOptions = [
  'Male', 'Female', 'Others',
];

List<HeightModel> heights = [
  HeightModel(feet: "4", inches: "5", measurement: "135"),
  HeightModel(feet: "4", inches: "6", measurement: "137"),
  HeightModel(feet: "4", inches: "7", measurement: "140"),
  HeightModel(feet: "4", inches: "8", measurement: "142"),
  HeightModel(feet: "4", inches: "9", measurement: "145"),
  HeightModel(feet: "4", inches: "10", measurement: "147"),
  HeightModel(feet: "4", inches: "11", measurement: "150"),
  HeightModel(feet: "5", inches: "0", measurement: "152"),
  HeightModel(feet: "5", inches: "1", measurement: "155"),
  HeightModel(feet: "5", inches: "2", measurement: "157"),
  HeightModel(feet: "5", inches: "3", measurement: "160"),
  HeightModel(feet: "5", inches: "4", measurement: "163"),
  HeightModel(feet: "5", inches: "5", measurement: "165"),
  HeightModel(feet: "5", inches: "6", measurement: "168"),
  HeightModel(feet: "5", inches: "7", measurement: "170"),
  HeightModel(feet: "5", inches: "8", measurement: "173"),
  HeightModel(feet: "5", inches: "9", measurement: "175"),
  HeightModel(feet: "5", inches: "10", measurement: "178"),
  HeightModel(feet: "5", inches: "11", measurement: "180"),
  HeightModel(feet: "6", inches: "0", measurement: "183"),
  HeightModel(feet: "6", inches: "1", measurement: "185"),
  HeightModel(feet: "6", inches: "2", measurement: "188"),
  HeightModel(feet: "6", inches: "3", measurement: "191"),
  HeightModel(feet: "6", inches: "4", measurement: "193"),
  HeightModel(feet: "6", inches: "5", measurement: "196"),
  HeightModel(feet: "6", inches: "6", measurement: "198"),
  HeightModel(feet: "6", inches: "7", measurement: "201"),
  HeightModel(feet: "6", inches: "8", measurement: "203"),
  HeightModel(feet: "6", inches: "9", measurement: "206"),
  HeightModel(feet: "6", inches: "10", measurement: "208"),
  HeightModel(feet: "6", inches: "11", measurement: "211"),
  HeightModel(feet: "7", inches: "0", measurement: "213"),
  // HeightModel(feet: "5", inches: "0", measurement: "152"),
  // HeightModel(feet: "5", inches: "1", measurement: "153"),
  // HeightModel(feet: "5", inches: "2", measurement: "154"),
  // HeightModel(feet: "5", inches: "3", measurement: "155"),
  // HeightModel(feet: "5", inches: "4", measurement: "156"),
  // HeightModel(feet: "5", inches: "5", measurement: "157"),
  // HeightModel(feet: "5", inches: "6", measurement: "158"),
  // HeightModel(feet: "5", inches: "7", measurement: "159"),
  // HeightModel(feet: "5", inches: "8", measurement: "160"),
  // HeightModel(feet: "6", inches: "0", measurement: "161"),
  // HeightModel(feet: "6", inches: "1", measurement: "162"),
  // HeightModel(feet: "6", inches: "2", measurement: "163"),
  // HeightModel(feet: "6", inches: "3", measurement: "164"),
];

const List<String> drinkOptions = [
  'Frequently', 'Socially', 'Rarely',
  'Never',
];

const List<String> workoutOptions = [
  'Active', 'Sometimes', 'Never',
];

const List<String> starSigns = [
  'Gemini', 'Leo', 'Virgo',
  'Aries', 'Taurus', 'Cancer',
  'Libra', 'Scorpio', 'Sagittarius',
  'Capricorn', 'Aquarius', 'Pisces',
];

List<String> personalityTraits = [
  'Active','Adventurous', 'Animal Lover',
  'Entrepreneur', 'Fashionista', 'Foodie',
  'Artist', 'Athletic', 'Caring', 'Competitive',
  'Creative', 'Dancer', 'Dependable', 'Educated',
];

// final intentions = [
//   Intention(id: '1', title: 'Long-term'),
//   Intention(id: '2', title: 'Short-term'),
//   Intention(id: '3', title: 'Friends'),
//   Intention(id: '4', title: 'Still Figuring it out'),
// ];

const List<String> intentions = [
  'Long-term', 'Short-term', 'Friends','Still Figuring it out',
];

class InterestsList {
  static List<InterestCategory> getInterests() {
    return [
      InterestCategory(
        name: 'Self Care',
        interests: [
          Interest(id: 'sc1', name: 'Therapy', icon: '🧡'),
          Interest(id: 'sc2', name: 'Nutrition', icon: '🥗'),
          Interest(id: 'sc3', name: 'Deep chats', icon: '💬'),
          Interest(id: 'sc4', name: 'Mindfulness', icon: '🧘‍♀️'),
          Interest(id: 'sc5', name: 'Time offline', icon: '⏳'),
          Interest(id: 'sc6', name: 'Sleeping well', icon: '🌙'),
        ],
      ),
      InterestCategory(
        name: 'Sports',
        interests: [
          Interest(id: 'sp1', name: 'Gym', icon: '🏋️'),
          Interest(id: 'sp2', name: 'Yoga', icon: '🧘'),
          Interest(id: 'sp3', name: 'Golf', icon: '⛳'),
          Interest(id: 'sp4', name: 'Boxing', icon: '🥊'),
          Interest(id: 'sp5', name: 'Hockey', icon: '🏑'),
          Interest(id: 'sp6', name: 'Tennis', icon: '🎾'),
          Interest(id: 'sp7', name: 'Running', icon: '🏃'),
          Interest(id: 'sp8', name: 'Cricket', icon: '🏏'),
          Interest(id: 'sp9', name: 'Football', icon: '⚽'),
          Interest(id: 'sp10', name: 'Cycling', icon: '🚴'),
          Interest(id: 'sp11', name: 'Baseball', icon: '⚾'),
          Interest(id: 'sp12', name: 'Swimming', icon: '🏊'),
          Interest(id: 'sp13', name: 'Badminton', icon: '🏸'),
          Interest(id: 'sp14', name: 'Basketball', icon: '🏀'),
          Interest(id: 'sp15', name: 'Horse Riding', icon: '🐎'),
          Interest(id: 'sp16', name: 'Table Tennis', icon: '🏓'),
        ],
      ),
      InterestCategory(
        name: 'Creativity',
        interests: [
          Interest(id: 'crt1', name: 'Art', icon: '🎨'),
          Interest(id: 'crt2', name: 'Crafts', icon: '🔗'),
          Interest(id: 'crt3', name: 'Design', icon: '✏️'),
          Interest(id: 'crt4', name: 'Make-up', icon: '💄'),
          Interest(id: 'crt5', name: 'Dancing', icon: '💃'),
          Interest(id: 'crt6', name: 'Singing', icon: '🎤'),
          Interest(id: 'crt7', name: 'Writing', icon: '📝'),
          Interest(id: 'crt8', name: 'Photography', icon: '📷'),
          Interest(id: 'crt9', name: 'Making Videos', icon: '🎬'),
        ],
      ),
      InterestCategory(
        name: 'Going out',
        interests: [
          Interest(id: 'go1', name: 'Pubs', icon: '🍻'),
          Interest(id: 'go2', name: 'Theatre', icon: '🎭'),
          Interest(id: 'go3', name: 'Karaoke', icon: '🎤'),
          Interest(id: 'go4', name: 'Stand up', icon: '🎤'),
          Interest(id: 'go5', name: 'Festivals', icon: '🎉'),
          Interest(id: 'go6', name: 'Nightclubs', icon: '🎶'),
          Interest(id: 'go7', name: 'Drag shows', icon: '👑'),
          Interest(id: 'go8', name: 'Cafe-hopping', icon: '☕'),
          Interest(id: 'go9', name: 'Museums & Galleries', icon: '🏛'),
        ],
      ),
      InterestCategory(
        name: 'Staying in',
        interests: [
          Interest(id: 'si1', name: 'Baking', icon: '🍞'),
          Interest(id: 'si2', name: 'Cooking', icon: '🍳'),
          Interest(id: 'si3', name: 'Gardening', icon: '🌱'),
          Interest(id: 'si4', name: 'Video games', icon: '🎮'),
          Interest(id: 'si5', name: 'Board games', icon: '🎲'),
        ],
      ),
      InterestCategory(
        name: 'Film & Tv',
        interests: [
          Interest(id: 'ft1', name: 'Anime', icon: '📺'),
          Interest(id: 'ft2', name: 'Drama', icon: '📺'),
          Interest(id: 'ft3', name: 'Comedy', icon: '📺'),
          Interest(id: 'ft4', name: 'Sci-fi', icon: '📺'),
          Interest(id: 'ft5', name: 'Horror', icon: '📺'),
          Interest(id: 'ft6', name: 'Romance', icon: '📺'),
          Interest(id: 'ft7', name: 'Fantasy', icon: '📺'),
          Interest(id: 'ft8', name: 'Thriller', icon: '📺'),
        ],
      ),
      InterestCategory(
        name: 'Reading',
        interests: [
          Interest(id: 'read1', name: 'Manga', icon: '📚'),
          Interest(id: 'read2', name: 'Horror', icon: '📚'),
          Interest(id: 'read3', name: 'Comedy', icon: '📚'),
          Interest(id: 'read4', name: 'Sci-fi', icon: '📚'),
          Interest(id: 'read5', name: 'Mystery', icon: '📚'),
          Interest(id: 'read6', name: 'Romance', icon: '📚'),
          Interest(id: 'read7', name: 'Fantasy', icon: '📚'),
          Interest(id: 'read8', name: 'Thriller', icon: '📚'),
        ]
      ),
      InterestCategory(
        name: 'Music',
        interests: [
          Interest(id: 'mu1', name: 'Desi', icon: '🎵'),
          Interest(id: 'mu2', name: 'Rock', icon: '🎵'),
          Interest(id: 'mu3', name: 'Jazz', icon: '🎵'),
          Interest(id: 'mu4', name: 'R & B', icon: '🎵'),
          Interest(id: 'mu5', name: 'Hip hop', icon: '🎵'),
          Interest(id: 'mu6', name: 'Classical', icon: '🎵'),
          Interest(id: 'mu7', name: 'Electronic', icon: '🎵'),
        ],
      ),
      InterestCategory(
        name: 'Food & Drink',
        interests: [
          Interest(id: 'fd1', name: 'Tea', icon: '🍵'),
          Interest(id: 'fd2', name: 'Wine', icon: '🍷'),
          Interest(id: 'fd3', name: 'Beer', icon: '🍺'),
          Interest(id: 'fd4', name: 'Pizza', icon: '🍕'),
          Interest(id: 'fd5', name: 'Vegan', icon: '🥬'),
          Interest(id: 'fd6', name: 'Whisky', icon: '🥃'),
          Interest(id: 'fd7', name: 'Burger', icon: '🍔'),
          Interest(id: 'fd8', name: 'Coffee', icon: '☕'),
        ],
      ),
      InterestCategory(
        name: 'Travelling',
        interests: [
          Interest(id: 'trv1', name: 'Camping', icon: '🏕️'),
          Interest(id: 'trv2', name: 'Beaches', icon: '🏖️'),
          Interest(id: 'trv3', name: 'Road Trips', icon: '🛣️'),
          Interest(id: 'trv4', name: 'City Breaks', icon: '🏙️'),
          Interest(id: 'trv5', name: 'Backpacking', icon: '🎒'),
          Interest(id: 'trv6', name: 'Hiking Trips', icon: '🥾'),
          Interest(id: 'trv7', name: 'Spa Weekends', icon: '🛀'),
          Interest(id: 'trv8', name: 'Winter Sports', icon: '❄️'),
          Interest(id: 'trv9', name: 'Fishing Trips', icon: '🎣'),
          Interest(id: 'trv10', name: 'Country Escapes', icon: '🌄'),
        ],
      ),
      InterestCategory(
        name: 'Pets',
        interests: [
          Interest(id: 'pets1', name: 'Fish', icon: '🐠'),
          Interest(id: 'pets2', name: 'Dogs', icon: '🐕'),
          Interest(id: 'pets3', name: 'Cats', icon: '🐈'),
          Interest(id: 'pets4', name: 'Birds', icon: '🐦'),
          Interest(id: 'pets5', name: 'Rabbits', icon: '🐇'),
          Interest(id: 'pets6', name: 'Parrots', icon: '🦜'),
          Interest(id: 'pets7', name: 'Turtles', icon: '🐢'),
        ],
      ),
      InterestCategory(
        name: 'Values & Traits',
        interests: [
          Interest(id: 'vt1', name: 'Empathy', icon: '🤗'),
          Interest(id: 'vt2', name: 'Ambitious', icon: '🏆'),
          Interest(id: 'vt3', name: 'Creativity', icon: '🎨'),
          Interest(id: 'vt4', name: 'Confidence', icon: '💪'),
          Interest(id: 'vt5', name: 'Positivity', icon: '😊'),
          Interest(id: 'vt6', name: 'Being Active', icon: '🏃'),
          Interest(id: 'vt7', name: 'Intelligence', icon: '🧠'),
          Interest(id: 'vt8', name: 'Being Family-oriented', icon: '👨‍👩‍👧‍👦'),
        ],
      ),
    ];
  }
}
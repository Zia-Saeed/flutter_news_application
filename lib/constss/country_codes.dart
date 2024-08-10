final Map<String, String> countriesISOCode = {
  "United Arab Emirates": "ae",
  "Argentina": "ar",
  "Austria": "at",
  "Australia": "au",
  "Belgium": "be",
  "Bulgaria": "bg",
  "Brazil": "br",
  "Canada": "ca",
  "Switzerland": "ch",
  "China": "cn",
  "Colombia": "co",
  "Cuba": "cu",
  "Czech Republic": "cz",
  "Germany": "de",
  "Egypt": "eg",
  "France": "fr",
  "United Kingdom": "gb",
  "Greece": "gr",
  "Hong Kong": "hk",
  "Hungary": "hu",
  "Indonesia": "id",
  "Ireland": "ie",
  "Israel": "il",
  "India": "in",
  "Italy": "it",
  "Japan": "jp",
  "South Korea": "kr",
  "Lithuania": "lt",
  "Latvia": "lv",
  "Morocco": "ma",
  "Mexico": "mx",
  "Malaysia": "my",
  "Nigeria": "ng",
  "Netherlands": "nl",
  "Norway": "no",
  "New Zealand": "nz",
  "Philippines": "ph",
  "Poland": "pl",
  "Portugal": "pt",
  "Romania": "ro",
  "Serbia": "rs",
  "Russia": "ru",
  "Saudi Arabia": "sa",
  "Sweden": "se",
  "Singapore": "sg",
  "Slovenia": "si",
  "Slovakia": "sk",
  "Thailand": "th",
  "Turkey": "tr",
  "Taiwan": "tw",
  "Ukraine": "ua",
  "United States": "us",
  "Venezuela": "ve",
  "South Africa": "za",
};

final Map<String, String> languageCode = {
  "Arabic": "ar",
  "German": "de",
  "English": "en",
  "Spanish": "es",
  "French": "fr",
  "Hebrew": "he",
  "Italian": "it",
  "Dutch": "nl",
  "Norwegian": "no",
  "Portuguese": "pt",
  "Russian": "ru",
  "Swedish": "sv",
  "Urdu": "ud",
  "Chinese": "zh",
};

final List<String> categories = [
  "business",
  "entertainment",
  "general",
  "health",
  "science",
  "sports",
  "technology",
];

// countiresISOCodeList({});
Map<String, String> getCountriesISOCode() {
  return countriesISOCode;
}

List<String> getCountriesName() {
  return (countriesISOCode.keys.toList());
}

List<String> get categoriesList => categories;
List<String> get languageName => languageCode.keys.toList();

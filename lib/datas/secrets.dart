class Secrets {
  static const imageUrl = "https://image.tmdb.org/t/p/w500";
  static const _baseUrl = "https://api.themoviedb.org/3";
  static const _apiKey = "api_key=cef190df496ba948f6fb61fa17f0cc62";
  static const trendingUrl = "$_baseUrl/trending/all/day?$_apiKey";
  static const discoverUrl = "$_baseUrl/discover/movie?$_apiKey";
  static const upcomingUrl = "$_baseUrl/movie/upcoming?$_apiKey";
  static const genreUrl = "$_baseUrl/genre/movie/list?$_apiKey";
}

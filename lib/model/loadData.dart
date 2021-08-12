class LoadData {
  final double latitude;
  final double longitude;

  LoadData({this.latitude, this.longitude});

  factory LoadData.fromJson(Map<double, dynamic> json) {
    return LoadData(latitude: json['latitude'], longitude: json['longitude']);
    
  }
}

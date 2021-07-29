class UserModel {
  int fID;
  int fItemID;
  String? fFullName;
  String? fMobile;
  String? fPassword;
  String? fEmail;
  String? fAddress;
  bool? fDelete;
  String? fImage;
  DateTime? fUpdateDate;
  DateTime? fCreateDate;

  UserModel(
      {required this.fID,
      required this.fItemID,
      this.fFullName,
      this.fMobile,
      this.fPassword,
      this.fEmail,
      this.fAddress,
      this.fDelete,
      this.fImage,
      this.fUpdateDate,
      this.fCreateDate});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fID: json["fID"],
        fItemID: json["fItemID"],
        fFullName: json["fFullName"],
        fMobile: json["fMobile"],
        fPassword: json["fPassword"],
        fEmail: json["fEmail"],
        fAddress: json["fAddress"],
        fDelete: json["fDelete"],
        fImage: json["fImage"],
        fUpdateDate: json["fUpdateDate"] != null
            ? DateTime.parse(json["fUpdateDate"])
            : null,
        fCreateDate: json["fCreateDate"] != null
            ? DateTime.parse(json["fCreateDate"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "fID": fID,
        "fItemID": fItemID,
        "fFullName": fFullName,
        "fMobile": fMobile,
        "fPassword": fPassword,
        "fEmail": fEmail,
        "fAddress": fAddress,
        "fDelete": fDelete,
        "fImage": fImage,
        "fUpdateDate": fUpdateDate?.toIso8601String(),
        "fCreateDate": fCreateDate?.toIso8601String()
      };
}

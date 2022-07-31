import 'dart:convert';
import '../../valorant_client.dart';

class Entitlement extends ISerializable<Entitlement> {
  Entitlement(this.itemId, this.typeId);

  String typeId;
  EntitlementItemId itemId;

  factory Entitlement.fromJson(String str) =>
      Entitlement.fromMap(json.decode(str));

  @override
  Map<String, dynamic> toJson() => toMap();

  factory Entitlement.fromMap(Map<String, dynamic> json) => Entitlement(
      EntitlementItemIdExtension.fromString(json['TypeID']), json['ItemID']);

  Map<String, dynamic> toMap() => {"TypeID": typeId, 'ItemID': itemId.uuid};

  @override
  Entitlement fromJson(Map<String, dynamic> json) => Entitlement.fromMap(json);
}

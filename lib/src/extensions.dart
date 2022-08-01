import 'package:valorant_client/src/enums.dart';

import 'helpers.dart';
import 'models/asset_id.dart';
import 'models/event.dart';
import 'models/id_collection.dart';
import 'enums.dart';
import 'models/user.dart';

extension IdCollectionExtension on IdCollection {
  Id getCharacterById(String id) => characters.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getMapById(String id) => maps.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getChromaById(String id) => chromas.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getSkinById(String id) => skins.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getSkinLevelById(String id) => skinLevels.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getAttachmentById(String id) => attachments.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getEquipById(String id) => equips.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getThemeById(String id) => themes.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getGameModeById(String id) => gameModes.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getSprayById(String id) => sprays.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getSprayLevelById(String id) => sprayLevels.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getCharmById(String id) => charms.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getCharmLevelById(String id) => charmLevels.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getPlayerCardById(String id) => playerCards.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getPlayerTitleById(String id) => playerTitles.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getStorefrontItemById(String id) => storefrontItems.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Event getSeasonById(String id) => seasons.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
  Event getEventById(String id) => events.singleWhere(
      (element) => !isNullOrEmpty(element.id) && element.id! == id);
}

extension StringExtension on String {
  Id? parseAsRiotAssetId(List<Id> ids) => ids.isNotEmpty
      ? ids.singleWhere(
          (element) => !isNullOrEmpty(element.id) && element.id! == this)
      : null;
}

extension UserExtension on User {
  String get renderedDisplayName => '$gameName#$tagLine';
}

extension EnumExtensions on Enum {
  String get humanized => toString().split('.').last;
}

extension PlayerEntitlementIdExtension on PlayerEntitlementId {
  static const ids = [
    '01bb38e1-da47-4e6a-9b3d-945fe4655707', //	Agents
    'f85cb6f7-33e5-4dc8-b609-ec7212301948', // 	Contracts
    'd5f120f8-ff8c-4aac-92ea-f2b5acbe9475', // 	Sprays
    'dd3bf334-87f3-40bd-b043-682a57a8dc3a', // 	Gun Buddies
    '3f296c07-64c3-494c-923b-fe692a4fa1bd', // 	Cards
    'e7c63390-eda7-46e0-bb7a-a6abdacd2433', // 	Skins
    '3ad1b2b2-acdb-4524-852f-954a76ddae0a', // 	Skin Variants
    'de7caa6b-adf7-4588-bbd1-143831e786c6', //
  ];

  String get uuid {
    return ids[index];
  }
}

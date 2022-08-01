import '../constants.dart';
import '../enums.dart';
import '../models/balance.dart';
import '../models/mmr.dart';
import '../models/offers.dart';
import '../models/storefront.dart';
import '../models/user.dart';
import '../url_manager.dart';
import '../valorant_client_base.dart';
import '../extensions.dart';

class PlayerInterface {
  final ValorantClient _client;

  PlayerInterface(this._client);

  Future<String?> _determineWeaponNameFromOffer(OfferElement offer) async {
    final skinDataUri =
        Uri.parse("https://valorant-api.com/v1/weapons/skinlevels/${offer.id}");
    final skinDataResponse = await _client.executeRawRequest(
        method: HttpMethod.get, uri: skinDataUri);

    return skinDataResponse['data']['displayName'].split(' ').last;
  }

  Future<Map<String, List<OfferElement>>?> getOwnedSkins() async {
    final requestUri = Uri.parse(
        '${UrlManager.getBaseUrlForRegion(_client.userRegion)}/store/v1/entitlements/${_client.userPuuid}/${PlayerEntitlementId.skins.uuid}');
    final response = await _client.executeRawRequest(
      method: HttpMethod.get,
      uri: requestUri,
    );

    if (response == null) {
      return null;
    }

    final storeOffers = await getStoreOffers();
    final entitlements = response['Entitlements'];
    final Map<String, List<OfferElement>> ownedSkins = {};

    if (storeOffers == null) return null;
    for (final offer in storeOffers.offerList) {
      for (final entitlement in entitlements) {
        if (offer.id == entitlement['ItemID']) {
          final weaponName = await _determineWeaponNameFromOffer(offer);
          final weaponSkinsList = ownedSkins[weaponName];
          if (weaponName != null) {
            if (weaponSkinsList != null) {
              weaponSkinsList.add(offer);
            } else {
              ownedSkins.putIfAbsent(weaponName, () => [offer]);
            }
          }
        }
      }
    }

    return ownedSkins;
  }

  Future<User?> getPlayer() async {
    final requestUri = Uri.parse(
        '${UrlManager.getBaseUrlForRegion(_client.userRegion)}/name-service/v2/players');
    final response = await _client.executeRawRequest(
      method: HttpMethod.put,
      uri: requestUri,
      body: '["${_client.userPuuid}"]',
    );

    if (response == null) {
      return null;
    }

    return (response as Iterable<dynamic>).map((e) => User.fromMap(e)).first;
  }

  Future<Balance?> getBalance() async {
    final requestUri = Uri.parse(
        '${UrlManager.getBaseUrlForRegion(_client.userRegion)}/store/v1/wallet/${_client.userPuuid}');
    final response = await _client.executeRawRequest(
      method: HttpMethod.get,
      uri: requestUri,
    );

    if (response == null) {
      return null;
    }

    final points = response?['Balances'];
    final valorantPoints = points?[CurrencyConstants.valorantPointsId] as int?;
    final radianitePoints =
        points?[CurrencyConstants.radianitePointsId] as int?;
    final unknownCurrency = points?[CurrencyConstants.unknownCurrency] as int?;

    return Balance(
      valorantPoints:
          (response['Balances'][CurrencyConstants.valorantPointsId] ?? 0)
              as int,
      radianitePoints:
          (response['Balances'][CurrencyConstants.radianitePointsId] ?? 0)
              as int,
      unknownCurrency:
          (response['Balances'][CurrencyConstants.unknownCurrency] ?? 0) as int,
    );
  }

  Future<MMR?> getMMR() async {
    final requestUri = Uri.parse(
        '${UrlManager.getBaseUrlForRegion(_client.userRegion)}/mmr/v1/players/${_client.userPuuid}/competitiveupdates');
    final response = await _client.executeGenericRequest<MMR>(
      typeResolver: () => MMR(),
      method: HttpMethod.get,
      uri: requestUri,
    );

    if (response == null) {
      return null;
    }

    return response;
  }

  Future<Storefront?> getStorefront() async {
    final requestUri = Uri.parse(
        '${UrlManager.getBaseUrlForRegion(_client.userRegion)}/store/v2/storefront/${_client.userPuuid}');

    return await _client.executeGenericRequest<Storefront>(
      typeResolver: () => Storefront(),
      method: HttpMethod.get,
      uri: requestUri,
    );
  }

  Future<Offers?> getStoreOffers() async {
    final requestUri = Uri.parse(
      '${UrlManager.getBaseUrlForRegion(_client.userRegion)}/store/v1/offers/',
    );

    return await _client.executeGenericRequest<Offers>(
      typeResolver: () => Offers(),
      method: HttpMethod.get,
      uri: requestUri,
    );
  }
}

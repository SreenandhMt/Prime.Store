
import '../entities/address_entities.dart';


class AddressData extends AddressDataEntities {
  const AddressData(
      {required String name,
      required String id,
  required String number,
  required String address1,
  required String address2,
  required String city,
  required String state,
  required String postcode,
  required String landmark,
  required bool defaultAddress})
      : super(name,id,number,address1,address2,city,state,postcode,landmark,defaultAddress);

  factory AddressData.formjson(Map map) {
    return AddressData(name: map["name"],id: map["id"], number: map["number"], address1: map["address1"], address2: map["address2"], city: map["city"], state: map["state"], postcode: map["postcode"], landmark: map["landmark"], defaultAddress: map["default"]);
  }
}

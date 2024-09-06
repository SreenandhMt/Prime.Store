import 'package:equatable/equatable.dart';

class AddressDataEntities extends Equatable {
  final String? name;
  final String? id;
  final String? number;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? landmark;
  final bool? defaultAddress;

  const AddressDataEntities(
    this.name,
    this.id,
    this.number,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.landmark,
    this.defaultAddress,
  );

  @override
  List<Object?> get props => [];
  
}

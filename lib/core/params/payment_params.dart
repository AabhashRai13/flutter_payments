class PaymentParams {

  PaymentParams({
    required this.token,
    required this.amount,
    required this.currency,
    required this.reference,
    required this.customerInfo,
  });

  factory PaymentParams.fromJson(Map<String, dynamic> json) {
    return PaymentParams(
      token: json['token'] as String,
      amount: json['amount'] as int,
      currency: json['currency'] as String,
      reference: json['reference'] as String,
      customerInfo: CustomerInfo.fromJson(json['customerInfo'] as Map<String, dynamic>),
    );
  }
  final String token;
  final int amount;
  final String currency;
  final String reference;
  final CustomerInfo customerInfo;

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'amount': amount,
      'currency': currency,
      'reference': reference,
      'customerInfo': customerInfo.toJson(),
    };
  }
}

class CustomerInfo {

  CustomerInfo({
    required this.name,
    required this.email,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
    required this.countryCode,
    required this.phone,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      name: json['name'] as String,
      email: json['email'] as String,
      addressLine1: json['address_line1'] as String,
      addressLine2: json['address_line2'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zip: json['zip'] as String,
      country: json['country'] as String,
      countryCode: json['country_code'] as String,
      phone: json['phone'] as String,
    );
  }
  final String name;
  final String email;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String zip;
  final String country;
  final String countryCode;
  final String phone;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'city': city,
      'state': state,
      'zip': zip,
      'country': country,
      'country_code': countryCode,
      'phone': phone,
    };
  }
}
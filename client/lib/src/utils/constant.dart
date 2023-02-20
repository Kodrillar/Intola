import 'package:flutter/material.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/profile/domain/model/profile_model.dart';

const kLightColor = Colors.white;

const kDarkColor = Colors.black;
const kDeepOrangeColor = Colors.deepOrange;
const kDarkOrange = Color(0xFFDF6E40);
const kDarkBlue = Color(0xFF0C2C52);
const kAuthTextStyle = TextStyle(
  color: kDarkBlue,
  fontSize: 40,
  fontWeight: FontWeight.bold,
);
const kAuthOptionTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: kDarkBlue,
);

const kAuthButtonTextStyle = TextStyle(
  color: kDarkOrange,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

const kHeadingTextStyle = TextStyle(
  color: kDarkBlue,
  fontSize: 20,
  // fontWeight: FontWeight.w500,
);

const kAppBarTextStyle = TextStyle(
  color: kDarkBlue,
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

const kErrorTextStyle = TextStyle(
  color: kDarkBlue,
  fontSize: 12,
  fontWeight: FontWeight.w500,
);
const kProductNameStyle = TextStyle(
  color: kDarkBlue,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const kProductDetailStyle = TextStyle(
  color: kDarkOrange,
  fontSize: 13,
);

const kSnackBarTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 12,
);

const kProductReplica = ProductModel(
  id: '1',
  name: 'name',
  image: 'image',
  price: 'price',
  slashprice: 'slashprice',
  description: 'description',
  quantity: 'quantity',
);

const kProductListReplica = <ProductModel>[
  kProductReplica,
];

const kProfileDataReplica = ProfileModel(
  email: 'email',
  fullname: 'fullname',
);

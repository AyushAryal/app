class TokenInformation {
  Uri user;

  TokenInformation.fromJson(Map<String, dynamic> json)
      : user = Uri.parse(json["user"] as String);
}

enum UserType {
  anonymous,
  superUser,
  customer,
  merchant;

  factory UserType.fromString(String type) {
    switch (type) {
      case "anonymous":
        return UserType.anonymous;
      case "superuser":
        return UserType.superUser;
      case "customer":
        return UserType.customer;
      case "merchant":
        return UserType.merchant;
      default:
        return UserType.anonymous;
    }
  }
}

extension HumanReadable on UserType {
  String toHumanReadable() {
    if (this == UserType.superUser) {
      return "Super User";
    } else if (this == UserType.customer) {
      return "Customer";
    } else if (this == UserType.merchant) {
      return "Merchant";
    }
    return "Anonymous";
  }
}

class User {
  final Uri url;
  final String username;
  final String email;
  final UserType type;
  final Uri? profile;

  User.fromJson(Map<String, dynamic> data)
      : url = Uri.parse(data["url"] as String),
        username = data["username"] as String,
        email = data["email"] as String,
        type = UserType.fromString(data["type"] as String),
        profile = (data["profile"] as String?) != null
            ? Uri.parse((data["profile"] as String))
            : null;
}

class CustomerProfile {
  final Uri url;
  final User user;
  final int gender;
  final String city;
  final String state;
  final String contact;
  final String citizenship;

  CustomerProfile.fromJson(Map<String, dynamic> data)
      : url = Uri.parse(data["url"] as String),
        user = User.fromJson(data["user"] as Map<String, dynamic>),
        gender = data["gender"] as int,
        city = data["city"] as String,
        state = data["state"] as String,
        contact = data["contact"] as String,
        citizenship = data["citizenship"] as String;
}

class MerchantProfile {
  final Uri url;
  final User user;
  final int gender;
  final String city;
  final String state;
  final String contact;

  MerchantProfile.fromJson(Map<String, dynamic> data)
      : url = Uri.parse(data["url"] as String),
        user = User.fromJson(data["user"] as Map<String, dynamic>),
        gender = data["gender"] as int,
        city = data["city"] as String,
        state = data["state"] as String,
        contact = data["contact"] as String;
}

class Item {
  final Uri url;
  final Uri merchant;
  final String name;
  final String description;
  final double rate;

  Item.fromJson(Map<String, dynamic> data)
      : url = Uri.parse(data["url"] as String),
        merchant = Uri.parse(data["merchant"] as String),
        name = data["name"] as String,
        description = data["description"] as String,
        rate = data["rate"] as double;
}

class Invoice {
  final Uri url;
  final Uri customer;
  final String timestamp;

  Invoice.fromJson(Map<String, dynamic> data)
      : url = Uri.parse(data["url"] as String),
        customer = Uri.parse(data["customer"] as String),
        timestamp = data["timestamp"] as String;
}

class Purchase {
  final Uri url;
  final Uri invoice;
  final Item item;
  final String status;
  final int quantity;

  Purchase.fromJson(Map<String, dynamic> data)
      : url = Uri.parse(data["url"] as String),
        invoice = Uri.parse(data["invoice"] as String),
        item = Item.fromJson(data["item"] as Map<String, dynamic>),
        status = data["status"] as String,
        quantity = data["quantity"] as int;
}

class Review {
  final Uri url;
  final String review;
  final Item item;
  final CustomerProfile customer;
  final String timestamp;

  Review.fromJson(Map<String, dynamic> data)
      : url = Uri.parse(data["url"] as String),
        review = data["review"] as String,
        item = Item.fromJson(data["item"] as Map<String, dynamic>),
        customer =
            CustomerProfile.fromJson(data["customer"] as Map<String, dynamic>),
        timestamp = data["timestamp"] as String;
}

const String response = """
[
    {
        "id": 1,
        "name": "Tomato",
        "image": "https://www.seekpng.com/png/full/180-1808528_tomato-illustration-vector-and-png-tomato-illustration-vector.png",
        "rate": 30,
        "description": "This is a tomato.This is a tomato.This is a tomato.This is a tomato.This is a tomato."
    },
    {
        "id": 2,
        "name": "Potato",
        "image": "https://img.freepik.com/free-vector/vector-illustration-potato-colorful-gradient-mascot_341269-960.jpg?w=2000",
        "rate": 57,
        "description": "This is a Potato."
    },
    {
        "id": 3,
        "name": "Ginger",
        "image": "https://img.freepik.com/premium-vector/set-fresh-ginger-roots-isolated-white-background-vegan-food-icons-trendy-cartoon-style-healthy-food-concept-design_168129-398.jpg?w=2000",
        "rate": 47,
        "description": "This is a Ginger."
    },
    {
        "id": 4,
        "name": "Garlic",
        "image": "https://img.freepik.com/premium-vector/garlic-vector-hand-drawn-head-garlic-isolated-background_148553-133.jpg",
        "rate": 20,
        "description": "This is a Garlic."
    },
    {
        "id": 5,
        "name": "Cabbage",
        "image": "https://img.freepik.com/premium-vector/cabbage-vector-isolated-white-background_527939-160.jpg?w=2000",
        "rate": 95,
        "description": "This is a Cabbage."
    }
]
""";

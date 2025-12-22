import 'package:flutter/material.dart';

import 'Images.dart';

/// Dashboard Screen Arrays
final List<Map<String, dynamic>> categories = [
  {
    'image': Images.pizza,
    'title': 'Pizza',
    'subtitle': '20 items are available',
  },

  {
    'image': Images.burger,
    'title': 'Burgers',
    'subtitle': '20 items are available',
  },
  {
    'image': Images.fries,
    'title': 'Fries',
    'subtitle': '20 items are available',
  },
  {
    'image': Images.cake,
    'title': 'Cakes',
    'subtitle': '20 items are available',
  },
  {
    'image': Images.iceCream,
    'title': 'IceCream',
    'subtitle': '20 items are available',
  },
  {
    'image': Images.momo,
    'title': 'Momos',
    'subtitle': '15 items are available',
  },
  {
    'image': Images.noodles,
    'title': 'Noodles',
    'subtitle': '20 items are available',
  },
];

final List<Map<String, dynamic>> menuItems = [
  {
    "id": 1,
    "title": "Margherita Pizza",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVmL7uhAVY5ceFv3y9c_6Nu3ftBxdH26nkhA&s",
    "restaurant": "Pizza Palace",
    "price": 8.99,
    "rating": "5.2",
  },
  {
    "id": 2,
    "title": "Veggie Burger",
    "image":
        "https://www.noracooks.com/wp-content/uploads/2023/04/veggie-burgers-1-2.jpg",
    "restaurant": "Burger Hub",
    "price": 6.49,
    "rating": "3.5",
  },
  {
    "id": 3,
    "title": "Caesar Salad",
    "image":
        "https://static01.nyt.com/images/2024/09/10/multimedia/JG-Parmesan-Crusted-Salmon-Caesar-Saladrex-kjpb/JG-Parmesan-Crusted-Salmon-Caesar-Saladrex-kjpb-mediumSquareAt3X.jpg",
    "restaurant": "Healthy Bites",
    "price": 5.75,
    "rating": "4.2",
  },
];

final List<Map<String, dynamic>> topRatedRestaurants = [
  {
    "id": 1,
    "restaurant": "Wow! Momo",
    "categories": "Momos",
    "deliveryTime": "40-50 mins",
    "isFavourite": true,
    "image":
        "https://lh3.googleusercontent.com/p/AF1QipOuJEWf42qQP9M8X6ue-wejQSqrKoKSQJSzpJQ=s680-w680-h510-rw",
    "logo":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiwoXUAbNVCz_aJk7dsfZieHPJDojdUHS9ww&s",
    "startingPrice": "99",
    "rating": "4.3",
    "address": "C.G. Road, Navrangpura, Ahmedabad, Gujarat 380009",
    "menu": [
      {
        "id": 1,
        "name": "Steamed Momos",
        "description":
            "Soft, freshly steamed dumplings stuffed with farm-fresh vegetables, served with a tangy chutney for the perfect light snack.",
        "rating": "4.5",
        "deliveryTime": "25 mins",
        "price": "120",
        "image":
            "https://www.hindustantimes.com/ht-img/img/2023/08/16/550x309/momos_1692173876145_1692173886745.jpg",
        "oldPrice": 140,
        "newPrice": 120,
        "saved": true,
        "quantity": 2,
        "orderPercentage": 25,
        "couponsApplicable": true,
      },
      {
        "id": 2,
        "name": "Fried Momos",
        "description":
            "Golden-fried dumplings with a crisp outer layer, bursting with spiced fillings inside. Best paired with our fiery red chutney.",
        "rating": 4.3,
        "deliveryTime": "30 mins",
        "price": "140",
        "image":
            "https://i0.wp.com/prasuma.com/wp-content/uploads/2020/11/Tandoori-Momo.jpg?fit=800%2C470&ssl=1",
        "oldPrice": 160,
        "newPrice": 140,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 30,
        "couponsApplicable": true,
      },
      {
        "id": 3,
        "name": "Tandoori Momos",
        "description":
            "Smoky and flavorful momos marinated in spices and cooked in a traditional clay tandoor, served sizzling hot.",
        "rating": 4.6,
        "deliveryTime": "35 mins",
        "price": "160",
        "image":
            "https://www.bigbasket.com/media/uploads/recipe/w-l/4389_2_1.jpg",
        "oldPrice": "",
        "newPrice": 160,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 40,
        "couponsApplicable": false,
      },
      {
        "id": 4,
        "name": "Chocolate Momos",
        "description":
            "A dessert twist on momos – soft dumplings filled with melted chocolate and served warm for a sweet indulgence.",
        "rating": "4.1",
        "deliveryTime": "20 mins",
        "price": "110",
        "image":
            "https://www.themomoking.com/wp-content/uploads/2020/07/HAZELNUT-DARK-CHOCOLATE-.png",
        "oldPrice": 120,
        "newPrice": 110,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 15,
        "couponsApplicable": false,
      },
      {
        "id": 5,
        "name": "Gravy Momos",
        "description":
            "Steamed dumplings tossed in a rich, tangy gravy with herbs and spices, creating a hearty and flavorful meal.",
        "rating": "4.4",
        "deliveryTime": "40 mins",
        "price": "199",
        "image":
            "https://images.slurrp.com/prod/rich_article/lqu7vieooxg.webp?impolicy=slurrp-20210601&width=880&height=500",
        "oldPrice": 220,
        "newPrice": 199,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 20,
        "couponsApplicable": true,
      },
    ],
  },
  {
    "id": 2,
    "restaurant": "Pizza Hut",
    "categories": "Pizza, Italian",
    "deliveryTime": "35-45 mins",
    "startingPrice": "59",
    "isFavourite": true,
    "rating": "3.2",
    "image":
        "https://api.pizzahut.io/v1/content/en-in/in-1/images/pizza/margherita.5f4ef870fb437d0f7e82360758641f2b.1.jpg",
    "logo":
        "https://mma.prnewswire.com/media/1583100/Pizza_Hut_Logo.jpg?p=facebook",
    "address": "CG Road, Maninagar, Ahmedabad, Gujarat 380008",
    "description":
        "Pizza Hut is known for its oven-baked pizzas with a variety of toppings, stuffed crusts, pasta, and sides. Perfect for casual dining or delivery, serving freshly made pizzas with cheesy goodness.",
    "menu": [
      {
        "name": "Margherita Pizza",
        "description":
            "Classic hand-tossed pizza topped with tangy tomato sauce, fresh mozzarella, and a sprinkle of herbs — simple yet flavorful.",
        "rating": "4.6",
        "deliveryTime": "20 mins",
        "price": "249",
        "image":
            "https://api.pizzahut.io/v1/content/en-in/in-1/images/pizza/margherita.5f4ef870fb437d0f7e82360758641f2b.1.jpg",
        "oldPrice": 279,
        "newPrice": 249,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 35,
        "couponsApplicable": true,
      },
      {
        "name": "Farmhouse Pizza",
        "description":
            "Loaded with fresh vegetables — crunchy capsicum, juicy tomatoes, crisp onions, and mushrooms on a cheesy base.",
        "rating": "4.5",
        "deliveryTime": "22 mins",
        "price": "349",
        "image":
            "https://api.pizzahut.io/v1/content/en-in/in-1/images/pizza/kadhai-paneer.86f5d60ae5c4f1e7f41b89be36aa275d.1.jpg",
        "oldPrice": "",
        "newPrice": 349,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 29,
        "couponsApplicable": true,
      },
      {
        "name": "Garlic Breadsticks",
        "description":
            "Soft, buttery breadsticks baked to perfection, brushed with garlic seasoning, and served with tangy marinara dip.",
        "rating": "4.3",
        "deliveryTime": "18 mins",
        "price": "159",
        "image":
            "https://api.pizzahut.io/v1/content/en-in/in-1/images/side/creamy-garlic-bread-stix.56bac02d589517202398a899db7016e8.1.jpg",
        "oldPrice": 179,
        "newPrice": 159,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 24,
        "couponsApplicable": false,
      },
    ],
  },
  {
    "id": 3,
    "restaurant": "Chur Chur Naan",
    "categories": "North Indian",
    "deliveryTime": "30-40 mins",
    "startingPrice": "199",
    "rating": "4.9",
    "address": "Ashram Road, Navrangpura, Ahmedabad, Gujarat 380009",
    "isFavourite": false,
    "image":
        "https://media-assets.swiggy.com/swiggy/image/upload/f_auto,q_auto,fl_lossy/06b435723a3aa495f3b38ab83e5a4e92",
    "description":
        "Famous for its authentic North Indian flavors, Chur Chur Naan serves buttery, crispy naan stuffed with flavorful fillings along with rich gravies and curries. A true Punjabi delight.",
    "menu": [
      {
        "name": "Paneer Chur Chur Naan",
        "description":
            "Flaky chur chur naan stuffed with spicy paneer filling, brushed with butter, and served with dal makhani and chutneys.",
        "rating": "4.7",
        "deliveryTime": "25 mins",
        "price": "199",
        "image":
            "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_240,h_240/FOOD_CATALOG/IMAGES/CMS/2025/7/3/762e0c36-b27e-4cfc-a6a6-66c2becc17ec_ca33b3ee-75fc-4471-be1d-0bac6fd0e489.jpg",
        "oldPrice": 229,
        "newPrice": 199,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 42,
        "couponsApplicable": true,
      },
      {
        "name": "Aloo Pyaz Chur Chur Naan",
        "description":
            "Crispy naan stuffed with spiced potato and onion filling, cooked to golden perfection, and served with tangy pickles.",
        "rating": "4.5",
        "deliveryTime": "23 mins",
        "price": "179",
        "image":
            "https://media-assets.swiggy.com/swiggy/image/upload/f_auto,q_auto,fl_lossy/06b435723a3aa495f3b38ab83e5a4e92",
        "oldPrice": "",
        "newPrice": 179,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 37,
        "couponsApplicable": false,
      },
      {
        "name": "Chole Chur Chur Naan",
        "description":
            "Buttery naan paired with spicy Punjabi chole, garnished with onions and chutneys — the perfect comfort food.",
        "rating": "4.6",
        "deliveryTime": "24 mins",
        "startingPrice": "189",
        "image":
            "https://b.zmtcdn.com/data/reviews_photos/d5d/fcae990254fe2e605e4abb1ca2f49d5d_1728302627.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
        "oldPrice": 219,
        "newPrice": 189,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 33,
        "couponsApplicable": true,
      },
    ],
  },
  {
    "id": 4,
    "restaurant": "Kovallam",
    "categories": "South Indian",
    "startingPrice": "299",
    "deliveryTime": "25-35 mins",
    "rating": "3.3",
    "address": "Bopal, Ahmedabad, Gujarat 380058",
    "isFavourite": true,
    "image":
        "https://b.zmtcdn.com/data/dish_photos/965/88c7056a430d31788f1c263a0c458965.jpeg?fit=around|130:130&crop=130:130;*,*",
    "logo":
        "https://sadosacafe.com/wp-content/uploads/elementor/thumbs/WhatsApp_Image_2024-12-19_at_23.12.42_a351c1b5-removebg-preview-r3p4g1wxnwmvnt4j9bbar94gdweviycj2q531ikgpk.png,",
    "description":
        "Sa Dosa Cafe brings the authentic taste of South Indian cuisine, specializing in crisp dosas, soft idlis, and comforting sambhar. A go-to place for traditional flavors.",
    "menu": [
      {
        "name": "Masala Dosa",
        "description":
            "Crispy golden dosa stuffed with a spiced potato filling, served with coconut chutney and sambhar.",
        "rating": "4.8",
        "deliveryTime": "20 mins",
        "price": "129",
        "image":
            "https://b.zmtcdn.com/data/dish_photos/a7e/51cfeec639400bb7d78184d0fb037a7e.jpeg?fit=around|130:130&crop=130:130;*,*",
        "oldPrice": 325,
        "newPrice": 305,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 48,
        "couponsApplicable": true,
      },
      {
        "name": "Plain Dosa",
        "description":
            "Delicous crepe made with a mix of Rice and Lentils, accompanied with 250gm of Sambhar & 100gm Coconut Chutney",
        "rating": "4.5",
        "deliveryTime": "22 mins",
        "price": "139",
        "image":
            "https://b.zmtcdn.com/data/dish_photos/38f/627b91dc87034c7cd0cc54dd3ad9038f.jpeg?fit=around|130:130&crop=130:130;*,*",
        "oldPrice": 255,
        "newPrice": 220,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 31,
        "couponsApplicable": true,
      },
      {
        "name": "Podi Onion Masala Dosa",
        "description":
            "Pody Onion Dosa stuffed with spicy potato and onion stuffing, accompanied with 250gm of Sambhar & 100gm Coconut Chutney",
        "rating": "4.5",
        "deliveryTime": "22 mins",
        "price": "139",
        "image":
            "https://b.zmtcdn.com/data/dish_photos/96d/98f460f49f8e14b9223ceb55e2d7796d.jpeg?fit=around|130:130&crop=130:130;*,*",
        "oldPrice": 365,
        "newPrice": 355,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 31,
        "couponsApplicable": true,
      },
      {
        "name": "Butter Tossed Pody Idli",
        "description":
            "Chopped Idlis tossed with butter in our in-house famous pody chutney (gun powder)",
        "rating": "4.6",
        "deliveryTime": "18 mins",
        "price": "99",
        "image":
            "https://b.zmtcdn.com/data/dish_photos/860/034991d87b4525918babb2f20cb7c860.jpeg?fit=around|130:130&crop=130:130;*,*",
        "oldPrice": 160,
        "newPrice": 140,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 27,
        "couponsApplicable": false,
      },

      {
        "name": "Kurkuri Idli",
        "description":
            "Steamed Idli cut into small pieces, deep fried and tossed in our in-house special masala in jain not available",
        "rating": "4.6",
        "deliveryTime": "18 mins",
        "price": "99",
        "image":
            "https://b.zmtcdn.com/data/dish_photos/f4e/e89d1718557468aa7d415db116e8af4e.jpeg?fit=around|130:130&crop=130:130;*,*",
        "oldPrice": "",
        "newPrice": 255,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 27,
        "couponsApplicable": false,
      },
    ],
  },
];

final List<Map<String, dynamic>> restaurants = [
  {
    "id": 1,
    "restaurant": "K's Charcoal",
    "categories":
        "Pizza, Pasta, Italian, Fast Food, Salad, Desserts, Beverages",
    "deliveryTime": "30–40 min",
    "isFavourite": false,
    "image":
        "https://b.zmtcdn.com/data/pictures/5/20800555/a4cdf89d2129f2c2450d81b850e9dc01.jpg",
    "startingPrice": "499",
    "rating": "4.6",
    "reviews": "1540",
    "address": "Sindhu Bhavan, Ahmedabad, Gujarat",
    "menu": [
      {
        "name": "Cheese Burst Pizza",
        "description":
            "Wood-fire pizza with extra soft crust, topped with fresh mozzarella, basil, olives and cherry tomatoes.",
        "rating": "4.7",
        "deliveryTime": "30 mins",
        "price": "499",
        "image":
            "https://b.zmtcdn.com/data/pictures/5/20800555/a4cdf89d2129f2c2450d81b850e9dc01.jpg",
        "oldPrice": "",
        "newPrice": 989,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 35,
        "couponsApplicable": true,
      },
      {
        "name": "Pasta Alfredo",
        "description":
            "Creamy alfredo pasta with fresh cream, mushrooms, and parmesan.",
        "rating": "4.4",
        "deliveryTime": "25 mins",
        "price": "350",
        "image":
            "https://lh3.googleusercontent.com/gps-cs-s/AC9h4nq4YuwdmyR_bmwJJf6HWzEX1NpYGwIKA9x8okRFzCdMNhCCkaNuL7l_GalmXZpQ7s706n4eTrwtSC683OtNnUba0PP2IgWovgCagw1nuIpfqITPqn64YhPma2uxwVnOOwxBIPmrtg=w243-h174-n-k-no-nu",
        "oldPrice": '',
        "newPrice": 490,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 25,
        "couponsApplicable": false,
      },
      {
        "name": "Tomato & Basil soup",
        "description":
            "A bowl of goodness, warm, comforting and full of flavours",
        "rating": "4.4",
        "deliveryTime": "25 mins",
        "price": "350",
        "image":
            "https://lh3.googleusercontent.com/p/AF1QipM7apAY2vTXhVAtW5jZe36i3nYrEQ35Uz4MISSj=s1360-w1360-h1020-rw",
        "oldPrice": "",
        "newPrice": 680,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 25,
        "couponsApplicable": false,
      },
      {
        "name": "Tortellini",
        "description": "Bite sized pasta wonders filled with savory surprises",
        "rating": "4.4",
        "deliveryTime": "25 mins",
        "price": "350",
        "image":
            "https://lh3.googleusercontent.com/gps-cs-s/AC9h4no7FSENKbKuUFVcLB_Fz19CqG-ousHC1YImjFDo4glOqesdlJyViautUNKus-Ur5pzraMwqyjDgkQM6Lh7zr9D-kQIW7gHcQe0vR4mUuTu0B_XBd3_UKIylY1rTXUnr6Ji4os-XQBQh81s3=s1360-w1360-h1020-rw",
        "oldPrice": "",
        "newPrice": 550,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 25,
        "couponsApplicable": false,
      },
    ],
  },
  {
    "id": 2,
    "restaurant": "Kovallam Restaurant- The South Indian Kitchen",
    "categories":
        "Chinese, Biryani, Beverages, Tandoor, Salads, Snacks, Pastas, Fast Food, North Indian",
    "deliveryTime": "25–35 min",
    "isFavourite": false,
    "image":
        "https://content3.jdmagicbox.com/comp/ahmedabad/c6/079pxx79.xx79.180822143130.n7c6/catalogue/kovallam-c-g-road-ahmedabad-south-indian-restaurants-nlyran83nu.jpg",
    "startingPrice": "99",
    "rating": "4.5",
    "reviews": "2000",
    "address": "Iskon, Ahmedabad, Gujarat",
    "menu": [
      {
        "name": "Masala Dosa",
        "description":
            "Crispy dosa stuffed with spicy potato masala, served with chutney & sambar.",
        "rating": "4.6",
        "deliveryTime": "20 mins",
        "price": "120",
        "image":
            "https://www.awesomecuisine.com/wp-content/uploads/2008/02/masala_dosa.jpg",
        "oldPrice": 140,
        "newPrice": 120,
        "saved": true,
        "quantity": 1,
        "orderPercentage": 40,
        "couponsApplicable": true,
      },
      {
        "name": "Idli Sambar",
        "description":
            "Soft steamed idlis served with piping hot sambar and coconut chutney.",
        "rating": "4.3",
        "deliveryTime": "15 mins",
        "price": "80",
        "image":
            "https://www.indianhealthyrecipes.com/wp-content/uploads/2019/11/idli-sambar.jpg",
        "oldPrice": 90,
        "newPrice": 80,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 30,
        "couponsApplicable": false,
      },
    ],
  },
  {
    "id": 3,
    "restaurant": "The Project Café",
    "categories": "Italian, Continental, Cafe, Coffee, Sandwich, American",
    "deliveryTime": "35–45 min",
    "isFavourite": true,
    "image":
        "https://b.zmtcdn.com/data/pictures/1/113601/10ee0d621cc95fee08cf041b22b309e3.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
    "logo":
        "https://b.zmtcdn.com/data/pictures/1/113601/10ee0d621cc95fee08cf041b22b309e3.jpg",
    "startingPrice": "199",
    "rating": "4.3",
    "reviews": "2555",
    "address": "Ambavadi, Ahmedabad, Gujarat",
    "menu": [
      {
        "name": "Classic Club Sandwich",
        "description":
            "Triple layered club sandwich stuffed with veggies, mayo, and cheese.",
        "rating": "4.2",
        "deliveryTime": "20 mins",
        "price": "220",
        "image":
            "https://www.vegrecipesofindia.com/wp-content/uploads/2021/02/veg-club-sandwich-recipe.jpg",
        "oldPrice": 250,
        "newPrice": 220,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 28,
        "couponsApplicable": true,
      },
      {
        "name": "Cold Coffee",
        "description":
            "Chilled creamy coffee served with whipped cream topping.",
        "rating": "4.5",
        "deliveryTime": "15 mins",
        "price": "150",
        "image":
            "https://static.toiimg.com/thumb/84786539.cms?imgsize=170778&width=800&height=800",
        "oldPrice": 160,
        "newPrice": 150,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 22,
        "couponsApplicable": false,
      },
    ],
  },
  {
    "id": 4,
    "restaurant": "Rajwadu",
    "categories": "Authentic Gujarati Food, Jalebi, Juice, Drink.",
    "deliveryTime": "40–50 min",
    "isFavourite": true,
    "image":
        "https://b.zmtcdn.com/data/pictures/chains/7/113757/e28999ebb14f8f6159065b74ab809a1d_featured_v2.jpg",
    "startingPrice": "50",
    "rating": "4.4",
    "reviews": "1233",
    "address": "Vejalpur, Ahmedabad, Gujarat",
    "menu": [
      {
        "name": "Gujarati Thali",
        "description":
            "A traditional Gujarati thali with dal, kadhi, rotis, rice, shaak, farsan, papad, and sweets.",
        "rating": "4.7",
        "deliveryTime": "40 mins",
        "price": "350",
        "image": "https://static.toiimg.com/photo/70566134.cms",
        "oldPrice": 399,
        "newPrice": 350,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 45,
        "couponsApplicable": true,
      },
      {
        "name": "Jalebi Fafda",
        "description":
            "Crispy fafda paired with hot syrupy jalebis – a Gujarati festive delight.",
        "rating": "4.5",
        "deliveryTime": "25 mins",
        "price": "150",
        "image":
            "https://www.cookwithmanali.com/wp-content/uploads/2017/03/Fafda-Jalebi-Recipe.jpg",
        "oldPrice": 170,
        "newPrice": 150,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 30,
        "couponsApplicable": false,
      },
    ],
  },
  {
    "id": 5,
    "restaurant": "Unlocked Cafe",
    "categories": "Fast Food, North Indian, Desserts, Beverages, Italian",
    "deliveryTime": "20–30 min",
    "isFavourite": false,
    "image":
        "https://b.zmtcdn.com/data/pictures/chains/5/18454925/9286f70e3189210bb83a6512f584effc.jpg",
    "startingPrice": "150",
    "rating": "4.2",
    "reviews": "540",
    "address": "Navrangpura, Ahmedabad, Gujarat",
    "menu": [
      {
        "name": "Peri Peri Fries",
        "description": "Crispy French fries tossed in spicy peri peri masala.",
        "rating": "4.3",
        "deliveryTime": "15 mins",
        "price": "120",
        "image":
            "https://www.indianhealthyrecipes.com/wp-content/uploads/2021/01/peri-peri-fries.jpg",
        "oldPrice": 140,
        "newPrice": 120,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 25,
        "couponsApplicable": true,
      },
      {
        "name": "Brownie with Ice Cream",
        "description":
            "Warm chocolate brownie served with a scoop of vanilla ice cream.",
        "rating": "4.5",
        "deliveryTime": "20 mins",
        "price": "180",
        "image":
            "https://static.toiimg.com/thumb/84786539.cms?imgsize=170778&width=800&height=800",
        "oldPrice": 200,
        "newPrice": 180,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 30,
        "couponsApplicable": false,
      },
    ],
  },
  {
    "id": 6,
    "restaurant": "Tinello – Hyatt Regency",
    "categories": "Healthy Breakfast, Risotto, Tiramisu, Spaghetti, Lasagna",
    "deliveryTime": "45–55 min",
    "isFavourite": true,
    "image":
        "https://b.zmtcdn.com/data/pictures/chains/2/113732/bcf0762188feb652dbc5ca3e9eab30df.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
    "startingPrice": "299",
    "rating": "4.5",
    "reviews": "2230",
    "address": "Ashram Road, Ahmedabad, Gujarat",
    "menu": [
      {
        "name": "Risotto Primavera",
        "description":
            "Classic Italian risotto made with seasonal vegetables and parmesan cheese.",
        "rating": "4.6",
        "deliveryTime": "40 mins",
        "price": "599",
        "image":
            "https://www.simplyrecipes.com/thmb/VczZp0gZsT6dJ3cQNTd38qRAjT0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Risotto-LEAD-02-8876acb0c91a47e39b4e8f1ed7a78ecb.jpg",
        "oldPrice": 650,
        "newPrice": 599,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 35,
        "couponsApplicable": true,
      },
      {
        "name": "Tiramisu",
        "description":
            "Authentic Italian tiramisu with mascarpone, coffee-soaked ladyfingers, and cocoa.",
        "rating": "4.7",
        "deliveryTime": "25 mins",
        "price": "350",
        "image":
            "https://static.toiimg.com/thumb/84786539.cms?imgsize=170778&width=800&height=800",
        "oldPrice": 380,
        "newPrice": 350,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 28,
        "couponsApplicable": false,
      },
    ],
  },
  {
    "id": 7,
    "restaurant": "The Belgian Waffle Co.",
    "categories": "Waffle, Pancake, Ice Cream, Desserts, Beverages, Shake",
    "deliveryTime": "30–40 min",
    "isFavourite": false,
    "image":
        "https://b.zmtcdn.com/data/pictures/chains/1/18543621/9b7610445f151daaffda3acd3fcec90b.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
    "startingPrice": "69",
    "rating": "4.4",
    "reviews": "500",
    "address": "Fortune Landmark, Ahmedabad, Gujarat",
    "menu": [
      {
        "name": "Nutella Waffle",
        "description": "Crispy waffle filled with gooey Nutella spread.",
        "rating": "4.6",
        "deliveryTime": "20 mins",
        "price": "160",
        "image":
            "https://static.toiimg.com/thumb/84786539.cms?imgsize=170778&width=800&height=800",
        "oldPrice": 180,
        "newPrice": 160,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 40,
        "couponsApplicable": true,
      },
      {
        "name": "Strawberry Pancake",
        "description":
            "Fluffy pancakes topped with fresh strawberries & cream.",
        "rating": "4.5",
        "deliveryTime": "15 mins",
        "price": "150",
        "image":
            "https://www.simplyrecipes.com/thmb/YVgKg7cM31V7FgE9U-W5tC0TSG0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Strawberry-Pancakes-LEAD-07b278e1d83344e39df41a3e79b1896f.jpg",
        "oldPrice": 170,
        "newPrice": 150,
        "saved": true,
        "quantity": 0,
        "orderPercentage": 35,
        "couponsApplicable": false,
      },
    ],
  },
  {
    "id": 8,
    "restaurant": "Cafe Mocha",
    "categories": "Cafe, Desserts, Beverages",
    "image":
        "https://b.zmtcdn.com/data/reviews_photos/50b/8cc15126caf6c6be7f5c0b5ce75e750b_1446889515.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
    "startingPrice": "499",
    "rating": "4.6",
    "reviews": "1540",
    "address": "Sindhu Bhavan, Ahmedabad, Gujarat",
    "deliveryTime": "25-35 mins",
    "isFavourite": false,
    "description":
        "A cozy cafe known for its aromatic coffees, refreshing beverages, and indulgent desserts. Perfect for casual hangouts and sweet cravings.",
    "menu": [
      {
        "item": "Cappuccino",
        "oldPrice": 180,
        "newPrice": 150,
        "saved": 30,
        "isBestSeller": true,
      },
      {
        "item": "Mocha Frappe",
        "oldPrice": 220,
        "newPrice": 190,
        "saved": 30,
        "isBestSeller": true,
      },
      {
        "item": "Chocolate Lava Cake",
        "oldPrice": 250,
        "newPrice": 210,
        "saved": 40,
        "isBestSeller": false,
      },
      {
        "item": "Cheese Garlic Bread",
        "oldPrice": 160,
        "newPrice": 140,
        "saved": 20,
        "isBestSeller": false,
      },
      {
        "item": "Cold Coffee with Ice Cream",
        "oldPrice": 200,
        "newPrice": 175,
        "saved": 25,
        "isBestSeller": true,
      },
    ],
  },
];

/// Favourites Screen Arrays
final List<Map<String, String>> favouritesRestaurantList = [
  {
    "image":
        // "https://b.zmtcdn.com/data/pictures/1/110271/eabd8c8818998e6553f30490ce600a33_featured_v2.jpg?output-format=webp",
        "https://www.livemint.com/lm-img/img/2025/07/07/original/mcdonalds_1751924519321_1751924519564.jpg",
    "name": "McDonald's",
    "price": "70+",
  },
  {
    "image":
        // "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/18/213f6e83-e923-4c30-bd12-ebf12aa61ad3_81814.jpg",
        "https://i.imgur.com/7uUVaTn.jpeg",
    "name": "Burger King",
    "price": "110+",
  },
  {
    "image":
        "https://franchiseindia.s3.ap-south-1.amazonaws.com/uploads/news/fi/kfc-north-zone-outlets-to-reopen-b0bf785ed0.jpg",
    // "https://b.zmtcdn.com/data/pictures/chains/5/112945/146ff4f5f9effc840471afed23c6bfd1_featured_v2.jpg?output-format=webp",
    "name": "KFC",
    "price": "150+",
  },
  {
    "image":
        "https://upload.wikimedia.org/wikipedia/commons/7/73/A_Subway_restaurant_in_a_strip_mall_in_Franklin%2C_North_Carolina%2C_United_States.jpg",
    "name": "Subway",
    "price": "150+",
  },
  {
    "image":
        "https://statik.tempo.co/data/2021/11/05/id_1064011/1064011_720.jpg",
    "name": "Pizza Hut",
    "price": "150+",
  },
];

final List<Map<String, String>> favouritesFoodList = [
  {
    "image":
        // "https://c4.wallpaperflare.com/wallpaper/369/512/1004/pepper-hamburger-burger-mcdonald-s-wallpaper-preview.jpg",
        "https://www.sargento.com/assets/Uploads/Recipe/Image/GreatAmericanBurger.jpg",
    // "https://b.zmtcdn.com/data/reviews_photos/b25/42a7d4f999f51447149f4bae5f983b25_1628084711.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
    "name": "Cheeseburger",
    "vendor": "Micro cafe",
    "price": "200",
  },
  {
    "image":
    "https://topcashbuyer.com/wp-content/uploads/Lou-s-Deep-Dish-Cheese-Pull_DB8F95CE-5056-A36F-232859772CA0A515_4fe4f1ee-5056-a36f-231ec6b4a0e364cb.jpg",
    // "https://lh3.googleusercontent.com/p/AF1QipMDArTmOzjk8f_7fFrRLznD5tWdOGw2XRLnZ_WG=w243-h244-n-k-no-nu",
    "name": "Deep Dish Pizza",
    "vendor": "Tartine",
    "price": "500",
  },
  {
    "image":
        // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe3N2SHaahnHZpFCFghtaQcyJlJf_w3fgENQ&s",
        "https://media.istockphoto.com/id/974623806/photo/french-fries-with-cheddar-cheese-chili-and-chicken-fillet-close-up-horizontal-top-view.jpg?s=612x612&w=0&k=20&c=IFbPsArJNCLfx2sPobPFgbPxk2xN4pyJRdWvV3vS1Bg=",
    "name": "Chessy French Fries",
    "vendor": "Tortilla",
    "price": "145",
  },
  {
    "image":
        "https://assets.bonappetit.com/photos/63cb14735125107865c0fe8f/16:9/w_4000,h_2250,c_limit/012023-pav-bhaji-lede.jpg",
    "name": "Pav Bhaji",
    "vendor": "Mahalaxmi Pavbhaji center",
    "price": "150",
  },
  {
    "image":
        "https://b.zmtcdn.com/data/pictures/0/21075750/ff1ac51fa8f96cde3f5174d8e333573b_o2_featured_v2.jpg",
    "name": "Triple Chocolate Waffle",
    "vendor": "The Belgian Waffle Co.",
    "price": "215",
  },
  {
    "image":
        "https://b.zmtcdn.com/data/pictures/chains/7/19639627/5412b064a2b754c5cecbb4f204317751_o2_featured_v2.jpg",

    "name": "HL Special Paneer Frankie",
    "vendor": "HL Frankie",
    "price": "110",
  },
  {
    "image":
        "https://t4.ftcdn.net/jpg/07/12/88/45/360_F_712884560_Yo8EBdcoAApSFKvIjt5ZMoaxhPFUMyOh.jpg",
    "name": "North Indian Platter",
    "vendor": "Jassi De Parathe",
    "price": "190",
  },
];

/// DineOut Screen Arrays
final List<Map<String, dynamic>> spotlightRestaurants = [
  {
    "id": 1,
    "discount": "Flat 20% OFF",
    "restaurant": "Sankalp",
    "tagline": "Legacy of South Indian delights",
    "cta": "PREBOOK NOW",
    "bannerColor": Color(0xff2C3316),
    "image":
        "https://sankalprestaurants.com/wp-content/uploads/2023/10/Sankalp-Restaurant-79-1024x683.jpg",
  },
  {
    "id": 2,
    "discount": "Flat 50% OFF",
    "restaurant": "Novotel",
    "tagline": "Dine in luxury, savour in style",
    "cta": "PREBOOK NOW",
    "bannerColor": Color(0xff421818),
    "image":
        "https://b.zmtcdn.com/data/pictures/7/112827/d9f17515d2ce62722953529c07f7c2ce.jpg",
  },
  {
    "id": 3,
    "discount": "Flat 15% OFF",
    "restaurant": "Taj Skyline",
    "tagline": "A luxury dining experience",
    "cta": "ORDER NOW",
    "bannerColor": Color(0xff421818),
    "image":
        // "https://b.zmtcdn.com/data/pictures/chains/9/19727689/f2d3692e890f3709ceef821ef5399c33.jpg",
        "https://assets.zeezest.com/blogs/PROD_Horizontal_1706718525929.jpg",
  },
  {
    "id": 4,
    "discount": "Flat 30% OFF",
    "restaurant": "Barbeque Nation",
    "tagline": "Grill your own feast",
    "cta": "RESERVE SEAT",
    "bannerColor": Color(0xff776827),
    "image":
        "https://i0.wp.com/butterry.com/blog/wp-content/uploads/2023/06/barbeque-nation-buffet-price.webp?fit=1200%2C800&ssl=1",
  },
  {
    "id": 5,
    "discount": "Flat 10% OFF",
    "restaurant": "Patang",
    "tagline": "Where every flavour tells a story",
    "cta": "ORDER ONLINE",
    "bannerColor": Color(0xff421818),
    "image":
        "https://b.zmtcdn.com/data/pictures/2/110502/5eee561c02a072adeaad9ee85df98da8.jpg?fit=around|750:500&crop=750:500;*,*",
  },
  {
    "id": 6,
    "discount": "Flat 50% OFF",
    "restaurant": "Binori- A Boutique Hotel",
    "tagline": "Where every meal is a memory",
    "cta": "DINE IN",
    "bannerColor": Color(0xff421818),
    "image":
        "https://binorihotels.com/wp-content/uploads/2018/11/Introduction.jpg",
  },
  {
    "id": 7,
    "discount": "Flat 22% OFF",
    "restaurant": "Under The Neem Trees",
    "tagline": "A fine dine experience",
    "cta": "BOOK NOW",
    "bannerColor": Color(0xff2C3316),
    "image":
        "https://lh3.googleusercontent.com/p/AF1QipOVNTtcPnVFfgCu5ukO8XF3nxESB1rxpIRVmIs4=s680-w680-h510-rw",
  },
];

final List<Map<String, String>> mustTries = [
  {
    "title": "newly opened places",
    "image":
        "https://b.zmtcdn.com/data/collections/6922d49fb675d0490edb652abf5ca45f_1727171275.png",
  },
  {
    "title": "top trending spots",
    "image":
        "https://b.zmtcdn.com/data/pictures/2/21605022/80f95e4743c8b2d298e92168e94eb195_featured_v2.jpg",
  },
  {
    "title": "the legends of ahmedabad",
    "image":
        "https://content.jdmagicbox.com/v2/comp/ahmedabad/n8/079pxx79.xx79.240110113445.z8n8/catalogue/legends-of-punjab-by-pepperazi-nikol-gam-ahmedabad-restaurants-tq095fklla-250.jpg",
  },
  {
    "title": "best buffets in town",
    "image":
        "https://b.zmtcdn.com/data/collections/5cb59fb7cfd036e269e5bb0d46206184_1709813110.png",
  },
  {
    "title": "gujarati thalis",
    "image":
        "https://b.zmtcdn.com/data/collections/0bf7c89cc7016466a43893fd914bfe1d_1675252064.jpg",
  },
  {
    "title": "pan asian restaurants",
    "image":
        "https://b.zmtcdn.com/data/collections/0feb10b3ec5e92a84149f269144439fe_1744107745.png?fit=around|562.5:360&crop=562.5:360;*,*",
  },
  {
    "title": "south indian brekkie",
    "image":
        "https://images.pexels.com/photos/5560763/pexels-photo-5560763.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  },
  {
    "title": "insta-worthy spots",
    "image":
        "https://b.zmtcdn.com/data/collections/fbd237478a5d3b6ea08de83c30230cdd_1709815577.png",
  },
  {
    "title": "best luxary dining places",
    "image":
        "https://b.zmtcdn.com/data/collections/52d6f4ce3bfff82c6bf8966d6284cf89_1675250307.jpg",
  },
  {
    "title": "top breakfast spots",
    "image":
        "https://b.zmtcdn.com/data/collections/f123375fee94c32136696c2af1e25a28_1709812170.png",
  },
];

final List<Map<String, dynamic>> lookingFor = [
  {"title": "Rooftops", "image": Images.dineOutRooftop},
  {"title": "Cozy Cafes", "image": Images.coffeeMug},
  {"title": "Romantic dining", "image": Images.wineGlasses},
  {"title": "Buffet", "image": Images.buffettt},
  {"title": "Family dining", "image": Images.familyDiningPlate},
  {"title": "Premium dining", "image": Images.premiumDiningPlate},
];

final List<Map<String, String>> featuredRestaurants = [
  {
    "image":
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1b/e2/ba/31/photo3jpg.jpg?w=900&h=500&s=1",
    "title": "Wok On Fire",
    "address": "Thaltej",
    "cuisine": "Chinese",
    "offer": "Flat 25% off on pre-booking",
  },
  {
    "image":
        "https://lh3.googleusercontent.com/gps-cs-s/AC9h4noGhIYuQveoSLd0tz5wrHCjeor7LW-zlNVk8-CfSif6mMRPebas8xNTIo3-AlCwEBFLIT2Wv-Im-4_Q9xWHBspAhE7izCrGfOVrgfL_4aqVLDPwI-tiKnIHKserBGvJ77hZ9AmFSKdXPym4=s680-w680-h510-rw",
    "title": "Baba Budan Cafe",
    "address": "Bodakdev",
    "cuisine": "Italian",
    "offer": "Flat 30% off on pre-booking",
  },
  {
    "image":
        "https://b.zmtcdn.com/data/pictures/1/20540571/fad270705b44ff044aea03205cd2bef2.jpg?fit=around|960:500&crop=960:500;*,*",
    "title": "Table Tales - Sindhu Bhavan Road",
    "address": "Bodakdev",
    "cuisine": "Continental",
    "offer": "Flat 10% off on pre-booking",
  },
  {
    "image":
        "https://b.zmtcdn.com/data/pictures/1/20510161/51cdbee13e83d07e8f7d294b092f111e.jpg?fit=around|960:500&crop=960:500;*,*",
    "title": "Banjara",
    "address": "Bodakdev",
    "cuisine": "North Indian",
    "offer": "Flat 30% off on pre-booking",
  },
  {
    "image":
        "https://dineout-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto/DINEOUT_ALL_RESTAURANTS/IMAGES/RESTAURANT_IMAGE_SERVICE/2024/9/11/9ebcc7ae-f6b0-4c5c-a2e1-063146068553_BanjaraAmbienceEditedPictures4918867a1ef751a4375bc977b4f215ae2f9.JPG",
    "title": "Ame Cafe & Patisserie",
    "address": "Thaltej",
    "cuisine": "Italian",
    "offer": "Flat 30% off on pre-booking",
  },
  {
    "image":
        "https://b.zmtcdn.com/data/pictures/0/21273770/5d8e342d9531fe27cc77df0b54d22cdc.jpg",
    // "image": "https://b.zmtcdn.com/data/pictures/0/21273770/7e18bf5f00fa329026ad496e407dea71.jpg",
    "title": "Myka Cafe",
    "address": "Bodakdev",
    "cuisine": "North Indian",
    "offer": "Flat 30% off on pre-booking",
  },
  {
    "image":
        "https://dineout-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto/v1662163944/bxbqru1jfaoeewxgbcfl.jpg",
    "title": "Core The Coffee Shop",
    "address": "Bodakdev",
    "cuisine": "Bevarages",
    "offer": "Flat 10% off on pre-booking",
  },
  {
    "image":
        "https://dineout-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto/DINEOUT_ALL_RESTAURANTS/IMAGES/RESTAURANT_IMAGE_SERVICE/2024/12/31/8e6ef48e-cb6a-4ed0-be3f-1bddadb5d6e9_image2beb075f8985241f785c1190fd6df7303.JPG",
    "title": "Amazing Hydrabadi Dum Biryani - SBR",
    "address": "Thaltej",
    "cuisine": "North Indian",
    "offer": "Flat 25% off on pre-booking",
  },
  {
    "image":
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/d1/a3/94/outside-seating.jpg?w=500&h=-1&s=1",
    "title": "Kovallam Restaurant - The South Indian Kitchen",
    "address": "Bopal",
    "cuisine": "South Indian",
    "offer": "Flat 15% off on pre-booking",
  },
  {
    "image":
        "https://sankalprestaurants.com/wp-content/uploads/2023/05/Sankalp-Restaurant-Near-Rajpath-Club.webp",
    "title": "Sankalp - Rajpath",
    "address": "Bodakdev",
    "cuisine": "South Indian",
    "offer": "Flat 20% off on pre-booking",
  },
];

final List<Map<String, String>> drinksDesserts = [
  {
    "image":
        "https://content.jdmagicbox.com/v2/comp/delhi/x5/011pxx11.xx11.230728162101.s1x5/catalogue/chelvies-coffee-punjabi-bagh-delhi-fast-food-Xe7s4Ezzvx.jpg",
    "restaurantName": "Chelvis Coffee",
    "cuisine": "Continental • American",
    "location": "Gulbai Tekra, 5.5 km",
    "rating": "4.1",
    "price": "₹800 for two",
    "offers": "Flat 50% off on walk-in",
    "reviews": "650+",
  },
  {
    "image":
        "https://content.jdmagicbox.com/comp/ahmedabad/f4/079pxx79.xx79.221231213755.e4f4/catalogue/table-tales-ahmedabad-restaurants-xfmlnrskld.jpg",
    "restaurantName": "Table Tales",
    "cuisine": "Continental • North Indian",
    "location": "Bodakdev",
    "rating": "4.5",
    "price": "₹1200 for two",
    "offers": "Flat 10% off on pre-booking",
    "reviews": "600+",
  },
  {
    "image":
        "https://mirchmasala.co.in/wp-content/uploads/2019/05/SG_Highway4.jpg",
    "restaurantName": "Mirch Masala",
    "cuisine": "North Indian • Desserts",
    "location": "Bodakdev",
    "rating": "4.2",
    "price": "₹1200 for two",
    "offers": "Flat 30% off on pre-booking",
    "reviews": "610+",
  },
  {
    "image":
        "https://dineout-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto/DINEOUT_ALL_RESTAURANTS/IMAGES/RESTAURANT_IMAGE_SERVICE/2025/4/15/b8534415-52d3-4aa8-8ea8-e0adfa7a1a52_18871181a640a288dab74f54849c7dc15d2496c1.JPG",
    "restaurantName": "Afro House",
    "cuisine": "Italian • Bevarages",
    "location": "Thaltej",
    "rating": "4.7",
    "price": "₹1100 for two",
    "offers": "Flat 10% off on pre-booking",
    "reviews": "620+",
  },
];

final List<Map<String, dynamic>> popularRestaurants = [
  {
    "image": [
      "https://lh3.googleusercontent.com/p/AF1QipO6bwUKMEH6-C9cD1RIMah_UH0l9MfCTkPtZ-Ne=s680-w680-h510-rw",
      "https://content3.jdmagicbox.com/comp/ahmedabad/c4/079pxx79.xx79.201125002405.w3c4/catalogue/under-the-neem-trees-restaurant-bodakdev-ahmedabad-restaurants-6e0n4s27l9.jpg",
      "https://lh3.googleusercontent.com/p/AF1QipPPWb583e-0ORCnaGrOaJyeCZxy2-LIe-tBgBXx=s680-w680-h510-rw",
      "https://lh3.googleusercontent.com/p/AF1QipNzQwFz6hw4Q5y7xAOXsrKKK6tbKvTdWN0hsaE3=s680-w680-h510-rw",
      "https://lh3.googleusercontent.com/gps-cs-s/AC9h4nqJilAVGelFZln9GGA5_Q-1zsRHOotqK7E2tMzgNRzEV1y5s9B_s2HoWtNa4cjRiYBOpNTfd65OXGbMOlQuiyBAHFt9t-Er7mWGBRPbsLpJi1mlpMeuLfNixFXujGuLxd9JLuP3=s680-w680-h510-rw",
      "https://lh3.googleusercontent.com/gps-cs-s/AC9h4nr_YbXOiQnaXLPM9qrzCXcMui0gKTzHe68QX_x25r4udjOZDyU8kwPnK-0y44Bg41Aeu5Tw2b-W1NR1vr-uxe4I5QRbeQjvfbt13kmuj9gf3WA5OsdCSHbl8tTWx9awYBj_CvY=s680-w680-h510-rw",
    ],
    "restaurantName": "Under The Neem Trees",
    "cuisine": "Continental • American",
    "location": "Gulbai Tekra",
    "distanceFromYou": "5.5 km",
    "rating": "4.1",
    "price": "₹800 for two",
    "offers": "Flat 50% off",
    "reviews": "650+",
  },
  {
    "image": [
      "https://b.zmtcdn.com/data/pictures/4/20731314/4f0d4dd10232c89a58f9cb16df8c91e1.jpg?fit=around|960:500&crop=960:500;*,*",
    ],
    "restaurantName": "Zoca Cafe",
    "cuisine": "Cafe • Coffee",
    "location": "Bodakdev",
    "distanceFromYou": "135 m",
    "rating": "4.2",
    "price": "₹1200 for two",
    "offers": "Flat 30% off",
    "reviews": "610+",
  },
  {
    "image": [
      "https://b.zmtcdn.com/data/pictures/1/20540571/fad270705b44ff044aea03205cd2bef2.jpg?fit=around|960:500&crop=960:500;*,*",
    ],
    "restaurantName": "Afro House",
    "cuisine": "Italian • Bevarages",
    "location": "Thaltej",
    "distanceFromYou": "1.5 km",
    "rating": "4.7",
    "price": "₹1100 for two",
    "offers": "Flat 10% off",
    "reviews": "620+",
  },

  {
    "image": [
      "https://b.zmtcdn.com/data/pictures/1/20540571/fad270705b44ff044aea03205cd2bef2.jpg?fit=around|960:500&crop=960:500;*,*",
      "https://lh3.googleusercontent.com/p/AF1QipN8aszxE9rZTd6K2F4qQQFgtih5rdTR-WwwpPC2=s680-w680-h510-rw",
      "https://lh3.googleusercontent.com/gps-cs-s/AC9h4nqf0C1PbeGdq_2J6imp2IZ8mMuoOEx-CLBGSsEbgI8rH9Ana9gd-humb9q2IochQ_kNW9QcjYTspDtm3ZIfXjtTSXRuWhIrRs81q0Z_tIhpWBiTNRijPIF1hVusqYlqaOzf01-Y=s680-w680-h510-rw",
      "https://dineout-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto/DINEOUT_ALL_RESTAURANTS/IMAGES/RESTAURANT_IMAGE_SERVICE/2024/7/5/7f559fec-6368-48a7-8839-c7ba1f62dd8f_140copyc4f8a88fc6bd44b288f2a40a463b5e67.JPG",
      "https://lh3.googleusercontent.com/gps-cs-s/AC9h4noXC9sD0MbpdcZnlWojbCy3m10TcUpl4WykQ96kR6JRVb6Znp4vUnUxQy9ILx9d2IpF5lHWQO1nMU-ixExWFbUtwn4g3JO4_4TmmYD8MRWHGhee1_4H5w1aDNgNkZrcO4HI5Lg=s680-w680-h510-rw",
    ],
    "restaurantName": "Table Tales",
    "cuisine": "Continental • North Indian",
    "location": "Bodakdev",
    "distanceFromYou": "50 m",
    "rating": "4.5",
    "price": "₹1200 for two",
    "offers": "Flat 10% off",
    "reviews": "600+",
  },
];

/// ReOrder Screen Array
// final List<Map<String, dynamic>> reorderRestaurants = [
//   {
//     "restaurantName": "La Pino'z Pizza",
//     "time": "20-25 mins",
//     "benefits": "Items at ₹79 + one benefits",
//     "items": [
//       {
//         "name": "Capsicum, Paneer & Red Paprika Pizza",
//         "price": 129,
//         "originalPrice": 155,
//       },
//       {
//         "name": "Margherita Pizza",
//         "price": 182,
//       },
//     ],
//     "image":
//     "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto/fvh1golmvpcwvrjgtgnd",
//     "isFavourite": false,
//   },
//   {
//     "restaurantName": "Sa Dosa Cafe",
//     "time": "30-35 mins",
//     "benefits": "one benefits",
//     "items": [
//       {
//         "name": "Mysore Masala Dosa",
//         "price": 219,
//       },
//     ],
//     "image":
//     "https://b.zmtcdn.com/data/dish_photos/965/88c7056a430d31788f1c263a0c458965.jpeg?fit=around|130:130&crop=130:130;*,*",
//     "isFavourite": false,
//   },
//   {
//     "restaurantName": "Burger King",
//     "time": "15-20 mins",
//     "benefits": "Items at ₹59 + one benefits",
//     "items": [
//       {
//         "name": "Crispy Veg Double Patty + Crispy Veg Double Patty",
//         "price": 198,
//       },
//       {
//         "name": "Crispy Veg Double Patty",
//         "price": 99,
//       },
//     ],
//     "image":
//     "https://i.imgur.com/7uUVaTn.jpeg",
//     "isFavourite": true,
//   },
//   {
//     "restaurantName": "Punjabiyat",
//     "time": "25-30 mins",
//     "benefits": "Flat ₹100 off on orders above ₹500",
//     "items": [
//       {
//         "name": "Paneer Butter Masala",
//         "price": 249,
//       },
//       {
//         "name": "Dal Makhani",
//         "price": 199,
//       },
//     ],
//     "image":
//     "https://b.zmtcdn.com/data/pictures/chains/7/20581887/5a16e54af80e57534eab91e4627c973b.jpg?fit=around|960:500&crop=960:500;*,*",
//     "isFavourite": true,
//   }, {
//     "restaurantName": "Olio - The Wood Fired Pizzeria",
//     "time": "30-40 mins",
//     "benefits": "Items at ₹99 + one benefits",
//     "items": [
//       {
//         "name": "Paneer Red Hot Pizza",
//         "price": 486,
//       },
//       {
//         "name": "2 × Popeye's Spinach Garlic Bread",
//         "price": 523,
//       },
//       {
//         "name": "Half & Half Large Pizza",
//         "price": 400,
//       },
//     ],
//     "image":
//     "https://static.wixstatic.com/media/ac4870_4b981a584bf14469818de33329a95172~mv2.jpg/v1/fill/w_980,h_980,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/ac4870_4b981a584bf14469818de33329a95172~mv2.jpg",
//     "isFavourite": false,
//   },
// ];
final List<Map<String, dynamic>> reorderRestaurants = [
  {
    "restaurantName": "La Pino'z Pizza",
    "location": "Ambavadi, Ahmedabad",
    "time": "20-25 mins",
    "benefits": "Items at ₹79 + one benefits",
    "orderPlacedOn": "14 Aug, 1:23PM",
    "available": true,
    "items": [
      {
        "name": "Capsicum, Paneer & Red Paprika Pizza",
        "price": 129,
        "originalPrice": 155,
      },
      {"name": "Margherita Pizza", "price": 182},
    ],
    "totalAmount": 129 + 182, // 311
    "image":
        "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto/fvh1golmvpcwvrjgtgnd",
    "isFavourite": false,
  },
  {
    "restaurantName": "Sa Dosa Cafe",
    "location": "Ambavadi, Ahmedabad",
    "time": "30-35 mins",
    "benefits": "one benefits",
    "orderPlacedOn": "14 Aug, 1:23PM",
    "available": false,
    "items": [
      {"name": "Mysore Masala Dosa", "price": 219},
    ],
    "totalAmount": 219,
    "image":
        "https://b.zmtcdn.com/data/dish_photos/965/88c7056a430d31788f1c263a0c458965.jpeg?fit=around|130:130&crop=130:130;*,*",
    "isFavourite": false,
  },
  {
    "restaurantName": "Burger King",
    "location": "Ambavadi, Ahmedabad",
    "time": "15-20 mins",
    "benefits": "Items at ₹59 + one benefits",
    "orderPlacedOn": "14 Aug, 1:23PM",
    "available": true,
    "items": [
      {
        "name": "Crispy Veg Double Patty + Crispy Veg Double Patty",
        "price": 198,
      },
      {"name": "Crispy Veg Double Patty", "price": 99},
    ],
    "totalAmount": 198 + 99, // 297
    "image": "https://i.imgur.com/7uUVaTn.jpeg",
    "isFavourite": true,
  },
  {
    "restaurantName": "Punjabiyat",
    "location": "Ambavadi, Ahmedabad",
    "time": "25-30 mins",
    "benefits": "Flat ₹100 off on orders above ₹500",
    "orderPlacedOn": "14 Aug, 1:23PM",
    "available": true,
    "items": [
      {"name": "Paneer Butter Masala", "price": 249},
      {"name": "Dal Makhani", "price": 199},
    ],
    "totalAmount": 249 + 199, // 448
    "image":
        "https://b.zmtcdn.com/data/pictures/chains/7/20581887/5a16e54af80e57534eab91e4627c973b.jpg?fit=around|960:500&crop=960:500;*,*",
    "isFavourite": true,
  },
  {
    "restaurantName": "Olio - The Wood Fired Pizzeria",
    "location": "Ambavadi, Ahmedabad",
    "time": "30-40 mins",
    "benefits": "Items at ₹99 + one benefits",
    "orderPlacedOn": "14 Aug, 1:23PM",
    "available": false,
    "items": [
      {"name": "Paneer Red Hot Pizza", "price": 486},
      {"name": "2 × Popeye's Spinach Garlic Bread", "price": 523},
      {"name": "Half & Half Large Pizza", "price": 400},
    ],
    "totalAmount": 486 + 523 + 400, // 1409
    "image":
        "https://static.wixstatic.com/media/ac4870_4b981a584bf14469818de33329a95172~mv2.jpg/v1/fill/w_980,h_980,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/ac4870_4b981a584bf14469818de33329a95172~mv2.jpg",
    "isFavourite": false,
  },
];

/// Restaurant Details Screen Arrays
final List<Map<String, String>> dummyOffers = [
  {
    "tag": "DEAL OF DAY",
    "title": "Items at ₹49",
    "subtitle": "ON SELECT ITEMS",
    "image": Images.dealOfTheDay,
  },
  {
    "tag": "LIMITED TIME",
    "title": "Buy 1 Get 1 Free",
    "subtitle": "On all pizzas",
    "image": Images.percentageOffer,
  },
  {
    "tag": "NEW",
    "title": "Flat 30% Off",
    "subtitle": "On dosa varieties",
    "image": Images.percentageOffer,
  },
];

final filters = [
  {"label": "Veg Only", "icon": Images.veg, "selected": true},
  {"label": "Rating 4.0+", "icon": Images.ratingStar, "selected": false},
  {"label": "Offers", "icon": Images.discount, "selected": false},
  {"label": "Less than 30 mins", "icon": Images.time, "selected": false},
];

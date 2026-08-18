import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/ui/widgets/favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteTab extends StatelessWidget {
  List<Map<String, dynamic>> favoriteProducts = [
    {
      "title": "Nike Air Jordon",
      "finalPrice": "1,200",
      "color": const Color.fromARGB(255, 23, 23, 24),
      "imageUrl":
          "https://imgs.search.brave.com/NaDDjSX3QXU-04z5jEIziIY6ww1QLwFnktJ5ZF8RI0A/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA5LzYwLzkyLzIz/LzM2MF9GXzk2MDky/MjMyNV9Renp0emlr/cXllU3dsQWxxUFd5/NkZjSzdpOTRiV2t2/bi5qcGc",
      "salePrice": "1,500"
    },
    {
      "title": "Tall Cotton Dress",
      "finalPrice": "600",
      "color": const Color.fromARGB(255, 233, 123, 20),
      "imageUrl":
          "https://imgs.search.brave.com/NaDDjSX3QXU-04z5jEIziIY6ww1QLwFnktJ5ZF8RI0A/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA5LzYwLzkyLzIz/LzM2MF9GXzk2MDky/MjMyNV9Renp0emlr/cXllU3dsQWxxUFd5/NkZjSzdpOTRiV2t2/bi5qcGc",
      "salePrice": "750"
    },
    {
      "title": "GUESS Women’s",
      "finalPrice": "1,200",
      "color": const Color.fromARGB(255, 255, 148, 175),
      "imageUrl":
          "https://s3-alpha-sig.figma.com/img/3fcf/e2de/92c1582f45fdca603f959997bfa35cbe?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=QeV-qjdBGetGEiu7uDdauE66Z5yttU6-vWCJ3UP3psaxm8WZyuuchrrkyph01bHIRwwJLn4w28HG5Tsi-UxqVWSbs~yxkZasvbjO93Hu2UN8cKX0XXmSw9Ug7Sm86LB5f2uaqqVk6F~xVr8M8gXfdsNiO8R2VzONaE03OQV~wXhNUSyuFS5s9CPXgtB60Gl8RmAUTKXmFi5V-nxPLjQL6lFYhNcS1-5addo~rCvr4erMQARjSJVdPKHW7eFBycwy7x2r5hRqavDlHfj4wEzzwV6TaQJaOeUN5Q7IvZGKK682CCRBOe6ax2nlf2eQG2vrG33bYxK9DOBKlnHw~p5~qg__",
      "salePrice": "1,500"
    },
    {
      "title": "Nike Air Jordon",
      "finalPrice": "1,200",
      "color": const Color.fromARGB(255, 23, 23, 24),
      "imageUrl":
          "https://s3-alpha-sig.figma.com/img/a434/c8f5/becb2cf90b140b5af08945a5ee61e536?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=NGtU0NXoeog6upzaakLakZTqmtYqrPAxODcxd3YnGEqPFdGbzuk4LL2xwJgNF~kexZPCNkj8aDwUS0T48PU0c7m3dYGK5WnMbrpLFaY3hoMEOubimEnmuelxR-vz~bcoOxHHzmYZ9mp0t6mMfR36Lrk8TSwX5MWATG7YHnZHWQxAoitNCgrpZByo3oqOENpF3tE1R-q~z99FXN3RI~RZ55gL-FKB0MPsu8RLhO1q~P8XSZQQ5j0~P6MAzh2RFKUz1a56yP5wuYCx7edAR12ACAsg8tO7UXneD-LBxaAkyAHoPJbcnmVM9QV3N~7sPbKmd3bTyo3LtJgq9zPMLRHUaw__",
      "salePrice": "1,500"
    },
    {
      "title": "Tall Cotton Dress",
      "finalPrice": "600",
      "color": const Color.fromARGB(255, 233, 123, 20),
      "imageUrl":
          "https://s3-alpha-sig.figma.com/img/335b/4609/de8eaf66c6e5c2fad29288b1bb0c6ada?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VxLSH2U8OAfQ1yxFPiL9hKbXG67g6yA0tRDLaWlla0gA58KCx94JrIalAu86GQHdymToO4gKUnZBFMosbyiovSL6F2So4QL-UytilX8qDbbrDRldkCKYv55ORm9GRbIbteDzTEUip05lR3047AtBYOtGAJAkQKTSVK6IP9x09-Ie2Wsv2SAdDUouAvPsLVDzi6YFN7Z7tcI7rwD~BN3SA1cz48u8xHcxI8qkQOiIrnvjZIf4G0ahqTy6KMESPuP5fORAyjsD6DRR918-Liy3YuDowNCg8rAt8-8RIFtt01W0CDNTyrwRBAzHsfgwmdlFVaZi7naiT52LGcsbWDhh-g__",
      "salePrice": "750"
    },
    {
      "title": "GUESS Women’s",
      "finalPrice": "1,200",
      "color": const Color.fromARGB(255, 255, 148, 175),
      "imageUrl":
          "https://s3-alpha-sig.figma.com/img/3fcf/e2de/92c1582f45fdca603f959997bfa35cbe?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=QeV-qjdBGetGEiu7uDdauE66Z5yttU6-vWCJ3UP3psaxm8WZyuuchrrkyph01bHIRwwJLn4w28HG5Tsi-UxqVWSbs~yxkZasvbjO93Hu2UN8cKX0XXmSw9Ug7Sm86LB5f2uaqqVk6F~xVr8M8gXfdsNiO8R2VzONaE03OQV~wXhNUSyuFS5s9CPXgtB60Gl8RmAUTKXmFi5V-nxPLjQL6lFYhNcS1-5addo~rCvr4erMQARjSJVdPKHW7eFBycwy7x2r5hRqavDlHfj4wEzzwV6TaQJaOeUN5Q7IvZGKK682CCRBOe6ax2nlf2eQG2vrG33bYxK9DOBKlnHw~p5~qg__",
      "salePrice": "1,500"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => FavoriteItem(
              product: favoriteProducts[index],
            ),
            itemCount: favoriteProducts.length,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildCustomBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50.r));
  }
}

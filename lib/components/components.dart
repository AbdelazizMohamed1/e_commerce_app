import 'package:e_commerce_app/layout/shop_layout/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


Widget defultTextFormField({
  required TextEditingController controller,
  bool obscureText = false,
  required TextInputType textInputType,
  String? hintText,
  Widget? prefix,
  Widget? suffix,
  FormFieldValidator<String>? validate,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  void Function()? onTap,
  String? labelText,
  bool readOnly = false,
  FocusNode? focusNode,
}) =>
    TextFormField(
        focusNode: focusNode,
        readOnly: readOnly,
        onFieldSubmitted: onSubmit,
        onTap: onTap,
        onChanged: onChange,
        validator: validate,
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          suffixIcon: suffix,
          prefixIcon: prefix,
        ));

Widget buildArticleItem(article, context) {
  final String url = 'urlToImage';
  var image;
  if (article[url] == null) {
    image = const NetworkImage(
      'https://static.vecteezy.com/system/resources/thumbnails/003/586/230/small/no-photo-sign-sticker-with-text-inscription-on-isolated-background-free-vector.jpg',
    );
  } else {
    image = NetworkImage('${article[url]}');
  }
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(image: image, fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: SizedBox(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Text('${article['publishedAt']}',
                    style: Theme.of(context).textTheme.bodyText2
                    // TextStyle(
                    //   color: Colors.grey,
                    // ),
                    ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget defultMaterialButton({
  required VoidCallback? onPressed,
  required String text,
  double width = double.infinity,
  Color? color = Colors.deepOrange,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: color,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(text),
        height: 50.0,
      ),
    );

Widget defultTextButton({
  required VoidCallback? onPressed,
  required String text,
}) =>
    TextButton(
      child: Text(text.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25.0,
          )),
      onPressed: onPressed,
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

void showToast(
        {required String message,
        required Color color,
        int? gravity = Toast.bottom,
        int? duration = Toast.lengthLong}) =>
    Toast.show(
      message,
      backgroundColor: color,
      gravity: gravity,
      duration: duration,
    );

void fromFormToNext({
  required BuildContext context,
  required FocusNode currentFocusNode,
  required FocusNode nextFocusNode,
}) {
  currentFocusNode.unfocus();
  FocusScope.of(context).requestFocus(nextFocusNode);
}

Widget buildListProduct(model,context,{bool isOldPrice = true,}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(

    height: 150.0,
    child: Row(
      children: [
        Stack(

          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                '${model.image}',
              ),
              height: 150.0,
              width: 150.0,
              errorBuilder: (context, error, stackTrace) {
                return Text('Error loading image: $error');
              },


            ),
            if(isOldPrice)
            if (model.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                width: 90.0,
                height: 30.0,
                color: Colors.red,
                child: Center(
                    child: Text(
                      'Discount',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                style: TextStyle(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    'Price: ${model.price}',
                    style:
                    TextStyle(fontSize: 12.0, color: Colors.deepOrange),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  if(isOldPrice)
                  if (model.discount != 0 )
                    Text(
                      '${model.oldPrice}',
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  Spacer(),
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor:

                    // ShopHomeCubit.get(context).favorites[model.id]! ?
                    Colors.deepOrange ,
                        // : Colors.grey,
                    child: IconButton(
                        onPressed: () {
                          if(isOldPrice)
                           ShopHomeCubit.get(context).changeFavorites(model.id!);
                          // ShopHomeCubit.get(context).getFavorites();
                        },
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
import 'package:library_app/controllers/books_controller.dart';
import 'package:library_app/controllers/chat/chat_controller.dart';
import 'package:library_app/controllers/conferences_controller.dart';
import 'package:library_app/controllers/formations_controller.dart';
import 'package:library_app/controllers/login_controller.dart';
import 'package:library_app/controllers/my_formations_controller.dart';
import 'package:library_app/controllers/navigation_controller.dart';
import 'package:library_app/controllers/offers_controller.dart';
import 'package:library_app/controllers/register_controller.dart';
import 'package:library_app/controllers/sessions_controller.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<NavigationController>(
    create: (context) => NavigationController(),
  ),
  ChangeNotifierProvider<LoginController>(
    create: (context) => LoginController(),
  ),
  ChangeNotifierProvider<BooksController>(
    create: (context) => BooksController(),
  ),
  ChangeNotifierProvider<FormationsController>(
    create: (context) => FormationsController(),
  ),
  ChangeNotifierProvider<MyFormationsController>(
    create: (context) => MyFormationsController(),
  ),
  ChangeNotifierProvider<WorkshopsController>(
    create: (context) => WorkshopsController(),
  ),
  ChangeNotifierProvider<ChatController>(
    create: (context) => ChatController(),
  ),
  ChangeNotifierProvider<RegisterController>(
    create: (context) => RegisterController(),
  ),
  ChangeNotifierProvider<OffersController>(
    create: (context) => OffersController(),
  ),
  ChangeNotifierProvider<SessionsController>(
    create: (context) => SessionsController(),
  ),
];

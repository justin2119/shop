import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/service_api.dart';
final productProvider=Provider((ref)=>ServiceApi().getProducts());
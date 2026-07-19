import 'package:flutter_riverpod/legacy.dart';

import '../../services/service_api.dart';

final ProductProvider=StateProvider<ServiceApi>((ref)=>ServiceApi());
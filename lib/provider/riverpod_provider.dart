// Simple
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final greetingProvider = Provider((ref) => 'Hello from Riverpod!');

final counterProvider = StateProvider<int>((ref)=>0);




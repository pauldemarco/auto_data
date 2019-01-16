// Copyright 2019, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library auto_data_generator;

import 'dart:async';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:auto_data/auto_data.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

part 'src/auto_data_generator.dart';
part 'src/parser.dart';
part 'src/file_generator.dart';

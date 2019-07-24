// Copyright 2019, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of auto_data;

class Data {
  /// Mark a class for data generation
  const Data();

  String toString() => "Data class";
}

/// Marks a class as [Data].
const Data data = const Data();

class Nullable {
  /// Allow a field to be nullable
  const Nullable();

  String toString() => "Nullable class";
}

/// Marks a field as [Nullable].
const Nullable nullable = const Nullable();

// Copyright 2019, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of auto_data;

class Data {

  /**
   * Create a data annotation
   */
  const Data();


  String toString() => "Data feature";
}

/**
 * Marks a class as [Data].
 */
const Data data = const Data();
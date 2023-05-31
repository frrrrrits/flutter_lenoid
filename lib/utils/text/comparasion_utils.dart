extension TextUtilsStringExtension on String {
  /// Returns true if string is:
  /// - null
  /// - empty
  /// - whitespace string.
  ///
  /// Characters considered "whitespace" are listed [here](https://stackoverflow.com/a/59826129/10830091).
  bool get isNullEmptyOrWhitespace =>
      this == null || this.isEmpty || this == "" || this.trim().isEmpty;
}

extension ObjUtilsStringExtension on Object {
  bool get isNullOrEmpty => this == null || this == '';

  bool get isNullEmptyOrFalse => this == null || this == '' || false == this;

  bool get isNullEmptyZeroOrFalse =>
      this == null || this == '' || false == this || this == 0;
}

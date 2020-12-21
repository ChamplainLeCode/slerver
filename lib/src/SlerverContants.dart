library slerver;

/// This class represents the collection on constants use by library
class SlerverConstants {
  /// Start pattern that delimites any messages at the start
  static const String BEGIN = '##SLERVERBEGIN##';
  /// End pattern that delimites any messages at the end
  static const String END = '##SLERVEREND##';
  /// Size of start pattern 
  static const int BEGIN_SIZE = BEGIN.length;
  
  static const int END_SIZE = END.length;
  static const int MIN_SIZE = BEGIN_SIZE + END_SIZE;
}
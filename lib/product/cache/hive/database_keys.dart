///key value in save process
enum DatabaseKeys {
  LAST_UNFINISHED_TRACKING('last_unfinished_tracking'),
  ;

  final String value;
  const DatabaseKeys(this.value);
}

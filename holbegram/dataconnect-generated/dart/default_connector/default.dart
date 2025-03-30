library default_connector;
// ignore: depend_on_referenced_packages


class DefaultConnector {
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-central1',
    'default',
    'holbegram',
  );

  DefaultConnector({required this.dataConnect});
  static DefaultConnector get instance {
    return DefaultConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}

class CallerSDKType {
  // ignore: prefer_typing_uninitialized_variables
  static var generated;
}

class FirebaseDataConnect {
  static instanceFor({required ConnectorConfig connectorConfig, required sdkType}) {}
}

class ConnectorConfig {
  ConnectorConfig(String s, String t, String u);
}

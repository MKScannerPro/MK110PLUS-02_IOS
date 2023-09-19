
typedef NS_ENUM(NSInteger, mk_gt_centralConnectStatus) {
    mk_gt_centralConnectStatusUnknow,                                           //未知状态
    mk_gt_centralConnectStatusConnecting,                                       //正在连接
    mk_gt_centralConnectStatusConnected,                                        //连接成功
    mk_gt_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_gt_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_gt_centralManagerStatus) {
    mk_gt_centralManagerStatusUnable,                           //不可用
    mk_gt_centralManagerStatusEnable,                           //可用状态
};


typedef NS_ENUM(NSInteger, mk_gt_wifiSecurity) {
    mk_gt_wifiSecurity_personal,
    mk_gt_wifiSecurity_enterprise,
};

typedef NS_ENUM(NSInteger, mk_gt_eapType) {
    mk_gt_eapType_peap_mschapv2,
    mk_gt_eapType_ttls_mschapv2,
    mk_gt_eapType_tls,
};

typedef NS_ENUM(NSInteger, mk_gt_connectMode) {
    mk_gt_connectMode_TCP,                                          //TCP
    mk_gt_connectMode_CASignedServerCertificate,                    //SSL.Do not verify the server certificate.
    mk_gt_connectMode_CACertificate,                                //SSL.Verify the server's certificate
    mk_gt_connectMode_SelfSignedCertificates,                       //SSL.Two-way authentication
};

//Quality of MQQT service
typedef NS_ENUM(NSInteger, mk_gt_mqttServerQosMode) {
    mk_gt_mqttQosLevelAtMostOnce,      //At most once. The message sender to find ways to send messages, but an accident and will not try again.
    mk_gt_mqttQosLevelAtLeastOnce,     //At least once.If the message receiver does not know or the message itself is lost, the message sender sends it again to ensure that the message receiver will receive at least one, and of course, duplicate the message.
    mk_gt_mqttQosLevelExactlyOnce,     //Exactly once.Ensuring this semantics will reduce concurrency or increase latency, but level 2 is most appropriate when losing or duplicating messages is unacceptable.
};

typedef NS_ENUM(NSInteger, mk_gt_filterRelationship) {
    mk_gt_filterRelationship_null,
    mk_gt_filterRelationship_mac,
    mk_gt_filterRelationship_advName,
    mk_gt_filterRelationship_rawData,
    mk_gt_filterRelationship_advNameAndRawData,
    mk_gt_filterRelationship_macAndadvNameAndRawData,
    mk_gt_filterRelationship_advNameOrRawData,
    mk_gt_filterRelationship_advNameAndMacData,
};


@protocol mk_gt_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
- (void)mk_gt_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_gt_startScan;

/// Stops scanning equipment.
- (void)mk_gt_stopScan;

@end

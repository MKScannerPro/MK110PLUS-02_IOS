

typedef NS_ENUM(NSInteger, mk_gt_taskOperationID) {
    mk_gt_defaultTaskOperationID,
    
#pragma mark - Read
    mk_gt_taskReadDeviceModelOperation,        //读取产品型号
    mk_gt_taskReadFirmwareOperation,           //读取固件版本
    mk_gt_taskReadHardwareOperation,           //读取硬件类型
    mk_gt_taskReadSoftwareOperation,           //读取软件版本
    mk_gt_taskReadManufacturerOperation,       //读取厂商信息
    
#pragma mark - 自定义协议读取
    mk_gt_taskReadDeviceNameOperation,         //读取设备名称
    mk_gt_taskReadDeviceMacAddressOperation,    //读取MAC地址
    mk_gt_taskReadDeviceWifiSTAMacAddressOperation, //读取WIFI STA MAC地址
    mk_gt_taskReadNTPServerHostOperation,       //读取NTP服务器域名
    mk_gt_taskReadTimeZoneOperation,            //读取时区
    
#pragma mark - Wifi Params
    mk_gt_taskReadWIFISecurityOperation,        //读取设备当前wifi的加密模式
    mk_gt_taskReadWIFISSIDOperation,            //读取设备当前的wifi ssid
    mk_gt_taskReadWIFIPasswordOperation,        //读取设备当前的wifi密码
    mk_gt_taskReadWIFIEAPTypeOperation,         //读取设备当前的wifi EAP类型
    mk_gt_taskReadWIFIEAPUsernameOperation,     //读取设备当前的wifi EAP用户名
    mk_gt_taskReadWIFIEAPPasswordOperation,     //读取设备当前的wifi EAP密码
    mk_gt_taskReadWIFIEAPDomainIDOperation,     //读取设备当前的wifi EAP域名ID
    mk_gt_taskReadWIFIVerifyServerStatusOperation,  //读取是否校验服务器
    mk_gt_taskReadDHCPStatusOperation,              //读取DHCP开关
    mk_gt_taskReadNetworkIpInfosOperation,          //读取IP信息
    
#pragma mark - MQTT Params
    mk_gt_taskReadServerHostOperation,          //读取MQTT服务器域名
    mk_gt_taskReadServerPortOperation,          //读取MQTT服务器端口
    mk_gt_taskReadClientIDOperation,            //读取Client ID
    mk_gt_taskReadServerUserNameOperation,      //读取服务器登录用户名
    mk_gt_taskReadServerPasswordOperation,      //读取服务器登录密码
    mk_gt_taskReadServerCleanSessionOperation,  //读取MQTT Clean Session
    mk_gt_taskReadServerKeepAliveOperation,     //读取MQTT KeepAlive
    mk_gt_taskReadServerQosOperation,           //读取MQTT Qos
    mk_gt_taskReadSubscibeTopicOperation,       //读取Subscribe topic
    mk_gt_taskReadPublishTopicOperation,        //读取Publish topic
    mk_gt_taskReadLWTStatusOperation,           //读取LWT开关状态
    mk_gt_taskReadLWTQosOperation,              //读取LWT Qos
    mk_gt_taskReadLWTRetainOperation,           //读取LWT Retain
    mk_gt_taskReadLWTTopicOperation,            //读取LWT topic
    mk_gt_taskReadLWTPayloadOperation,          //读取LWT Payload
    mk_gt_taskReadConnectModeOperation,         //读取MTQQ服务器通信加密方式
    
#pragma mark - Filter Params
    mk_gt_taskReadRssiFilterValueOperation,             //读取扫描RSSI过滤
    mk_gt_taskReadFilterRelationshipOperation,          //读取扫描过滤逻辑
    mk_gt_taskReadFilterMACAddressListOperation,        //读取MAC过滤列表
    mk_gt_taskReadFilterAdvNameListOperation,           //读取ADV Name过滤列表
    
#pragma mark - iBeacon Params
    mk_gt_taskReadAdvertiseBeaconStatusOperation,       //读取iBeacon开关
    mk_gt_taskReadBeaconMajorOperation,                 //读取iBeacon major
    mk_gt_taskReadBeaconMinorOperation,                 //读取iBeacon minor
    mk_gt_taskReadBeaconUUIDOperation,                  //读取iBeacon UUID
    mk_gt_taskReadBeaconAdvIntervalOperation,           //读取Adv interval
    mk_gt_taskReadBeaconTxPowerOperation,               //读取Tx Power
    
#pragma mark - 计电量参数
    mk_gt_taskReadMeteringSwitchOperation,              //读取计量数据上报开关
    mk_gt_taskReadPowerReportIntervalOperation,         //读取电量数据上报间隔
    mk_gt_taskReadEnergyReportIntervalOperation,        //读取电能数据上报间隔
    mk_gt_taskReadLoadDetectionNotificationStatusOperation, //读取负载检测通知开关
    
    
#pragma mark - 密码特征
    mk_gt_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 配置
    mk_gt_taskEnterSTAModeOperation,                //设备重启进入STA模式
    mk_gt_taskConfigNTPServerHostOperation,         //配置NTP服务器域名
    mk_gt_taskConfigTimeZoneOperation,              //配置时区
    mk_gt_taskConfigDeviceTimeOperation,            //配置UTC时间戳
    
#pragma mark - Wifi Params
    
    mk_gt_taskConfigWIFISecurityOperation,      //配置wifi的加密模式
    mk_gt_taskConfigWIFISSIDOperation,          //配置wifi的ssid
    mk_gt_taskConfigWIFIPasswordOperation,      //配置wifi的密码
    mk_gt_taskConfigWIFIEAPTypeOperation,       //配置wifi的EAP类型
    mk_gt_taskConfigWIFIEAPUsernameOperation,   //配置wifi的EAP用户名
    mk_gt_taskConfigWIFIEAPPasswordOperation,   //配置wifi的EAP密码
    mk_gt_taskConfigWIFIEAPDomainIDOperation,   //配置wifi的EAP域名ID
    mk_gt_taskConfigWIFIVerifyServerStatusOperation,    //配置wifi是否校验服务器
    mk_gt_taskConfigWIFICAFileOperation,                //配置WIFI CA证书
    mk_gt_taskConfigWIFIClientCertOperation,            //配置WIFI设备证书
    mk_gt_taskConfigWIFIClientPrivateKeyOperation,      //配置WIFI私钥
    mk_gt_taskConfigDHCPStatusOperation,                //配置DHCP开关
    mk_gt_taskConfigIpInfoOperation,                    //配置IP地址相关信息
    
#pragma mark - MQTT Params
    mk_gt_taskConfigServerHostOperation,        //配置MQTT服务器域名
    mk_gt_taskConfigServerPortOperation,        //配置MQTT服务器端口
    mk_gt_taskConfigClientIDOperation,              //配置ClientID
    mk_gt_taskConfigServerUserNameOperation,        //配置服务器的登录用户名
    mk_gt_taskConfigServerPasswordOperation,        //配置服务器的登录密码
    mk_gt_taskConfigServerCleanSessionOperation,    //配置MQTT Clean Session
    mk_gt_taskConfigServerKeepAliveOperation,       //配置MQTT KeepAlive
    mk_gt_taskConfigServerQosOperation,             //配置MQTT Qos
    mk_gt_taskConfigSubscibeTopicOperation,         //配置Subscribe topic
    mk_gt_taskConfigPublishTopicOperation,          //配置Publish topic
    mk_gt_taskConfigLWTStatusOperation,             //配置LWT开关
    mk_gt_taskConfigLWTQosOperation,                //配置LWT Qos
    mk_gt_taskConfigLWTRetainOperation,             //配置LWT Retain
    mk_gt_taskConfigLWTTopicOperation,              //配置LWT topic
    mk_gt_taskConfigLWTPayloadOperation,            //配置LWT payload
    mk_gt_taskConfigConnectModeOperation,           //配置MTQQ服务器通信加密方式
    mk_gt_taskConfigCAFileOperation,                //配置CA证书
    mk_gt_taskConfigClientCertOperation,            //配置设备证书
    mk_gt_taskConfigClientPrivateKeyOperation,      //配置私钥
        
#pragma mark - 过滤参数
    mk_gt_taskConfigRssiFilterValueOperation,                   //配置扫描RSSI过滤
    mk_gt_taskConfigFilterRelationshipOperation,                //配置扫描过滤逻辑
    mk_gt_taskConfigFilterMACAddressListOperation,           //配置MAC过滤规则
    mk_gt_taskConfigFilterAdvNameListOperation,             //配置Adv Name过滤规则
    
#pragma mark - 蓝牙广播参数
    mk_gt_taskConfigAdvertiseBeaconStatusOperation,         //配置iBeacon开关
    mk_gt_taskConfigBeaconMajorOperation,                   //配置iBeacon major
    mk_gt_taskConfigBeaconMinorOperation,                   //配置iBeacon minor
    mk_gt_taskConfigBeaconUUIDOperation,                    //配置iBeacon UUID
    mk_gt_taskConfigAdvIntervalOperation,                   //配置广播频率
    mk_gt_taskConfigTxPowerOperation,                       //配置Tx Power
    
#pragma mark - 计电量参数
    mk_gt_taskConfigMeteringSwitchOperation,                //配置计量数据上报开关
    mk_gt_taskConfigPowerReportIntervalOperation,           //配置电量数据上报间隔
    mk_gt_taskConfigEnergyReportIntervalOperation,          //配置电能数据上报间隔
    mk_gt_taskConfigLoadDetectionNotificationStatusOperation,   //配置负载检测通知开关
};


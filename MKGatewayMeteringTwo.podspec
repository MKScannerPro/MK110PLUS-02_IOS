#
# Be sure to run `pod lib lint MKGatewayMeteringTwo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKGatewayMeteringTwo'
  s.version          = '0.0.1'
  s.summary          = 'A short description of MKGatewayMeteringTwo.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lovexiaoxia/MKGatewayMeteringTwo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lovexiaoxia' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/lovexiaoxia/MKGatewayMeteringTwo.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'
  
  s.resource_bundles = {
    'MKGatewayMeteringTwo' => ['MKGatewayMeteringTwo/Assets/*.png']
  }

  s.subspec 'Target' do |ss|
    
    ss.source_files = 'MKGatewayMeteringTwo/Classes/Target/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKGatewayMeteringTwo/Functions'
  
  end
  
  s.subspec 'CTMediator' do |ss|
    
    ss.source_files = 'MKGatewayMeteringTwo/Classes/CTMediator/**'
    
    ss.dependency 'CTMediator'
    ss.dependency 'MKBaseModuleLibrary'
  
  end
  
  s.subspec 'DeviceModel' do |ss|
    
    ss.source_files = 'MKGatewayMeteringTwo/Classes/DeviceModel/**'

    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKGatewayMeteringTwo/SDK/MQTT'
  
  end
  
  s.subspec 'DatabaseManager' do |ss|
    
    ss.source_files = 'MKGatewayMeteringTwo/Classes/DatabaseManager/**'
  
  
    ss.dependency 'FMDB'
    ss.dependency 'MKGatewayMeteringTwo/DeviceModel'
  end
  
  s.subspec 'SDK' do |ss|
      
    ss.subspec 'BLE' do |sss|
      sss.source_files = 'MKGatewayMeteringTwo/Classes/SDK/BLE/**'
      
      sss.dependency 'MKBaseBleModule'
    end
    
    ss.subspec 'MQTT' do |sss|
        sss.subspec 'Manager' do |ssss|
            ssss.source_files = 'MKGatewayMeteringTwo/Classes/SDK/MQTT/Manager/**'
            
            ssss.dependency 'MKBaseModuleLibrary'
            ssss.dependency 'MKBaseMQTTModule'
        end
        
        sss.subspec 'SDK' do |ssss|
            ssss.source_files = 'MKGatewayMeteringTwo/Classes/SDK/MQTT/SDK/**'
            
            ssss.dependency 'MKBaseModuleLibrary'
            ssss.dependency 'MKGatewayMeteringTwo/SDK/MQTT/Manager'
        end
    end
    
  end
  
  s.subspec 'LoginManager' do |ss|
    ss.source_files = 'MKGatewayMeteringTwo/Classes/LoginManager/**'
  
    ss.dependency 'MKIotCloudManager'
  end
  
  s.subspec 'ScannerModuleManager' do |ss|
    ss.source_files = 'MKGatewayMeteringTwo/Classes/ScannerModuleManager/**'
    
    ss.dependency 'MKScannerCommonModule'
    
    ss.dependency 'MKGatewayMeteringTwo/SDK/MQTT'
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AddDeviceModules' do |sss|
        sss.subspec 'ParamsModel'  do |ssss|
            ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/AddDeviceModules/ParamsModel/**'
        end
        sss.subspec 'Pages' do |ssss|
            
            ssss.subspec 'BleWifiSettingsPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/Controller/**'
                
                ssssss.dependency 'MKGatewayMeteringTwo/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/Model'
                ssssss.dependency 'MKGatewayMeteringTwo/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/View'
                
              end
                
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/Model/**'
                end
                
                sssss.subspec 'View' do |ssssss|
                  ssssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/View/**'
                end
                
            end
            
            ssss.subspec 'BleMeteringSettingsPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/AddDeviceModules/Pages/BleMeteringSettingsPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayMeteringTwo/Functions/AddDeviceModules/Pages/BleMeteringSettingsPage/Model'
                end
                
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/AddDeviceModules/Pages/BleMeteringSettingsPage/Model/**'
                end
            end
            
            ssss.subspec 'ConnectSuccessPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/AddDeviceModules/Pages/ConnectSuccessPage/Controller/**'
                end
            end
            
            ssss.subspec 'DeviceParamsListPage' do |sssss|
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/AddDeviceModules/Pages/DeviceParamsListPage/Model/**'
              end
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/AddDeviceModules/Pages/DeviceParamsListPage/Controller/**'
                
                ssssss.dependency 'MKGatewayMeteringTwo/Functions/AddDeviceModules/Pages/DeviceParamsListPage/Model'
              
                ssssss.dependency 'MKGatewayMeteringTwo/Functions/AddDeviceModules/Pages/BleWifiSettingsPage'
                ssssss.dependency 'MKGatewayMeteringTwo/Functions/AddDeviceModules/Pages/BleMeteringSettingsPage'
                ssssss.dependency 'MKGatewayMeteringTwo/Functions/AddDeviceModules/Pages/ConnectSuccessPage'
              end
            end
            
            ssss.dependency 'MKGatewayMeteringTwo/Functions/AddDeviceModules/ParamsModel'
            
        end
        
    end
    
    ss.subspec 'DeviceDataPage' do |sss|
        sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/DeviceDataPage/Controller/**'
          
          ssss.dependency 'MKGatewayMeteringTwo/Functions/DeviceDataPage/View'
          
          ssss.dependency 'MKGatewayMeteringTwo/Functions/SettingPages'
          ssss.dependency 'MKGatewayMeteringTwo/Functions/FilterPages/UploadOptionPage'
          ssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage'
          ssss.dependency 'MKGatewayMeteringTwo/Functions/PowerMeteringModules'
        end
        
        sss.subspec 'View' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/DeviceDataPage/View/**'
        end
    end
    
    ss.subspec 'PowerMeteringModules' do |sss|
      
      sss.subspec 'PowerMeteringPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/PowerMeteringModules/PowerMeteringPage/Controller/**'
          
          sssss.dependency 'MKGatewayMeteringTwo/Functions/PowerMeteringModules/MeteringParamsPage'
        
          sssss.dependency 'MKGatewayMeteringTwo/Functions/PowerMeteringModules/PowerMeteringPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/PowerMeteringModules/PowerMeteringPage/Model/**'
        end
      end
      
      sss.subspec 'MeteringParamsPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/PowerMeteringModules/MeteringParamsPage/Controller/**'
        
          sssss.dependency 'MKGatewayMeteringTwo/Functions/PowerMeteringModules/MeteringParamsPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/PowerMeteringModules/MeteringParamsPage/Model/**'
        end
      end
      
    end
    
    ss.subspec 'DeviceListPage' do |sss|
        sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/DeviceListPage/Controller/**'
          
          ssss.dependency 'MKGatewayMeteringTwo/Functions/DeviceListPage/View'
          ssss.dependency 'MKGatewayMeteringTwo/Functions/DeviceListPage/Model'
          
          ssss.dependency 'MKGatewayMeteringTwo/Functions/ServerForApp'
          ssss.dependency 'MKGatewayMeteringTwo/Functions/ScanPage'
          ssss.dependency 'MKGatewayMeteringTwo/Functions/DeviceDataPage'
          ssss.dependency 'MKGatewayMeteringTwo/Functions/SyncDevicePage'
          
        end
        
        sss.subspec 'Model' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/DeviceListPage/Model/**'
        end
        
        sss.subspec 'View' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/DeviceListPage/View/**'
          
          ssss.dependency 'MKGatewayMeteringTwo/Functions/DeviceListPage/Model'
        end
    end
    
    ss.subspec 'FilterPages' do |sss|
      
      sss.subspec 'RawFilterModels' do |ssss|
        ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/FilterPages/RawFilterModels/**'
      end
      
      sss.subspec 'UploadOptionPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/FilterPages/UploadOptionPage/Controller/**'
        
          sssss.dependency 'MKGatewayMeteringTwo/Functions/FilterPages/UploadOptionPage/Model'
          
          sssss.dependency 'MKGatewayMeteringTwo/Functions/FilterPages/RawFilterModels'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/FilterPages/UploadOptionPage/Model/**'
        end
        
      end
      
    end
    
    ss.subspec 'ManageBleDevicesPage' do |sss|
      sss.subspec 'Manager' do |ssss|
        ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Manager/**'
      end
      sss.subspec 'Adopter' do |ssss|
        ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Adopter/**'
        
        ssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Manager'
        ssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Model'
      end
      
      sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Controller/**'
          
          ssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Model'
          ssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Manager'
          ssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Adopter'
          
      end
        
        sss.subspec 'Model' do |ssss|
          
          ssss.subspec 'DFU' do |sssss|
            sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Model/DFU/**'
          end
          
          ssss.subspec 'BXPBCR' do |sssss|
            sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Model/BXPBCR/**'
            
            sssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'BXPBD' do |sssss|
            sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Model/BXPBD/**'
            
            sssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'BXPC' do |sssss|
            sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Model/BXPC/**'
            
            sssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'BXPD' do |sssss|
            sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Model/BXPD/**'
            
            sssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'BXPS' do |sssss|
            sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Model/BXPS/**'
            
            sssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'BXPT' do |sssss|
            sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Model/BXPT/**'
            
            sssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'Pir' do |sssss|
            sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Model/Pir/**'
            
            sssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'Tof' do |sssss|
            sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Model/Tof/**'
            
            sssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'NormalConnected' do |sssss|
            sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ManageBleDevicesPage/Model/NormalConnected/**'
          end
          
          ssss.dependency 'MKGatewayMeteringTwo/Functions/ManageBleDevicesPage/Manager'
        end
    end
    
    ss.subspec 'ScanPage' do |sss|
        sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ScanPage/Controller/**'
          
          ssss.dependency 'MKGatewayMeteringTwo/Functions/ScanPage/Model'
          ssss.dependency 'MKGatewayMeteringTwo/Functions/ScanPage/View'
          
          ssss.dependency 'MKGatewayMeteringTwo/Functions/AddDeviceModules'
        end
        
        sss.subspec 'Model' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ScanPage/Model/**'
        end
        
        sss.subspec 'View' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ScanPage/View/**'
          
          ssss.dependency 'MKGatewayMeteringTwo/Functions/ScanPage/Model'
        end
    end
    
    ss.subspec 'ServerForApp' do |sss|
        sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ServerForApp/Controller/**'
          
          ssss.dependency 'MKGatewayMeteringTwo/Functions/ServerForApp/Model'
        end
        
        sss.subspec 'Model' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/ServerForApp/Model/**'
        end
    end
    
    ss.subspec 'SettingPages' do |sss|
        
        sss.subspec 'MqttParamsListPage' do |ssss|
            ssss.subspec 'Controller' do |sssss|
              sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/SettingPages/MqttParamsListPage/Controller/**'
              
              sssss.dependency 'MKGatewayMeteringTwo/Functions/SettingPages/MqttParamsListPage/Model'
              
              sssss.dependency 'MKGatewayMeteringTwo/Functions/SettingPages/MqttWifiSettingsPage'
            end
            
            ssss.subspec 'Model' do |sssss|
              sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/SettingPages/MqttParamsListPage/Model/**'
            end
        end
        
        sss.subspec 'MqttWifiSettingsPage' do |ssss|
            ssss.subspec 'Controller' do |sssss|
              sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/SettingPages/MqttWifiSettingsPage/Controller/**'
              
              sssss.dependency 'MKGatewayMeteringTwo/Functions/SettingPages/MqttWifiSettingsPage/Model'
            end
            ssss.subspec 'Model' do |sssss|
              sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/SettingPages/MqttWifiSettingsPage/Model/**'
            end
        end
        
        sss.subspec 'IndicatorSettingsPage' do |ssss|
            ssss.subspec 'Controller'  do |sssss|
              sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/SettingPages/IndicatorSettingsPage/Controller/**'
              
              sssss.dependency 'MKGatewayMeteringTwo/Functions/SettingPages/IndicatorSettingsPage/Model'
            end
            ssss.subspec 'Model'  do |sssss|
              sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/SettingPages/IndicatorSettingsPage/Model/**'
            end
        end
        
        sss.subspec 'SettingPage' do |ssss|
            ssss.subspec 'Controller' do |sssss|
              sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/SettingPages/SettingPage/Controller/**'
              
              sssss.dependency 'MKGatewayMeteringTwo/Functions/SettingPages/SettingPage/Model'
              
              sssss.dependency 'MKGatewayMeteringTwo/Functions/SettingPages/MqttParamsListPage'
              sssss.dependency 'MKGatewayMeteringTwo/Functions/SettingPages/IndicatorSettingsPage'
            end
            ssss.subspec 'Model' do |sssss|
              sssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/SettingPages/SettingPage/Model/**'
            end
        end
        
    end
    
    ss.subspec 'SyncDevicePage' do |sss|
        sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/SyncDevicePage/Controller/**'
          
          ssss.dependency 'MKGatewayMeteringTwo/Functions/SyncDevicePage/View'
        end
        
        sss.subspec 'View' do |ssss|
          ssss.source_files = 'MKGatewayMeteringTwo/Classes/Functions/SyncDevicePage/View/**'
        end
    end
    
    ss.dependency 'MKGatewayMeteringTwo/SDK'
    ss.dependency 'MKGatewayMeteringTwo/CTMediator'
    ss.dependency 'MKGatewayMeteringTwo/DeviceModel'
    ss.dependency 'MKGatewayMeteringTwo/DatabaseManager'
    ss.dependency 'MKGatewayMeteringTwo/CTMediator'
    ss.dependency 'MKGatewayMeteringTwo/ScannerModuleManager'
    ss.dependency 'MKGatewayMeteringTwo/LoginManager'
  
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'MKScannerCommonModule'
    
    ss.dependency 'MLInputDodger'
    
  end

end

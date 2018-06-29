

#ifndef CameraModel_h
#define CameraModel_h

#define __kMin_Canon_Enum       0
#define __kMin_Nikon_Enum       20
#define __kMin_Sony_Enum        40
#define __kMin_Panasonic_Enum   60
typedef NS_ENUM(NSInteger, Camera_Model) {
    //    Camera_Model_Unknown,
    //佳能相机型号
    Camera_Model_Canon_700D = __kMin_Canon_Enum,
    Camera_Model_Canon_5D3,
    Camera_Model_Canon_5D2,
    Camera_Model_Canon_6D,
    Camera_Model_Canon_80D,
    Camera_Model_Canon_5D4,
    Camera_Model_Canon_6D2,
    Camera_Model_Canon_500D,
    
    //尼康相机型号
    Camera_Model_Nikon_D7200 = __kMin_Nikon_Enum,
    Camera_Model_Nikon_D5300,
    
    //索尼相机型号
    
    //松下相机型号
};


typedef NS_ENUM(NSInteger, Camera_Brand) {
    //    Camera_Brand_Unknown,
    Camera_Brand_Canon      = 0x00,
    Camera_Brand_Nikon      = 0x01,
    Camera_Brand_Sony       = 0x02,
    Camera_Brand_Panasonic  = 0x03,
};

typedef NS_ENUM(NSInteger, Model_Type1) {
    Model_Type1_Brand,      //品牌
    Model_Type1_Model,      //02(型号)
    Model_Type1_Aperture,   //03(光圈)
    Model_Type1_Shutter,    //04(快门)
    Model_Type1_ISO,        //05(ISO)
    Model_Type1_Compen,     //06(曝光补偿)
    Model_Type1_Zoom,       //07(焦距)
    Model_Type1_FocusFar,   //08(对焦变远)
    Model_Type1_FocusNear,  //09(对焦变近)
    Model_Type1_Mode,       //0A(相机拍摄模式)
    Model_Type1_WB,         //0B(白平衡)
    Model_Type1_Video,      //0C(录像模式开关)
    Model_Type1_USB,        //0D(USB连接开关)
    Model_Type1_Focus,      //对焦
};

#endif /* CameraModel_h */

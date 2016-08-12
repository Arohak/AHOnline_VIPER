//
//  UISettings.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - ScreenSize -
struct ScreenSize
{
    static let WIDTH                = UIScreen.mainScreen().bounds.size.width
    static let HEIGHT               = UIScreen.mainScreen().bounds.size.height
    static let MAX_LENGTH           = max(ScreenSize.WIDTH, ScreenSize.WIDTH)
    static let MIN_LENGTH           = min(ScreenSize.HEIGHT, ScreenSize.HEIGHT)
    static let SCALE                = UIScreen.mainScreen().scale
}

//MARK: - DeviceType -
enum DeviceType
{
    static let IS_IPHONE                = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.MAX_LENGTH < 568.0
    static let IS_IPHONE_5              = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.MAX_LENGTH == 568.0
    static let IS_IPHONE_6              = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.MAX_LENGTH == 667.0
    static let IS_IPHONE_6P             = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.MAX_LENGTH == 736.0
    static let IS_IPAD                  = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.MAX_LENGTH == 1024.0
}

//MARK: - System Version -
struct Version
{
    static let SYS_VERSION_FLOAT        = (UIDevice.currentDevice().systemVersion as NSString).floatValue
    static let iOS8                     = (Version.SYS_VERSION_FLOAT >= 8.0 && Version.SYS_VERSION_FLOAT < 9.0)
    static let iOS9                     = (Version.SYS_VERSION_FLOAT >= 9.0 && Version.SYS_VERSION_FLOAT < 10.0)
}

//MARK: - Multiplier
let IPHONE_4_SCALE : CGFloat            = 480  / 736
let IPHONE_5_SCALE : CGFloat            = 568  / 736
let IPHONE_6_SCALE : CGFloat            = 667  / 736
let IPAD_SCALE : CGFloat                = 1024 / 736

//MARK: - All Colors -
let GREEN                               = UIColor(red: 137/255,     green: 212/255,     blue: 57/255,       alpha: 1)
let BLUE_LIGHT                          = UIColor(red: 51/255,      green: 204/255,     blue: 255/255,      alpha: 1)
let XAKI                                = UIColor(red: 255/255,     green: 102/255,     blue: 51/255,       alpha: 1)
let GRAY_164                            = UIColor(red: 164/255,     green: 164/255,     blue: 164/255,      alpha: 1)
let GRAY_200                            = UIColor(red: 200/255,     green: 200/255,     blue: 200/255,      alpha: 1)
let GRAY_119                            = UIColor(red: 119/255,     green: 119/255,     blue: 119/255,      alpha: 1)
let BLACK_59                            = UIColor(red: 59/255,      green: 59/255,      blue: 59/255,       alpha: 1)
let RED                                 = UIColor(red: 240/255,     green: 30/255,      blue: 30/255,       alpha: 1)
let RED_LIGHT                           = UIColor(red: 232/255,     green: 114/255,     blue: 114/255,      alpha: 1)
let RED_233                             = UIColor(red: 233/255,     green: 110/255,     blue: 110/255,      alpha: 1)
let BLUE                                = UIColor(red: 24/255,      green: 75/255,      blue: 152/255,      alpha: 1)
let GRAY_239                            = UIColor(red: 242/255,     green: 242/255,     blue: 242/255,      alpha: 1)

let BLACK                               = UIColor.blackColor()
let WHITE                               = UIColor.whiteColor()
let GRAY                                = UIColor.grayColor()
let CLEAR                               = UIColor.clearColor()
let RCOLORS                             = [UIColor.blueColor(), UIColor.redColor(), UIColor.orangeColor(), UIColor.greenColor()]

//MARK: - Callback Typealias -
typealias CollectionCallback            = (indexPath: NSIndexPath) -> Void
typealias PickerCallback                = (value: String) -> Void
typealias ManageAddressPickerCallback   = (value: (String, String)) -> Void
typealias DeliveryPickerCallback        = (value: Delivery, index: Int) -> Void
typealias DistancePickerCallback        = (value: Double, index: Int) -> Void
typealias LanguagePickerCallback        = (value: String, index: Int) -> Void

let NAV_HEIGHT: CGFloat                 = 64
let TAB_HEIGHT: CGFloat                 = 46
let FONT_NAVBAR                         = UIFont.systemFontOfSize(DeviceType.IS_IPAD ? 25 : 18)
let FONT_TABBAR                         = UIFont.systemFontOfSize(DeviceType.IS_IPAD ? 14 : 10)
let LIMIT                               = 10
let OFFSET                              = 0


//MARK: - Font Constants -
let TITLE_BTN_FONT                      = UIFont.boldSystemFontOfSize(DeviceType.IS_IPAD ? 14       * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 14     : DeviceType.IS_IPHONE_6 ? 14   * IPHONE_6_SCALE : 14   * IPHONE_5_SCALE)
let TITLE_LBL_FONT                      = UIFont.systemFontOfSize(DeviceType.IS_IPAD ? 16           * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 16     : DeviceType.IS_IPHONE_6 ? 16   * IPHONE_6_SCALE : 16   * IPHONE_5_SCALE)
let TITLE_FONT                          = UIFont.systemFontOfSize(DeviceType.IS_IPAD ? 18           * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 18     : DeviceType.IS_IPHONE_6 ? 18   * IPHONE_6_SCALE : 18   * IPHONE_5_SCALE)
let CA_TITLE_FONT                       = UIFont.boldSystemFontOfSize(DeviceType.IS_IPAD ? 18       * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 18     : DeviceType.IS_IPHONE_6 ? 18   * IPHONE_6_SCALE : 18   * IPHONE_5_SCALE)
let CAC_TITLE_FONT                      = UIFont.boldSystemFontOfSize(DeviceType.IS_IPAD ? 22       * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 22     : DeviceType.IS_IPHONE_6 ? 22   * IPHONE_6_SCALE : 22   * IPHONE_5_SCALE)
let DESC_FONT                           = UIFont.boldSystemFontOfSize(DeviceType.IS_IPAD ? 12       * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 12     : DeviceType.IS_IPHONE_6 ? 12   * IPHONE_6_SCALE : 12   * IPHONE_5_SCALE)
let LINK_FONT                           = UIFont.systemFontOfSize(DeviceType.IS_IPAD ? 14           * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 14     : DeviceType.IS_IPHONE_6 ? 14   * IPHONE_6_SCALE : 14   * IPHONE_5_SCALE)

//MARK: - Verify Constants -
let VE_INSET : CGFloat                  = DeviceType.IS_IPAD ? 10     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 10     : DeviceType.IS_IPHONE_6 ? 10   * IPHONE_6_SCALE : 10   * IPHONE_5_SCALE
let VE_OFFSET : CGFloat                 = DeviceType.IS_IPAD ? 30     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 30     : DeviceType.IS_IPHONE_6 ? 30   * IPHONE_6_SCALE : 30   * IPHONE_5_SCALE
let VE_HEIGHT : CGFloat                 = DeviceType.IS_IPAD ? 40     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 40     : DeviceType.IS_IPHONE_6 ? 40   * IPHONE_6_SCALE : 40   * IPHONE_5_SCALE
let VE_WIDTH : CGFloat                  = (ScreenSize.WIDTH)/2

//MARK: - Manage Constants -
let MA_INSET : CGFloat                  = DeviceType.IS_IPAD ? 10     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 10     : DeviceType.IS_IPHONE_6 ? 10   * IPHONE_6_SCALE : 10   * IPHONE_5_SCALE
let MA_OFFSET : CGFloat                 = DeviceType.IS_IPAD ? 30     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 30     : DeviceType.IS_IPHONE_6 ? 30   * IPHONE_6_SCALE : 30   * IPHONE_5_SCALE
let MA_HEIGHT : CGFloat                 = DeviceType.IS_IPAD ? 40     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 40     : DeviceType.IS_IPHONE_6 ? 40   * IPHONE_6_SCALE : 40   * IPHONE_5_SCALE
let MA_WIDTH : CGFloat                  = (ScreenSize.WIDTH - MA_OFFSET*3)

//MARK: - Home Constants -
let HO_INSET : CGFloat                  = DeviceType.IS_IPAD ? 10     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 10     : DeviceType.IS_IPHONE_6 ? 10   * IPHONE_6_SCALE : 10   * IPHONE_5_SCALE
let HO_CELL_HEIGHT : CGFloat            = DeviceType.IS_IPAD ? 90     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 90     : DeviceType.IS_IPHONE_6 ? 90   * IPHONE_6_SCALE : 90   * IPHONE_5_SCALE

//MARK: - Subcategory Constants -
let SB_INSET : CGFloat                  = DeviceType.IS_IPAD ? 10     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 10     : DeviceType.IS_IPHONE_6 ? 10   * IPHONE_6_SCALE : 10   * IPHONE_5_SCALE
let SB_CELL_WIDTH : CGFloat             = (ScreenSize.WIDTH - 6*SB_INSET)/3

//MARK: - Objects Constants -
let OB_INSET : CGFloat                  = DeviceType.IS_IPAD ? 10     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 10     : DeviceType.IS_IPHONE_6 ? 10   * IPHONE_6_SCALE : 10   * IPHONE_5_SCALE
let OB_CELL_HEIGHT : CGFloat            = DeviceType.IS_IPAD ? 110    * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 110    : DeviceType.IS_IPHONE_6 ? 110  * IPHONE_6_SCALE : 110  * IPHONE_5_SCALE

//MARK: - Product Constants -
let PR_INSET : CGFloat                  = DeviceType.IS_IPAD ? 10     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 10     : DeviceType.IS_IPHONE_6 ? 10   * IPHONE_6_SCALE : 10   * IPHONE_5_SCALE
let PR_LAYOUT_WIDTH : CGFloat           = (ScreenSize.WIDTH - PR_INSET*4)/2

//MARK: - Cart Constants -
let CA_INSET : CGFloat                  = DeviceType.IS_IPAD ? 10     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 10     : DeviceType.IS_IPHONE_6 ? 10   * IPHONE_6_SCALE : 10   * IPHONE_5_SCALE
let CA_CELL_HEIGHT : CGFloat            = DeviceType.IS_IPAD ? 80     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 80     : DeviceType.IS_IPHONE_6 ? 80   * IPHONE_6_SCALE : 80   * IPHONE_5_SCALE
let CA_COUNT                            = 10

//MARK: - Search Constants -
let SE_INSET : CGFloat                  = DeviceType.IS_IPAD ? 10     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 10     : DeviceType.IS_IPHONE_6 ? 10   * IPHONE_6_SCALE : 10   * IPHONE_5_SCALE
let SE_OFFSET : CGFloat                 = DeviceType.IS_IPAD ? 30     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 30     : DeviceType.IS_IPHONE_6 ? 30   * IPHONE_6_SCALE : 30   * IPHONE_5_SCALE
let SE_CELL_HEIGHT : CGFloat            = DeviceType.IS_IPAD ? 50     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 50     : DeviceType.IS_IPHONE_6 ? 50   * IPHONE_6_SCALE : 50   * IPHONE_5_SCALE
let SE_SEARCH_HEIGHT : CGFloat          = DeviceType.IS_IPAD ? 80     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 80     : DeviceType.IS_IPHONE_6 ? 80   * IPHONE_6_SCALE : 80   * IPHONE_5_SCALE

//MARK: - MapView Constants -
let MP_INSET : CGFloat                  = DeviceType.IS_IPAD ? 20     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 20     : DeviceType.IS_IPHONE_6 ? 20   * IPHONE_6_SCALE : 20    * IPHONE_5_SCALE
let MP_BTN_SIZE : CGFloat               = DeviceType.IS_IPAD ? 50     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 50     : DeviceType.IS_IPHONE_6 ? 50   * IPHONE_6_SCALE : 50    * IPHONE_5_SCALE
let MP_INFOWINDOW_SIZE : CGFloat        = DeviceType.IS_IPAD ? 65     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 65     : DeviceType.IS_IPHONE_6 ? 65   * IPHONE_6_SCALE : 65    * IPHONE_5_SCALE
let MP_PIN_CIRCLE_RECT                  = CGRectMake(13.5, 12, 24, 24)

//MARK: - Account Constants -
let AC_INSET : CGFloat                  = DeviceType.IS_IPAD ? 10     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 10     : DeviceType.IS_IPHONE_6 ? 10   * IPHONE_6_SCALE : DeviceType.IS_IPHONE_5 ? 10    * IPHONE_5_SCALE : 10   * IPHONE_4_SCALE
let AC_OFFSET : CGFloat                 = DeviceType.IS_IPAD ? 30     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 30     : DeviceType.IS_IPHONE_6 ? 30   * IPHONE_6_SCALE : DeviceType.IS_IPHONE_5 ? 30    * IPHONE_5_SCALE : 30   * IPHONE_4_SCALE
let AC_CELL_HEIGHT : CGFloat            = DeviceType.IS_IPAD ? 50     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 50     : DeviceType.IS_IPHONE_6 ? 50   * IPHONE_6_SCALE : DeviceType.IS_IPHONE_5 ? 50    * IPHONE_5_SCALE : 50   * IPHONE_4_SCALE
let AC_HEIGHT : CGFloat                 = DeviceType.IS_IPAD ? 80     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 80     : DeviceType.IS_IPHONE_6 ? 80   * IPHONE_6_SCALE : DeviceType.IS_IPHONE_5 ? 80    * IPHONE_5_SCALE : 80   * IPHONE_4_SCALE
let AC_BTN_SIZE : CGFloat               = DeviceType.IS_IPAD ? 120    * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 120    : DeviceType.IS_IPHONE_6 ? 120  * IPHONE_6_SCALE : DeviceType.IS_IPHONE_5 ? 120   * IPHONE_5_SCALE : 120  * IPHONE_4_SCALE

//MARK: - Contuct Us Constants -
let CO_INSET : CGFloat                  = DeviceType.IS_IPAD ? 10     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 10     : DeviceType.IS_IPHONE_6 ? 10   * IPHONE_6_SCALE : 10   * IPHONE_5_SCALE
let CO_OFFSET : CGFloat                 = DeviceType.IS_IPAD ? 30     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 30     : DeviceType.IS_IPHONE_6 ? 30   * IPHONE_6_SCALE : 30   * IPHONE_5_SCALE
let CO_CELL_HEIGHT : CGFloat            = DeviceType.IS_IPAD ? 40     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 40     : DeviceType.IS_IPHONE_6 ? 40   * IPHONE_6_SCALE : 40   * IPHONE_5_SCALE
let CO_HEIGHT : CGFloat                 = DeviceType.IS_IPAD ? 350    * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 350    : DeviceType.IS_IPHONE_6 ? 350  * IPHONE_6_SCALE : 350  * IPHONE_5_SCALE
let CO_BTN_SIZE : CGFloat               = DeviceType.IS_IPAD ? 100    * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 100    : DeviceType.IS_IPHONE_6 ? 100  * IPHONE_6_SCALE : 100  * IPHONE_5_SCALE

//MARK: - History Constants -
let HI_INSET : CGFloat                  = DeviceType.IS_IPAD ? 5      * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 5      : DeviceType.IS_IPHONE_6 ? 5    * IPHONE_6_SCALE : 5    * IPHONE_5_SCALE
let HI_OFFSET : CGFloat                 = DeviceType.IS_IPAD ? 20     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 20     : DeviceType.IS_IPHONE_6 ? 20   * IPHONE_6_SCALE : 20   * IPHONE_5_SCALE
let HI_IMG_SIZE : CGFloat               = DeviceType.IS_IPAD ? 40     * IPAD_SCALE : DeviceType.IS_IPHONE_6P ? 40     : DeviceType.IS_IPHONE_6 ? 40   * IPHONE_6_SCALE : 40   * IPHONE_5_SCALE

let codes = [
    "_AF"      : "+93",
    "_AL"      : "+355",
    "_DZ"      : "+213",
    "_AS"      : "+1 684",
    "_AD"      : "+376",
    "_AO"      : "+244",
    "_AI"      : "+1 264",
    "_AG"      : "+1 268",
    "_AR"      : "+54",
    "_AM"      : "+374",
    "_AW"      : "+297",
    "_AU"      : "+61",
    "_AT"      : "+43",
    "_AZ"      : "+994",
    "_BS"      : "+1 242",
    "_BH"      : "+973",
    "_BD"      : "+880",
    "_BB"      : "+1 246",
    "_BY"      : "+375",
    "_BE"      : "+32",
    "_BZ"      : "+501",
    "_BJ"      : "+229",
    "_BM"      : "+1 441",
    "_BT"      : "+975",
    "_BO"      : "+591",
    "_BA"      : "+387",
    "_BW"      : "+267",
    "_BR"      : "+55",
    "_IO"      : "+246",
    "_VG"      : "+1 284",
    "_BN"      : "+673",
    "_BG"      : "+359",
    "_BF"      : "+226",
    "_BI"      : "+257",
    "_KH"      : "+855",
    "_CM"      : "+237",
    "_CA"      : "+1",
    "_CV"      : "+238",
    "_KY"      : "+ 345",
    "_CF"      : "+236",
    "_TD"      : "+235",
    "_CL"      : "+56",
    "_CN"      : "+86",
    "_CX"      : "+61",
    "_CC"      : "+61",
    "_CO"      : "+57",
    "_KM"      : "+269",
    "_CG"      : "+242",
    "_CD"      : "+243",
    "_CK"      : "+682",
    "_CR"      : "+506",
    "_CI"      : "+225",
    "_HR"      : "+385",
    "_CU"      : "+53",
    "_CY"      : "+537",
    "_CZ"      : "+420",
    "_DK"      : "+45",
    "_DJ"      : "+253",
    "_DM"      : "+1 767",
    "_DO"      : "+1 809",
    "_TL"      : "+670",
    "_EC"      : "+593",
    "_EG"      : "+20",
    "_SV"      : "+503",
    "_GQ"      : "+240",
    "_ER"      : "+291",
    "_EE"      : "+372",
    "_ET"      : "+251",
    "_FK"      : "+500",
    "_FO"      : "+298",
    "_FJ"      : "+679",
    "_FI"      : "+358",
    "_FR"      : "+33",
    "_PF"      : "+689",
    "_GA"      : "+241",
    "_GM"      : "+220",
    "_GE"      : "+995",
    "_DE"      : "+49",
    "_GH"      : "+233",
    "_GI"      : "+350",
    "_GR"      : "+30",
    "_GL"      : "+299",
    "_GD"      : "+1 473",
    "_GP"      : "+590",
    "_GU"      : "+1 671",
    "_GT"      : "+502",
    "_GN"      : "+224",
    "_GW"      : "+245",
    "_GY"      : "+595",
    "_HT"      : "+509",
    "_HN"      : "+504",
    "_HK"      : "+852",
    "_HU"      : "+36",
    "_IS"      : "+354",
    "_IN"      : "+91",
    "_ID"      : "+62",
    "_IR"      : "+98",
    "_IQ"      : "+964",
    "_IE"      : "+353",
    "_IL"      : "+972",
    "_IT"      : "+39",
    "_JM"      : "+1 876",
    "_JP"      : "+81",
    "_JO"      : "+962",
    "_KZ"      : "+7 7",
    "_KE"      : "+254",
    "_KI"      : "+686",
    "_KP"      : "+850",
    "_KR"      : "+82",
    "_KW"      : "+965",
    "_KG"      : "+996",
    "_LA"      : "+856",
    "_LV"      : "+371",
    "_LB"      : "+961",
    "_LS"      : "+266",
    "_LR"      : "+231",
    "_LY"      : "+218",
    "_LI"      : "+423",
    "_LT"      : "+370",
    "_LU"      : "+352",
    "_MO"      : "+853",
    "_MK"      : "+389",
    "_MG"      : "+261",
    "_MW"      : "+265",
    "_MY"      : "+60",
    "_MV"      : "+960",
    "_ML"      : "+223",
    "_MT"      : "+356",
    "_MH"      : "+692",
    "_MQ"      : "+596",
    "_MR"      : "+222",
    "_MU"      : "+230",
    "_YT"      : "+262",
    "_MX"      : "+52",
    "_FM"      : "+691",
    "_MD"      : "+373",
    "_MC"      : "+377",
    "_MN"      : "+976",
    "_ME"      : "+382",
    "_MS"      : "+1664",
    "_MA"      : "+212",
    "_MM"      : "+95",
    "_NA"      : "+264",
    "_NR"      : "+674",
    "_NP"      : "+977",
    "_NL"      : "+31",
    "_AN"      : "+599",
    "_KN"      : "+1 869",
    "_NC"      : "+687",
    "_NZ"      : "+64",
    "_NI"      : "+505",
    "_NE"      : "+227",
    "_NG"      : "+234",
    "_NU"      : "+683",
    "_NF"      : "+672",
    "_MP"      : "+1 670",
    "_NO"      : "+47",
    "_OM"      : "+968",
    "_PK"      : "+92",
    "_PW"      : "+680",
    "_PS"      : "+970",
    "_PA"      : "+507",
    "_PG"      : "+675",
    "_PY"      : "+595",
    "_PE"      : "+51",
    "_PH"      : "+63",
    "_PL"      : "+48",
    "_PT"      : "+351",
    "_PR"      : "+1 787",
    "_QA"      : "+974",
    "_RO"      : "+40",
    "_RU"      : "+7",
    "_RW"      : "+250",
    "_WS"      : "+685",
    "_SM"      : "+378",
    "_SA"      : "+966",
    "_SN"      : "+221",
    "_RS"      : "+381",
    "_SC"      : "+248",
    "_SL"      : "+232",
    "_SG"      : "+65",
    "_SK"      : "+421",
    "_SB"      : "+677",
    "_ZA"      : "+27",
    "_GS"      : "+500",
    "_ES"      : "+34",
    "_LK"      : "+94",
    "_SD"      : "+249",
    "_SR"      : "+597",
    "_SZ"      : "+268",
    "_SE"      : "+46",
    "_CH"      : "+41",
    "_SY"      : "+963",
    "_TW"      : "+886",
    "_TJ"      : "+992",
    "_TZ"      : "+255",
    "_TH"      : "+66",
    "_TG"      : "+228",
    "_TK"      : "+690",
    "_TO"      : "+676",
    "_TT"      : "+1 868",
    "_TN"      : "+216",
    "_TR"      : "+90",
    "_TM"      : "+993",
    "_TC"      : "+1 649",
    "_TV"      : "+688",
    "_UG"      : "+256",
    "_UA"      : "+380",
    "_AE"      : "+971",
    "_GB"      : "+44",
    "_US"      : "+1",
    "_UY"      : "+598",
    "_VI"      : "+1 340",
    "_UZ"      : "+998",
    "_VU"      : "+678",
    "_VE"      : "+58",
    "_VN"      : "+84",
    "_WF"      : "+681",
    "_YE"      : "+967",
    "_ZM"      : "+260",
    "_ZW"      : "+263",
]
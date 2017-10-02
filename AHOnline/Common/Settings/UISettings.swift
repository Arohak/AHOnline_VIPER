//
//  UISettings.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/19/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import UIKit

func scale(size: CGFloat) -> CGFloat {
    switch UIDevice.modelType {
    case .iPhone_4, .iPhone_5:
        return size * Scale.iphone_5
    case .iPhone_6, .iPhone_7:
        return size * Scale.iphone_6
    case .iPhone_6p, .iPhone_7p:
        return size * Scale.iphone_6p
    case .iPad:
        return size * Scale.ipad
    default:
        return 0
    }
}


//MARK: - All Colors -
let RCOLORS                             = [UIColor.blue, UIColor.red, UIColor.orange, UIColor.green]
let FONT_NAVBAR                         = UIFont.systemFont(ofSize: Device.ipad ? 25 : 18)
let FONT_TABBAR                         = UIFont.systemFont(ofSize: Device.ipad ? 14 : 10)
let NAV_HEIGHT: CGFloat                 = 64
let TAB_HEIGHT: CGFloat                 = 46
let LIMIT                               = 10
let OFFSET                              = 0


//MARK: - Callback Typealias -
typealias CollectionCallback            = (_ indexPath: IndexPath) -> Void
typealias PickerCallback                = (_ value: String) -> Void
typealias ManageAddressPickerCallback   = (_ value: (String, String)) -> Void
typealias DeliveryPickerCallback        = (_ value: Delivery, _ index: Int) -> Void
typealias DistancePickerCallback        = (_ value: Double, _ index: Int) -> Void
typealias LanguagePickerCallback        = (_ value: String, _ index: Int) -> Void


//MARK: - Font Constants -
let TITLE_BTN_FONT                      = UIFont.boldSystemFont(ofSize: scale(size: 14))
let TITLE_LBL_FONT                      = UIFont.systemFont(ofSize: scale(size: 16))
let PK_DRAM_FONT                        = UIFont.boldSystemFont(ofSize: scale(size: 16))
let TITLE_FONT                          = UIFont.systemFont(ofSize: scale(size: 18))
let CA_TITLE_FONT                       = UIFont.boldSystemFont(ofSize: scale(size: 18))
let CAC_TITLE_FONT                      = UIFont.boldSystemFont(ofSize: scale(size: 22))
let DESC_FONT                           = UIFont.boldSystemFont(ofSize: scale(size: 12))
let LINK_FONT                           = UIFont.systemFont(ofSize: scale(size: 14))
let DRAM_FONT                           = UIFont(name: "Verdana", size: scale(size: 14))


//MARK: - All Constants -
let BTN_SIZE : CGFloat                  = scale(size: 60)


//MARK: - Verify Constants -
let VE_INSET : CGFloat                  = scale(size: 10)
let VE_OFFSET : CGFloat                 = scale(size: 30)
let VE_HEIGHT : CGFloat                 = scale(size: 40)
let VE_WIDTH : CGFloat                  = (Screen.width)/2


//MARK: - Manage Constants -
let MA_INSET : CGFloat                  = scale(size: 10)
let MA_OFFSET : CGFloat                 = scale(size: 30)
let MA_HEIGHT : CGFloat                 = scale(size: 40)
let MA_WIDTH : CGFloat                  = (Screen.width - MA_OFFSET*3)


//MARK: - Home Constants -
let HO_INSET : CGFloat                  = scale(size: 10)
let HO_BTN_SIZE : CGFloat               = scale(size: 50)
let HO_CELL_HEIGHT : CGFloat            = scale(size: 90)


//MARK: - Subcategory Constants -
let SB_INSET : CGFloat                  = scale(size: 10)
let SB_CELL_WIDTH : CGFloat             = (Screen.width - 6*SB_INSET)/3


//MARK: - Objects Constants -
let OB_INSET : CGFloat                  = scale(size: 10)
let OB_IMG_SIZE : CGFloat               = scale(size: 20)
let OB_CELL_HEIGHT : CGFloat            = scale(size: 110)


//MARK: - Product Constants -
let PR_INSET : CGFloat                  = scale(size: 10)
let PR_LAYOUT_WIDTH : CGFloat           = (Screen.width - PR_INSET*4)/2


//MARK: - Cart Constants -
let CA_INSET : CGFloat                  = scale(size: 10)
let CA_CELL_HEIGHT : CGFloat            = scale(size: 80)
let CA_COUNT                            = 10


//MARK: - Search Constants -
let SE_INSET : CGFloat                  = scale(size: 10)
let SE_OFFSET : CGFloat                 = scale(size: 30)
let SE_CELL_HEIGHT : CGFloat            = scale(size: 50)
let SE_SEARCH_HEIGHT : CGFloat          = scale(size: 80)


//MARK: - MapView Constants -
let MP_INSET : CGFloat                  = scale(size: 20)
let MP_BTN_SIZE : CGFloat               = scale(size: 50)
let MP_INFOWINDOW_SIZE : CGFloat        = scale(size: 65)
let MP_PIN_CIRCLE_RECT                  = CGRect(x: 13.5, y: 12, width: 24, height: 24)


//MARK: - Account Constants -
let AC_INSET : CGFloat                  = scale(size: 10)
let AC_OFFSET : CGFloat                 = scale(size: 30)
let AC_CELL_HEIGHT : CGFloat            = scale(size: 50)
let AC_HEIGHT : CGFloat                 = scale(size: 80)
let AC_IMG_SIZE : CGFloat               = scale(size: 140)


//MARK: - Contuct Us Constants -
let CO_INSET : CGFloat                  = scale(size: 10)
let CO_OFFSET : CGFloat                 = scale(size: 30)
let CO_CELL_HEIGHT : CGFloat            = scale(size: 40)
let CO_HEIGHT : CGFloat                 = scale(size: 350)
let CO_BTN_SIZE : CGFloat               = scale(size: 100)


//MARK: - History Constants -
let HI_INSET : CGFloat                  = scale(size: 5)
let HI_OFFSET : CGFloat                 = scale(size: 20)
let HI_IMG_SIZE : CGFloat               = scale(size: 40)


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

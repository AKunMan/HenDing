//
//  File.swift
//  MeicunFarm
//
//  Created by furao on 2019/5/11.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
import CommonCrypto

extension String{
    //MARK:转化为Int
    func toInt()->Int {
        var int = 0
        if(self.count > 0){
            if let intValue = Int(self)
            {
                int = Int(intValue)
            }
        }
        return int
    }
    
    func toInt64()->Int64{
        var int:Int64 = 0
        if(self.count > 0){
            if let intValue = Int64(self)
            {
                int = Int64(intValue)
            }
        }
        return int
    }
    
    
    func toDouble()->Double {
        
        var double : Double = 0
        
        if(self.count > 0){
            
            if let doubleValue = Double(self)
            {
                double = Double(doubleValue)
            }
        }
        
        return double
    }
    
    func toCGFloat()->CGFloat {
        return CGFloat(self.toDouble())
    }
    
    func toPrice() -> String {
        return String(format: "%.0f", self.toCGFloat() * 100)
    }
    func getPrice() -> String {
        return String(format: "%.2f", self.toCGFloat() / 100)
    }
    
    func toImg() -> String {
        if self.contains(",") {
            let array = self.components(separatedBy: ",")
            return array[0]
        }
        return self
    }
    
    //MARK: 数字格式化不要小数点
    func toNumberUNPoint()->String{
        let format = NumberFormatter()
        format.positiveFormat = "######0"
        format.roundingMode = .floor
        let d = self.toDouble()
        if let string = format.string(from: NSNumber(value: d)){
            return string
        }
        return ""
    }
    
    //MARK: 数字格式化不要小数点
    func deleteInvalid0() -> String{
        if self.contains(".") {
            let str = self.substring(from: self.count - 1)
            if str == "0" {
                let string = self.substring(to: self.count - 1)
                return string.deleteInvalid0()
            }else if str == "."{
                return self.substring(to: self.count - 1)
            }
        }
        return self
    }
    
    //MARK: 数字格式化为金额
    func toNumberFormatter(_ is100:Bool = false)->String{
        
        var numStr = self
        if is100{
            numStr = "\(numStr.toCGFloat()/100.0)"
        }
        
        let format = NumberFormatter()
        format.positiveFormat = "#####0.00"
        format.roundingMode = .floor
        let d = numStr.toDouble()
        if let string = format.string(from: NSNumber(value: d)){
            return string
        }
        return ""
    }
    
    //MARK: 数字格式化为万元金额
    func toWanNumberFormatter()->String{
        let format = NumberFormatter()
        var d = self.toDouble()
        if d >= 10000{
            d = d/10000.0
            format.positiveFormat = "0.00万"
        }else if abs(d) >= 10000{
            d = d/10000.0
            format.positiveFormat = "0.00万"
        }else{
            format.positiveFormat = "0.00"
        }
        format.roundingMode = .floor
        if let string = format.string(from: NSNumber(value: d)){
            return string
        }
        return ""
    }
    
    
    func getStringFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let date = dateFormatter.date(from: self){
            return date.getDateFormat()
        }
        return self
    }
    
    func toStringFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let date = dateFormatter.date(from: self){
            return date.getDateMMdd()
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self){
            return date.getDateMMdd()
        }
        return self
    }
    
    func toStringMMDDFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        if let date = dateFormatter.date(from: self){
            return (date as NSDate).timeNewShareDescription()
        }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self){
            return (date as NSDate).timeNewShareDescription()
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'+08:00'"
        if let date = dateFormatter.date(from: self){
            
            return (date as NSDate).timeNewShareDescription()
        }
        
        return self
    }
    
    func toStringMMDD2Format() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let date = dateFormatter.date(from: self){
            return date.getDateMMdd3()
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self){
            return date.getDateMMdd3()
        }
        
        
        return self
    }
    
    func toDateYYYYMMDDFormat() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self){
            return date
        }
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let date = dateFormatter.date(from: self){
            return date
        }
        return nil
    }
    
    func getYear() -> Int{
        if let data = self.toDateYYYYMMDDFormat(){
            return (data as NSDate).year
        }
        return 0
    }
    
    func getMonth() -> Int{
        if let data = self.toDateYYYYMMDDFormat(){
            return (data as NSDate).month
        }
        return 0
    }
    
    func getDay() -> Int{
        if let data = self.toDateYYYYMMDDFormat(){
            return (data as NSDate).day
        }
        return 0
    }
    
//    func getDelLine() -> NSMutableAttributedString{
//        let attributedString = NSMutableAttributedString(string: self)
//
//        attributedString.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: NSMakeRange(0, attributedString.length))
//        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
//        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hexString:"666666"), range: NSRange(location:0,length:attributedString.length))
//        return attributedString
//    }
    
    //时间戳转到字符串
    func timeStampToStringStyle()->String {
        
        let string = NSString(string: self)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        let date = NSDate(timeIntervalSince1970: timeSta)
        dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }
    
    //时间戳转到字符串
    func toyyyyMMdd()->String {
        
        let string = NSString(string: self)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        let date = NSDate(timeIntervalSince1970: timeSta)
        dfmatter.dateFormat = "yyyy-MM-dd"
        return dfmatter.string(from: date as Date)
    }
    //时间戳转到字符串
    func toyyyyMMdd2()->String {
        
        let string = NSString(string: self)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        let date = NSDate(timeIntervalSince1970: timeSta)
        dfmatter.dateFormat = "yyyy/MM/dd"
        return dfmatter.string(from: date as Date)
    }
    //时间戳转到字符串
    func toyyyyMMdd3()->String {
        
        let string = NSString(string: self)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        let date = NSDate(timeIntervalSince1970: timeSta)
        dfmatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }
    
    func getDateFromTime() ->Date{
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat="yyyy/MM/dd HH:mm:ss"
        
        var dateStr = self
        if dateStr.count < 11 {
            dateStr = "\(self) 00:00:00"
        }
        
        return dateformatter.date(from: dateStr)!
        
    }
    func toTimeStampDate() -> Date{
        let string = NSString(string: self)
        let timeSta:TimeInterval = string.doubleValue
        let date = Date(timeIntervalSince1970: timeSta)
        return date
    }
    
    func toStringYYYYMMDDFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        if let date = dateFormatter.date(from: self){
            return date.getDateYYYYMMdd()
        }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self){
            return date.getDateYYYYMMdd()
        }
        return self
    }
    
    func toStringMMDDFormat1() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        if let date = dateFormatter.date(from: self){
            return date.getDateMMdd()
        }
        return self
    }
    
    //MARK: 判断是否存在字符串
    func contains(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(_ find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    //格式化时间
    func toDateFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        if let date = dateFormatter.date(from: self){
            return (date as NSDate).timeNewShareDescription()
        }
        return self
    }
    
    func URLEncodedString() -> String{
        let charactersToEscape = "+"
        let allowedCharacters = CharacterSet.init(charactersIn: charactersToEscape).inverted
        //        let m = "ab+c"
        if let encodStr = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters){
            print(encodStr)
            return encodStr
        }
        return self
    }
    func URLDecodedString() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    func toDictionary()->[String:Any]?{
        
        if let data = self.data(using: .utf8){
            do {
                let ay = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: UInt(0)))
                return ay as? [String : Any]
            } catch {
                return nil
            }
        }
        return nil
    }
    
    func toArray() -> [[String:Any]]?{
        
        if let data = self.data(using: .utf8){
            do {
                let ay = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: UInt(0)))
                return ay as? [[String:Any]]
            } catch {
                return nil
            }
        }
        return nil
    }
    
    func positionOf(sub:String, backwards:Bool = false)->Int {
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
    
    
    func trim() -> String{
        return self.replacingOccurrences(of: " ", with: "")
//        return self.trimmingCharacters(in: .whitespaces)
    }
    
    /// 验证是否是纯数字
    func isNumber() -> Bool {
        let pattern = "^[0-9]+$"
        if NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self) {
            return true
        }
        return false
    }
}

//MARK: Base64
extension String{
    func base64Encoding(plainString:String)->String
        
    {
        let plainData = plainString.data(using: String.Encoding.utf8)
        
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    
    func toBase64Decoding()->String
    {
        if let decodedData = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0)){
            if let decodedString = NSString(data: decodedData as Data, encoding: String.Encoding.utf8.rawValue) {
                return decodedString as String
            }
        }
        return self
    }
}

extension String {
    
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
    public func substring(to index: Int) -> String {
        if self.count > index {
            let endindex = self.index(self.startIndex, offsetBy: index)
            let subString = self[self.startIndex..<endindex]
            return String(subString)
        } else {
            return self
        }
    }
    
    public func substring(to: Int,from: Int) -> String {
        if self.count > to && self.count > from{
            let strindex = self.index(self.startIndex, offsetBy: to)
            let endindex = self.index(self.startIndex, offsetBy: from)
            let subString = self[strindex..<endindex]
            return String(subString)
        } else {
            return self
        }
    }
    
}
//md5加密
extension String {
    var md5 : String{
        guard let data = self.data(using: .utf8) else {
            return self
        }
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            return CC_MD5(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}

extension String {
    
    /// 获取高度计算
    ///
    /// - Parameters:
    ///   - size: 矩形已知范围
    ///   - attributes: 文字属性
    /// - Returns: 高度
    public func height(_ size: CGSize, _ attributes: [NSAttributedString.Key: Any]?) -> CGFloat {
        
        let string = self as NSString
        
        let stringSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return stringSize.height
        
    }
    
    public func height(_ width:CGFloat) -> CGFloat {
        let string = self as NSString
        let size = CGSize(width: width, height: 10000)
        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]
        let stringSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return stringSize.height
    }
    
    /// 获取宽度计算
    ///
    /// - Parameters:
    ///   - size: 矩形已知范围
    ///   - attributes: 文字属性
    /// - Returns: 宽度
    public func width(_ size: CGSize, _ attributes: [NSAttributedString.Key: Any]?) -> CGFloat {
        
        let string = self as NSString
        
        let stringSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return stringSize.width
        
    }
    /// 获取宽度计算
    ///
    /// - Parameters:
    ///   - size: 矩形已知范围
    ///   - attributes: 文字属性
    /// - Returns: 宽度
    public func width(_ size: CGSize) -> CGFloat {
        
        let string = self as NSString
        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]
        let stringSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return stringSize.width
        
    }
}

extension String {
    /*
     *去掉首尾空格
     */
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉所有空格
     */
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /*
     *去掉首尾空格 后 指定开头空格数
     */
    func beginSpaceNum(num: Int) -> String {
        var beginSpace = ""
        for _ in 0..<num {
            beginSpace += " "
        }
        return beginSpace + self.removeHeadAndTailSpacePro
    }
    
    
    static func intIntoString(number: Int) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style(rawValue: UInt(CFNumberFormatterRoundingMode.roundHalfDown.rawValue))!
        let string:String = formatter.string(from: NSNumber(value: number))!
        return string
    }
}


extension String {
    /*
     * 金额输入框是否能输入
     */
    func judgePriceTextInput() -> Bool {
        let range = self.range(of: ".")
        if range != nil {
            let location: Int = self.distance(from: self.startIndex, to: range!.lowerBound)
            if location < self.count - 1{
                let rightStr = self.substring(from: location + 1)
                print(rightStr)
                if rightStr.count > 2{
                    return false
                }
                if rightStr.contains("."){
                    return false
                }
            }
        }
        return true
    }
}


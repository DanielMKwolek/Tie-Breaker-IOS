import UIKit

struct UInt32GenerationResponse {
    var uInt: UInt32?
    var error: String?
}

func diceRollWithNumberOfSides(sides: UInt32, baseValue: UInt32?) -> UInt32GenerationResponse {
    guard sides > 0 else { return UInt32GenerationResponse(uInt: nil, error: "Tried to generate roll with 0 sides.")}
    if baseValue != nil {
        guard UInt32.max - baseValue! >= sides else { return UInt32GenerationResponse(uInt: nil, error: "Number of sides + baseValue must be less than UInt32")}
        return UInt32GenerationResponse(uInt: (arc4random() % sides) + baseValue!, error: nil)
    } else {
        return UInt32GenerationResponse(uInt: (arc4random() % sides), error: nil)
    }
}

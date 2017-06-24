//
//  Example of using DoubleAlignmentLabel
//

import UIKit

let dictionary = [
    "    Key 1": "10  ",
    "    Key 2": "9    ",
    "    Key 3": "8    ",
    "    Key 4": "7    ",
    "    Key 5": "6    ",
    "    Key 6": "5    ",
    "    Key 7": "5    "
]
let label = DoubleAlignmentLabel(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
label.backgroundColor = UIColor(colorLiteralRed: 201/255.0,
                                                        green: 53/255.0,
                                                        blue: 96/255.0,
                                                        alpha: 1.0)
label.set(text: dictionary)




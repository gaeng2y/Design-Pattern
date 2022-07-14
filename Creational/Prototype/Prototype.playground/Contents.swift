import UIKit

protocol Prototype: AnyObject {
    func clone() -> Self
}

class Odongnamu: Prototype {
    var age: Int

    init(age: Int) {
        self.age = age
    }

    func clone() -> Self {
        return Odongnamu(age: self.age) as! Self
    }
}

let odongnamu = Odongnamu(age: 500)
odongnamu.age += 50
print(odongnamu.age)

let odongnamu2 = odongnamu.clone()
odongnamu2.age += 30
print(odongnamu2.age)

/*
550
580
*/

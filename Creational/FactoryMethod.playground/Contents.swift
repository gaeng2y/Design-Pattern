import UIKit

// Creator
protocol AppleFactory {
    func createElectronics() -> Product
}

// Concrete Creator
class IPhoneFactory: AppleFactory {
    func createElectronics() -> Product {
        return IPhone()
    }
}

class IPadFactory: AppleFactory {
    func createElectronics() -> Product {
        return IPad()
    }
}

// Product
protocol Product {
    func produceProduct()
}

// Concrete Product
class IPhone: Product {
    func produceProduct() {
        print("Hello, iPhone was made")
    }
}

class IPad: Product {
    func produceProduct() {
        print("Hello, iPad wad made")
    }
}

class Client {
    func order(factory: AppleFactory) {
        let elctronicsProduct = factory.createElectronics()
        elctronicsProduct.produceProduct()
    }
}

var client = Client()

client.order(factory: IPadFactory())
client.order(factory: IPhoneFactory())

/*
Hello, iPad was made
Hello, iPhone was made
*/

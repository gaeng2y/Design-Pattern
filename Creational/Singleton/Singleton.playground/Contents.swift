import UIKit

enum Milk {
    case chocolate
    case strawberry
    case banana
}

// Singleton
class MilkStorage {
    static let shared = MilkStorage()
    private var chocolateMilkCount = 100
    private var strawberryMilkCount = 100
    private var bananaMilkCount = 100

    private init() { }

    func release(_ milk: Milk, count: Int) {
        switch milk {
        case .chocolate:
            chocolateMilkCount -= count
        case .strawberry:
            strawberryMilkCount -= count
        case .banana:
            bananaMilkCount -= count
        }
    }

    func checkMilkStock() {
        print("남은 재고: 초코 우유(\(chocolateMilkCount)), 딸기 우유(\(strawberryMilkCount)), 바나나 우유(\(bananaMilkCount))")
    }
}

class OnlineStore {
    func orderMilk(_ milk: Milk, count: Int) {
        MilkStorage.shared.release(milk, count: count)
    }
}

let naverSmartStore = OnlineStore()
let coupang = OnlineStore()
let weMakePrice = OnlineStore()

naverSmartStore.orderMilk(.chocolate, count: 15)
MilkStorage.shared.checkMilkStock()

coupang.orderMilk(.banana, count: 30)
coupang.orderMilk(.chocolate, count: 10)
MilkStorage.shared.checkMilkStock()

weMakePrice.orderMilk(.chocolate, count: 50)
weMakePrice.orderMilk(.strawberry, count: 70)
MilkStorage.shared.checkMilkStock()

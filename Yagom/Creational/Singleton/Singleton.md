# Singleton Pattern 이란?

[위키백과](https://ko.wikipedia.org/wiki/%EC%8B%B1%EA%B8%80%ED%84%B4_%ED%8C%A8%ED%84%B4)에 따르면 

> 소프트웨어 디자인 패턴에서 싱글턴 패턴(Singleton pattern)을 따르는 클래스는, 생성자가 여러 차례 호출되더라도 실제로 생성되는 객체는 하나이고 
> 최초 생성 이후에 호출된 생성자는 최초의 생성자가 생성한 객체를 리턴한다. 
> 
> 이와 같은 디자인 유형을 싱글턴 패턴이라고 한다. 
> 
> 주로 공통된 객체를 여러개 생성해서 사용하는 DBCP(DataBase Connection Pool)와 같은 상황에서 많이 사용된다.

싱글턴 패턴을 사용하게되면 **유일한 객체**를 만들 수 있다

싱글턴은 특정 클래스의 인스턴스가 오직 하나임을 보장하는 객체이다

유일한 객체를 만든다는 말은 다양한 객체들이 모두 같은 인스턴스와 소통할 수 있다는 말이다

싱글턴의 대안으로 인스턴스를 생성하여 각각의 객체들에게 의존성을 주입하는 방법을 생각해볼 수 있다

그러나 싱글턴 패턴을 사용하게 되면 하나보다 많은 인스턴스를 생성하는 것 자체를 방지할 수 있다

# Singleton Pattern은 언제 사용함?

주로 앱 전체에 걸쳐서 유일한 객체를 만들기 위해서 사용한다

**전역적으로 접근할 수 있는 유일한 객체**인 셈이다

여러 개의 객체가 같은 객체로부터 동일한 상태의 정보를 받아와야할 때 사용할 수 있다

예를 들면 어떤 사용자의 어떤 정보나 앱 전반에 걸쳐서 공유되어야하는 데이터들이 있다

우리가 자주 사용하던 UserDefaults / NotificationCenter / URLSession 등이 있다

# Swift로 Singleton Pattern 구현하기

아래는 Signleton을 정의하는데에 필요한 기본 코드다

```swift
class Singleton {
    // 1
    static let defaults = Singleton()
    // 2
    private init() { }
}
```

1. 유일한 객체가 될 프로퍼티를 static으로 정의한 후, 자기 자신을 할당해준다
2. 초기화 메소드의 접근 제한을 설정하여 외부에서는 초기화 불가능하도록 설정

```swift
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
```

## 구조체와 싱글턴

싱글턴 패턴은 주로 클래스로 구현한다

그렇다면 구조체로는 불가능하냐? 그것은 아니다

하지만 싱글턴 패턴의 목적인 유일한 객체를 사용하기 위해서다

구조체로 싱글턴을 구현하게 된다면 만약 싱글턴 객체를 인스턴스화하게 될 때 유일하지 못한 객체가 된다

예시 상황이다

```
struct Singleton {
    static let shared = Singleton()
    private init() { }
}

func address(of object: UnsafeRawPointer) -> String {
    let address = Int(bitPattern: object)
    return String(format: "%p", address)
}

var singleton1 = Singleton.shared
var singleton2 = Singleton.shared

print(address(of: &singleton1))
print(address(of: &singleton2))

/* 
0x1030fca90
0x1030fca98
*/
```

singleton1, singleton2는 서로 다른 주소값을 가지기 때문에 유일한 객체가 아니게 된다

# Singleton Pattern의 장단점

싱글턴 패턴은 유일한 객체를 만들어서 다양한 객체들에게 공유되는 객체를 만들 수 있다는 장점이 있다

또한 재사용이 가능하여 메모리 낭비를 방지할 수 있다는 장점도 있다

그러나 싱글턴 패턴은 객체 지향 관점에서 본다면 인스턴스들 간에 결합도가 높아져서 OCP(개방-폐쇠 원칙, Open-Close Principle)을 위배하게 된다는 단점이 있다

(OCP는 모듈의 확장에는 열려있어야 하고, 변경에는 닫혀있어야 한다는 객체 지향 설계의 원칙 중 하나다)
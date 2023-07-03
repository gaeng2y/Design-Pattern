# Flyweight Pattern 이란?

오늘도 어김없이 [위키백과](https://ko.wikipedia.org/wiki/%ED%94%8C%EB%9D%BC%EC%9D%B4%EC%9B%A8%EC%9D%B4%ED%8A%B8_%ED%8C%A8%ED%84%B4)를 찾아봐야죠..?

> 플라이웨이트 패턴(Flyweight pattern)는 동일하거나 유사한 객체들 사이에 가능한 많은 데이터를 서로 공유하여 사용하도록 하여 메모리 사용량을 최소화하는 소프트웨어 디자인 패턴이다. 
> 
> 종종 오브젝트의 일부 상태 정보는 공유될 수 있는데, 플라이웨이트 패턴에서는 이와 같은 상태 정보를 외부 자료 구조에 저장하여 플라이웨이트 오브젝트가 잠깐 동안 사용할 수 있도록 전달한다.

라고 하는데... 

제가 해석한대로 생각해보면... 

메모리 소비를 낮게 사용하기 위해 공통적인 부분들을 공유하도록 하는 패턴이다..?

인스턴스 생성 시 타입에 선언된 내용에 따라서 할당되는 메모리 사용량을 최소화할 수 있도록 한다고 하네요...

캐싱을 통해 계속해서 인스턴스를 생성하는 대신 캐싱된 인스턴스를 반환한다

## 언제 사용하면 좋음?

Flyweight Pattern은 유사하거나 같은 개체를 다량으로 생성해야하는 경우, 혹은 개체 간 추출 및 공유할 수 있는 데이터가 있는 경우에 사용하기 좋다고 합니다

두 가지 경우 모두 개체를 공유하면 재사용할 수 있기 때문에 메모리를 절약할 수 있다는 장점이 있습니다

## Flyweight Pattern 구성요소

![uml](https://github.com/gaeng2y/Design-Pattern/blob/main/Structural/Flyweight/Flyweight.png)

* Flyweight: 공유되는 데이터에 대한 프로토콜(인터페이스)다
* ConcreteFlyweight: **Flyweight**를 채택하는 구현체
* FlyweightFactory: **Flyweight**들을 담는 Collection을 가지며, 관리한다

## Swift로 Flyweight Pattern 구현하기

예제에서는 Flyweight pattern의 구조를 설명하고 다음 질문에 초점을 맞춥니다.

* 어떤 클래스로 구성되어 있나요?
* 이 클래스들은 어떤 역할을 하나요?
* 패턴의 요소들은 어떤 방식으로 연관되어 있는가?

패턴의 구조에 대해 알게 되면 실제 Swift 사용 사례를 바탕으로 다음 예를 더 쉽게 이해할 수 있습니다.

```swift
import Foundation
import XCTest

/// The Flyweight stores a common portion of the state (also called intrinsic
/// state) that belongs to multiple real business entities. The Flyweight
/// accepts the rest of the state (extrinsic state, unique for each entity) via
/// its method parameters.
class Flyweight {

    private let sharedState: [String]

    init(sharedState: [String]) {
        self.sharedState = sharedState
    }

    func operation(uniqueState: [String]) {
        print("Flyweight: Displaying shared (\(sharedState)) and unique (\(uniqueState) state.\n")
    }
}

/// The Flyweight Factory creates and manages the Flyweight objects. It ensures
/// that flyweights are shared correctly. When the client requests a flyweight,
/// the factory either returns an existing instance or creates a new one, if it
/// doesn't exist yet.
class FlyweightFactory {

    private var flyweights: [String: Flyweight]

    init(states: [[String]]) {

        var flyweights = [String: Flyweight]()

        for state in states {
            flyweights[state.key] = Flyweight(sharedState: state)
        }

        self.flyweights = flyweights
    }

    /// Returns an existing Flyweight with a given state or creates a new one.
    func flyweight(for state: [String]) -> Flyweight {

        let key = state.key

        guard let foundFlyweight = flyweights[key] else {

            print("FlyweightFactory: Can't find a flyweight, creating new one.\n")
            let flyweight = Flyweight(sharedState: state)
            flyweights.updateValue(flyweight, forKey: key)
            return flyweight
        }
        print("FlyweightFactory: Reusing existing flyweight.\n")
        return foundFlyweight
    }

    func printFlyweights() {
        print("FlyweightFactory: I have \(flyweights.count) flyweights:\n")
        for item in flyweights {
            print(item.key)
        }
    }
}

extension Array where Element == String {

    /// Returns a Flyweight's string hash for a given state.
    var key: String {
        return self.joined()
    }
}

class FlyweightConceptual: XCTestCase {

    func testFlyweight() {

        /// The client code usually creates a bunch of pre-populated flyweights
        /// in the initialization stage of the application.

        let factory = FlyweightFactory(states:
        [
            ["Chevrolet", "Camaro2018", "pink"],
            ["Mercedes Benz", "C300", "black"],
            ["Mercedes Benz", "C500", "red"],
            ["BMW", "M5", "red"],
            ["BMW", "X6", "white"]
        ])

        factory.printFlyweights()

        /// ...

        addCarToPoliceDatabase(factory,
                "CL234IR",
                "James Doe",
                "BMW",
                "M5",
                "red")

        addCarToPoliceDatabase(factory,
                "CL234IR",
                "James Doe",
                "BMW",
                "X1",
                "red")

        factory.printFlyweights()
    }

    func addCarToPoliceDatabase(
            _ factory: FlyweightFactory,
            _ plates: String,
            _ owner: String,
            _ brand: String,
            _ model: String,
            _ color: String) {

        print("Client: Adding a car to database.\n")

        let flyweight = factory.flyweight(for: [brand, model, color])

        /// The client code either stores or calculates extrinsic state and
        /// passes it to the flyweight's methods.
        flyweight.operation(uniqueState: [plates, owner])
    }
}
```
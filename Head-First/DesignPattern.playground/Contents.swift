import Foundation

/*
## 디자인 원칙
1. 애플리케이션에서 달라지는 부분을 찾아내고, 달라지지 않는 부분과 분리한다.
2. 구현보다는 인터페이스에 맞춰서 프로그래밍한다.
3. 상속보다는 구성을 활용한다.

## 전략 패턴
알고리즘군을 정의하고 캡슐화해서 각각의 알고리즘군을 수정해서 쓸 수 있게 해준다.
전략 패턴을 사용하면 클라이언트로부터 알고리즘을 분리해서 독립적으로 변경할 수 있다.
*/

protocol FlyBehavior {
    func fly()
}

struct FlyWithWings: FlyBehavior {
    func fly() {
        print("날개로 날다")
    }
}

protocol QuackBehavior {
    func quack()
}

struct Quack: QuackBehavior {
    func quack() {
        print("꽥")
    }
}

protocol Duck {
    var flyBehavior: FlyBehavior { get set }
    var quackBehavior: QuackBehavior { get set }
}

extension Duck {
    func swim() {
        print("수영")
    }
    
    func display() {
        print("오리")
    }
    
    func performFly() {
        self.flyBehavior.fly()
    }
    
    mutating func setFlyBehavior(with fb: FlyBehavior) {
        self.flyBehavior = fb
    }
    
    func performQuack() {
        self.quackBehavior.quack()
    }
    
    mutating func setQuackBehavior(with qb: QuackBehavior) {
        self.quackBehavior = qb
    }
}

struct RedHeadDuck: Duck {
    var flyBehavior: FlyBehavior
    var quackBehavior: QuackBehavior
}

let redHeadDuck = RedHeadDuck(
    flyBehavior: FlyWithWings(),
    quackBehavior: Quack()
)

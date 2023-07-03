# Facade Pattern 이란?

오늘도 가본다 [위키백과](https://ko.wikipedia.org/wiki/%ED%8D%BC%EC%82%AC%EB%93%9C_%ED%8C%A8%ED%84%B4)

> 퍼사드 패턴은 클래스 라이브러리 같은 어떤 소프트웨어의 다른 커다란 코드 부분에 대한 간략화된 인터페이스를 제공하는 객체이다
> 
> * 퍼사드는 소프트웨어 라이브러리를 쉽게 사용 / 이해할 수 있게 해준다. 퍼사드는 공통적인 작업에 대해 간편한 메소드들을 제공해준다.
> 
> * 퍼사드는 라이브러리 바깥쪽의 코드가 라이브러리의 안쪽 코드에 의존하는 일을 감소시켜준다. 대부분의 바깥쪽의 코드가 퍼사드를 이용하기 때문에 시스템을 개발하는 데 있어 유연성이 향상된다
> 
> * 퍼사드는 좋게 작성되지 않은 API의 집합을 하나의 좋게 작성된 API로 감싸준다
> 
> 래퍼가 특정 인터페이스를 준수해야 하며, 폴리모픽 기능을 지원해야 할 경우에는 어댑터 패턴을 쓴다.
> 
> 단지, 쉽고 단순한 인터페이스를 이용하고 싶을 경우에는 퍼사드를 쓴다


라고 합니다

UML을 간단하게 살펴보면

![위키 UML](https://upload.wikimedia.org/wikipedia/commons/5/56/UML_DP_Fa%C3%A7ade.png)

### 구조

* **Facade**: 퍼사드 클래스는 패키지 1, 2, 3 및 그림에 나오지 않은 그 밖의 응용 프로그램 코드와 상호 동작한다
* **Client**: 패키지 내의 리소드들을 접근하기 위해 퍼사드 클래스를 쓰는 객체들이다
* **Package**: 소프트웨어 라이브러리 / API 집합이다. 퍼사드 클래스를 통해 접근된다

Facade는 건물의 '**정면**'을 의미한다

Facade pattern은 다양한 인스턴스들을 하나씩 직접 소유하여 사용하지 않고, 이 인스턴스들이 협력하는 과정을 간략화된 인터페이스를 제공하는 패턴이다

즉, 복잡한 디테일은 Facade 뒤로 숨기고 Facade를 통해 간접 호출을 하는 것이다

## 언제 사용하면 좋을까?

Facade pattern은 여러 인스터스를 소유하여 사용해야하는 타입이 있는 경우, 쉽고 간단한 인터페이스를 이용해서 인스턴스들이 일을 하게끔 하고 싶을 경우에 좋은 솔루션이 될 수 있다

이때 Facade pattern을 사용하면 인스턴스와 인스턴스 간의 협렵이 많아짐에 따라 발생하는 높은 의존 관계(결합도)를 줄이고, 그렇게 시스템 개발의 유연성을 향상시킬 수 있다는 장점이 따른다

# Swift로 Facade pattern 구현하기

* 구현은 아주 간단하다. 각 부품에 대한 타입이 정의되어 있지만, Computer라는 타입의 프로퍼티로서 모두 초기화되어 관리된다

```swift
protocol DeviceFacade {
    func work()
}

struct CPU {
    func work(with memory: Memory) { }
}

struct Memory {
    func input(from devices: [Device]) { }
    func output(to devices: [Device]) { }
}

class Device { }
class InputDevice: Device { }
class OutputDevice: Device { }
class Keyboard: InputDevice { }
class Monitor: OutputDevice { }
class TouchBar: Device { }

struct Computer: DeviceFacade {
    private let cpu = CPU()
    private let memory = Memory()
    private let keyboard = Keyboard()
    private let monitor = Monitor()
    private let touchBar = TouchBar()
    
    func work() {
        memory.input(from: [keyboard, touchBar])
        cpu.work(with: memory)
        memory.output(to: [keyboard, touchBar])
    }
}

// My Code
let computer = Computer()
computer.work()
```
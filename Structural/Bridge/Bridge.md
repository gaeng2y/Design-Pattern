# Bridge Pattern 이란?

오늘도 어김없이 [위키백과](https://ko.wikipedia.org/wiki/%EB%B8%8C%EB%A6%AC%EC%A7%80_%ED%8C%A8%ED%84%B4)에 따르면...

> 구현부에서 추상층을 분리하여 각자 독립적으로 변형할 수 있게 하는 패턴이다

라고 하네요...

거대한 클래스 혹은 밀접하게 관련된 클래스들을 분리해 서로 독립적인 수정 / 확장이 가능하게 하는 Structual 디자인 패턴이다

리모콘을 예로 들어보면

기기와 리모콘에 대한 로직이 하나의 클래스에 있다면, 혹은 기기와 리모콘 타입이 서로 밀접하게 연관이 되어있다면 어떨까?

# Bridge Pattern을 이용한 해결

Shape라는 클래스의 서브 클래스인 Circle과 Square가 있다

각 클래스에 색깔을 입히는 Red / Blue 클래스가 있다면

아래의 그림 처럼 RedCircle / RedSquare / BlueCircle / BlueSquare로 만들 수 있지만 클래스가 많아진다면 한 색깔을 바꾸기만해도 많은 클래스에 변동 사항이 생긴다...

![bridge](https://refactoring.guru/images/patterns/diagrams/bridge/problem-en-2x.png?id=c67b62720e0465821bbcb84debbbaab0)

이러한 문제를 Shape와 Color를 분리해주는 Bridge Pattern을 활용해서 각 속성을 독립적으로 수정 / 확장할 수 있다

# Bridge Pattern 구조 이해하기

![UML](https://user-images.githubusercontent.com/73867548/155070955-8ac1b265-8739-4739-bf68-0607cc3e7e3b.png)

## Abstraction

* Client가 사용하는 최상위 타입
* Implementation을 참조
* Implementation에게 일을 위임
* Refined Abstraction로 Abstraction을 확장할 수 있다

## Implementation

* Abstraction의 기능을 구현하기 위해 인터페이스 정의
* Concrete Implementation는 Implementation을 채택해 실제 기능을 구현한 객체 타입이다

# Swift로 Bridge Pattern 구현하기

![SwiftUML](https://user-images.githubusercontent.com/73867548/155070983-30008e3d-b91d-4144-bbd9-22ba02ce079a.png)

![Swift](https://user-images.githubusercontent.com/73867548/155071059-551a9040-01e2-44b6-b4a6-c25da27ee4b6.png)

## RemoteControl (Abstraction)
* 실제 Client가 사용하는 최상위 타입
* Implementation을 참조하고 일을 위임
* RemoteControl을 상속받아 추가 기능을 지닌 다양한 리모콘들로 확장할 수 있다
* RemoteControl을 상속한 AdvancedRemoteControl은 mute()라는 추가 기능을 가진다

## Device (Implementation)
* Abstraction의 기능을 구현하기 위해 인터페이스 정의
* Device를 채택한 TV와 Radio 구체 타입들이 존재

## Protocol과 struct로 구현하기

![swiftStruct](https://user-images.githubusercontent.com/73867548/155071085-a74ee3a6-502d-452a-8690-c5e029782838.png)

* Swift에서는 class의 상속 대신 protocol과 struct를 사용해 Abstraction과 Refined Abstraction을 구현할 수도 있다

# Summary

* 종류가 다양한 속성들을 지닌 타입을 분리해 **독립적인 수정/확장**을 할 때 사용한다
	* OCP(Open-Closed Principle)를 만족한다
	* SRP(Single Responsibility Principle)를 만족한다
* Abstraction은 Implementation을 참조로 지니고 모든 일을 위임한다
	* Client는 최상위 타입 Abstraction의 로직만 사용하기 때문에 Implementation 로직을 몰라도 된다
* 다만 결합도가 높은 클래스에 적용할 경우 분리하기 힘들거나 타입이 많아져 오히려 코드가 더 복잡해질 가능이 존재한다
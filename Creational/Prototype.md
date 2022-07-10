# Prototype Pattern 이란?

[위키피디아](https://ko.wikipedia.org/wiki/프로토타입_패턴)에 따르면...


> 프로토타입 패턴(prototype pattern)은 소프트웨어 디자인 패턴 용어로, 생성할 객체들의 타입이 프로토타입인 인스턴스로부터 결정되도록 하며, 인스턴스는 새 객체를 만들기 위해 자신을 복제(clone)하게 된다.
> 
> * 프로토타입 패턴은, 추상 팩토리 패턴과는 반대로, 클라이언트 응용 프로그램 코드 내에서 객체 창조자(creator)를 서브클래스(subclass)하는 것을 피할 수 있게 해준다.
> * 프로토타입 패턴은 새로운 객체는 일반적인 방법(예를 들어, new를 사용해서라든지)으로 객체를 생성(create)하는 고유의 비용이 주어진 응용 프로그램 상황에 있어서 불가피하게 매우 클 때, 이 비용을 감내하지 않을 수 있게 해준다.

프로토타입 패턴은 기존의 객체를 **복제**하기 위한 패턴입니다

자기 자신을 복제하는 패턴이죠

프로토타입 패턴을 사용하면 간단하게 자시 자신을 그대로 복제할 수 있습니다

## 주요 객체 살펴보기

![image](https://user-images.githubusercontent.com/73867548/159225403-d61cb076-6529-4af3-a1a5-49be3986f23a.jpg)

UML을 살펴보면

코드 구조를 패턴화하기 위해서 interface를 정의하곤 하는데

interface를 굳이 사용하지 않고 자기 자신을 반환하는 메소드는 만드는 경우도 많습니다

그렇다면 Swfit에서 구현한 코드를 살펴보시죠

## Swift로 Prototype Pattern 구현하기

```swift
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
```

`clone()` 이라는 메소드를 통해서 타입을 복제하여 초기화해주고 있다

직접 초기화를 해주는 방법도 있지만 패턴을 사용해서 재사용성을 높여주고 있는 모습입니다
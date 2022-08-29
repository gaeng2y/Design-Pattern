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

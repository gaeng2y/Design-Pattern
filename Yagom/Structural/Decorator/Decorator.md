# Decorator 패턴이란?

오늘도 역시 [위키백과](https://developer.apple.com/forums/thread/83526)에 따르면

> 주어진 상황 및 용도에 따라 어떤 객체에 책임을 덧붙이는 패턴으로, 기능 확장이 필요할 때 서브클래싱 대신 쓸 수 있는 유연한 대안이 될 수 있다

라고합니다

Decorator Pattern은 자기자신을 다시 자기자신으로 감싸면서(wrap) 큰 블록을 만들어나가는 패턴이다

그리고 이러한 과정을 통해 문제를 해결하게 된다

작은 블록을 다시 작은 블록으로 감싸는 특징 때문에 Wrapper Pattern이라고도 한다

또 작은 블록으로 큰 블록을 만들어 나간다는 점에서, Structual pattern 중 하나이기도 하다

# 문제를 위한 예시

SNS를 개발 중, 이에 따라 텍스트, 이미지, 비디오를 서버에 전송할 필요가 생겼다

이것들을 각각의 API로 분리해서 제공할 계획이다

그래서 우리는 이 기능을 잘 추상화하여, 서버에 전송하기 전에 준비 빛 설정을 하는 타입을 만들기로 했다

그리고 이 타입을 상속받아 실제로 텍스트, 이미지, 비디오를 전송하게 만들었다

```swift
class Uploader {
    private func setUp() {
        /*...*/
    }

    func upload() {
        setUp()
    }
}

class TextUploader: Uploader {
    override func upload() {
        super.upload()
        print("uploading text")
    }
}

class ImageUploader: Uploader {
    override func upload() {
        super.upload()
        print("uploading image")
    }
}

class VideoUploader: Uploader {
    override func upload() {
        super.upload()
        print("uploading video")
    }
}
```

![UML](https://user-images.githubusercontent.com/73867548/155098494-14ebbb9a-01ce-41ea-8361-e6b058215768.png)

버그가 하나도 없이 개발했는데...

시간이 지나고, 유저의 피드백이 오기 시작했다.

하나의 이슈가 생겼는데 동작이 완벽했지만 사람들이 불편해했다

텍스트든 이미지든 비디오든, 한번에 한 종류만 올릴 수 있었기 때문에 SNS에는 맞지 않았다

사람들은 자신이 찍은 아름다운 사진에 대해서 짤막한 글귀를 남기고 싶어했고, 감동적인 비디오에 대해서는 주변 사람들과 공유하며 이야기를 나누고 싶었다

그래서 새로운 타입을 만들었다

```swift
class VideoAndTextUploader: VideoUploader {
    override func upload() {
        super.upload()
        print("uploading text")
    }
}

class ImageAndTextUploader: ImageUploader {
    override func upload() {
        super.upload()
        print("uploading text")
    }
}
```

자 이제 해결했다

근데... 이슈가 더 생긴다면?

일단 상속을 통해서 문제를 해결하기에는 똑같은 기능이 이곳저곳에서 중복되게 정의가 될 것 같다

그렇다고 완전히 새로운 타입을 정의하자니 Uploader의 자식이 너무 많아져서 관리가 힘들 것 같고...

그렇다면 어떻게 해결하는게 좋을까?

# Decorator Pattern으로 해결하기

위 상황의 문제를 Decorator Pattern으로 해결해보자

작은 블록으로 큰 블록을 만들어 나갈 것이고 이를 통해 문제를 해결해 나갈 것이다

```swift
class Uploader {
    private func setUp() {
        /*...*/
  }

  func upload() {
    setUp()
  }
}

class DecoratedUploader: Uploader {
  var uploader: Uploader?

    init(_ uploader: Uploader? = nil) {
    self.uploader = uploader
  }

  override func upload() {
    super.upload()
    uploader?.upload()
  }
}
```

먼저 Uploader를 상속받는 DecoratedUploader라는 클래스를 정의했다

DecoratedUploader는 프로퍼티로 옵셔널인 업로더 타입을 가지고 있다

즉 DecoratedUploader는 그 자체로 하나의 Uploader이면서, 내부에 Uploader를 가질 수 있게 되는 것이다

자기 자신을 랩핑해나가는 블록이다

```swift
class TextUploader: DecoratedUploader {
    override func upload() {
        super.upload()
        print("uploading text")
    }
}

class ImageUploader: DecoratedUploader {
    override func upload() {
        super.upload()
        print("uploading image")
    }
}

class VideoUploader: DecoratedUploader {
    override func upload() {
        super.upload()
        print("uploading video")
    }
}

class FileUploader: DecoratedUploader {
    override func upload() {
        super.upload()
        print("uploading file")
    }
}

let textAndImageAndVideoUploader = TextUploader(ImageUploader(VideoUploader()))
let imageAndVideoUploader = ImageUploader(VideoUploader())
let everythingUplodaer = TextUploader(ImageUploader(VideoUploader(FileUploader())))
```

![decorator](https://user-images.githubusercontent.com/73867548/155098044-b1c614cc-0470-4f31-b50d-1d348aa09b03.png)

이렇게 함으로써 새로운 타입을 정의할 필요는 없어지고 인스턴스의 조합으로 문제를 해결해나갈 수 있을 것이다

# 정리(+ 장점과 단점)

위에서 제시한 문제를 분해해보자

1. 자식클래스는 하나의 부모클래스(S)만 상속받을 수 있다
2. 때문에 형제관계인 클래스(A, B)가 가지고 있는 코드를 모두 필요로할 때, 이 둘을 모두 상속받는 타입을 정의할 수는 없다
	* 때문에 어느 한 쪽(A||B)을 상속을 받는 타입을 정의를 한 뒤, 다른 형제 타입의 코드(B||A)를 중복으로 정의하거나
	* 아예 S로부터 A와 B에 대한 기능을 모두 중복으로 정의하는 C를 정의해야 한다

이러한 상속의 문제를 해결하기 위한 아이디어가 **Decorator pateern**이다

Decorator pattern이 특정 상황을 효율적으로 풀어낼 수 있음은 분명하나 애플에서는 적극적으로 활용하지 않는다

왜냐하면 Swift는 POP를 통해 기능의 수평확장을 이미 언어에서부터 지원하고 있기 때문이다

또한 Decorator pattern은 랩핑을 하는 과정이 반드시 필요하기 때문에, 랩핑에 대한 오버헤드가 발생하게 되며 사람도 이것을 어떻게 랩핑하고 관리할 것이지 생각을 해야하고, 컴퓨터도 랩핑을 하면서 시간과 메모리를 소비하기 때문이다

이는 결국 순열과 조합의 문제로 이어질 수 있다

즉, 작은 블록들을 어떻게 뽑아서 큰 블록을 만들지를 미리 정의해놓는 아이디어가 필요하다는 것이다

하지만 이렇게 Swift의 특징과, 수학적인 사고력이 어느 정도 필요함에도 불구하고 Decorator Pattern은 불가피하게 생성할 수 밖에 없는 class 타입과 이에 대한 서브클래스들을 쉽게 관리할 수 있는 아이디어이기 때문에 중요할 수 있곘다

간단하게 상속에 대한 문제는 Decorator를 통해 해결할 수 있겠구나 정도로 기억하면 좋을 것 같다

## Reference

[Refactoring GURU](https://refactoring.guru/design-patterns/decorator)

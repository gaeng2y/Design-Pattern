import UIKit

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

// ------------------------------- GURU Exmaple --------------------------------
import XCTest

/// The Facade class provides a simple interface to the complex logic of one or
/// several subsystems. The Facade delegates the client requests to the
/// appropriate objects within the subsystem. The Facade is also responsible for
/// managing their lifecycle. All of this shields the client from the undesired
/// complexity of the subsystem.
class Facade {

    private var subsystem1: Subsystem1
    private var subsystem2: Subsystem2

    /// Depending on your application's needs, you can provide the Facade with
    /// existing subsystem objects or force the Facade to create them on its
    /// own.
    init(subsystem1: Subsystem1 = Subsystem1(),
         subsystem2: Subsystem2 = Subsystem2()) {
        self.subsystem1 = subsystem1
        self.subsystem2 = subsystem2
    }

    /// The Facade's methods are convenient shortcuts to the sophisticated
    /// functionality of the subsystems. However, clients get only to a fraction
    /// of a subsystem's capabilities.
    func operation() -> String {

        var result = "Facade initializes subsystems:"
        result += " " + subsystem1.operation1()
        result += " " + subsystem2.operation1()
        result += "\n" + "Facade orders subsystems to perform the action:\n"
        result += " " + subsystem1.operationN()
        result += " " + subsystem2.operationZ()
        return result
    }
}

/// The Subsystem can accept requests either from the facade or client directly.
/// In any case, to the Subsystem, the Facade is yet another client, and it's
/// not a part of the Subsystem.
class Subsystem1 {

    func operation1() -> String {
        return "Sybsystem1: Ready!\n"
    }

    // ...

    func operationN() -> String {
        return "Sybsystem1: Go!\n"
    }
}

/// Some facades can work with multiple subsystems at the same time.
class Subsystem2 {

    func operation1() -> String {
        return "Sybsystem2: Get ready!\n"
    }

    // ...

    func operationZ() -> String {
        return "Sybsystem2: Fire!\n"
    }
}

/// The client code works with complex subsystems through a simple interface
/// provided by the Facade. When a facade manages the lifecycle of the
/// subsystem, the client might not even know about the existence of the
/// subsystem. This approach lets you keep the complexity under control.
class Client {
    // ...
    static func clientCode(facade: Facade) {
        print(facade.operation())
    }
    // ...
}

/// Let's see how it all works together.
class FacadeConceptual: XCTestCase {

    func testFacadeConceptual() {

        /// The client code may have some of the subsystem's objects already
        /// created. In this case, it might be worthwhile to initialize the
        /// Facade with these objects instead of letting the Facade create new
        /// instances.

        let subsystem1 = Subsystem1()
        let subsystem2 = Subsystem2()
        let facade = Facade(subsystem1: subsystem1, subsystem2: subsystem2)
        Client.clientCode(facade: facade)
    }
}

/* ----------------------------------------- Output
Facade initializes subsystems: Sybsystem1: Ready!
Sybsystem2: Get ready!

Facade orders subsystems to perform the action:
Sybsystem1: Go!
Sybsystem2: Fire!
 
 */

/// ------------------------------- Real Exmaple
/// Facade Design Pattern
///
/// Intent: Provides a simplified interface to a library, a framework, or any
/// other complex set of classes.

class FacadeRealWorld: XCTestCase {

    /// In the real project, you probably will use third-party libraries. For
    /// instance, to download images.
    ///
    /// Therefore, facade and wrapping it is a good way to use a third party API
    /// in the client code. Even if it is your own library that is connected to
    /// a project.
    ///
    /// The benefits here are:
    ///
    /// 1) If you need to change a current image downloader it should be done
    /// only in the one place of a project. A number of lines of the client code
    /// will stay work.
    ///
    /// 2) The facade provides an access to a fraction of a functionality that
    /// fits most client needs. Moreover, it can set frequently used or default
    /// parameters.

    func testFacedeRealWorld() {

        let imageView = UIImageView()

        print("Let's set an image for the image view")

        clientCode(imageView)

        print("Image has been set")

        XCTAssert(imageView.image != nil)
    }

    fileprivate func clientCode(_ imageView: UIImageView) {

        let url = URL(string: "www.example.com/logo")
        imageView.downloadImage(at: url)
    }
}

private extension UIImageView {

    /// This extension plays a facede role.

    func downloadImage(at url: URL?) {

        print("Start downloading...")

        let placeholder = UIImage(named: "placeholder")

        ImageDownloader().loadImage(at: url,
                                    placeholder: placeholder,
                                    completion: { image, error in
            print("Handle an image...")

            /// Crop, cache, apply filters, whatever...

            self.image = image
        })
    }
}

private class ImageDownloader {

    /// Third party library or your own solution (subsystem)

    typealias Completion = (UIImage, Error?) -> ()
    typealias Progress = (Int, Int) -> ()

    func loadImage(at url: URL?,
                   placeholder: UIImage? = nil,
                   progress: Progress? = nil,
                   completion: Completion) {
        /// ... Set up a network stack
        /// ... Downloading an image
        /// ...
        completion(UIImage(), nil)
    }
}

/*
 Let's set an image for the image view
 Start downloading...
 Handle an image...
 Image has been set
 */

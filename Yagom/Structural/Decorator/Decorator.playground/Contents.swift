import UIKit

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

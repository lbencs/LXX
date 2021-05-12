import UIKit

class SomeBaseClass {

    func test() {
        print("self => \(self)")
        print("Self.self => \(Self.self)")
        print("DemoObject.Type.self => \(SomeBaseClass.Type.self)")
        print("Self.Type.self => \(Self.Type.self)")
    }

    static func test() {
        print("self => \(self)")
        print("self => \(Self.Type.self)")
    }
}

class SomeSubClass: SomeBaseClass {
    let stringValue: String
    required init(value: String) {
        stringValue = value
    }
}

func test() {
    // Int.Type => 元类型
    // Int.self => 元类型的值
    let intMetatype: Int.Type = Int.self
    print(intMetatype)

    Float.pi
    Float.self.pi

    print(type(of: SomeBaseClass.self))
    print(type(of: SomeBaseClass()))

    let demoObjectTypeType = type(of: SomeBaseClass.self)
    let demoObjectType: SomeBaseClass.Type = type(of: SomeBaseClass())
    let stringType: String.Type = type(of: "string")
    let stringTypeType = type(of: String.self)
    
    let b = UITableViewDataSource.self
    let a = UITableViewDataSource.Type.self
    let c = UITableViewDataSource.Protocol.self
    let d = UITableViewDataSource.Protocol.Type.self
    
    type(of: SomeBaseClass())
    
    let _: AnyClass = SomeBaseClass.self
    
    let metaType = SomeSubClass.self
    let anthorMetaType = type(of: SomeSubClass(value: "a"))
    
}

test()
SomeBaseClass().test()
SomeBaseClass.test()

import UIKit

var str = "Hello, playground"

@dynamicMemberLookup
struct DynamicStruct {
    let dictionary = [
        "someDynamicMember": 325,
        "someOtherMember": 787,
        "someTestMember": 198
    ]
    subscript(dynamicMember member: String) -> Int {
        return dictionary[member] ?? 1054
    }
}

let s = DynamicStruct()

// Using dynamic member lookup
let dynamic = s.someDynamicMember
print(dynamic)
// Prints "325"

// Calling the underlying subscript directly
let equivalent = s[dynamicMember: "someDynamicMember"]
print(dynamic == equivalent)
// Prints "true"

print(s.someTestMember)

var mutableArray = [1,2,3]
for _ in mutableArray {
    mutableArray.removeLast()
}
print(mutableArray)

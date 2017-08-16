import XCTest
@testable import SwiftCodeWriter
import CodeWriter

class ClassWriterTests: XCTestCase {

    func testWriteEmptyClass() {
        let classDescription = ClassDescription(name: "Sample")
        XCTAssertEqual("class Sample {\n}", ClassWriter.default.write(description: classDescription))
    }

    func testWriteEmptyPublicClassWithExtends() {
        let classDescription = ClassDescription(name: "Sample", options: .init(visibility: .public), parent: "MySuperClass")
        XCTAssertEqual("public class Sample: MySuperClass {\n}", ClassWriter.default.write(description: classDescription))
    }

    func testWriteEmptyClassWithExtendsAnd2Implements() {
        var classDescription = ClassDescription(name: "Sample", parent: "MySuperClass")
        classDescription.implements.append("ITest")
        classDescription.implements.append("ITest2")
        XCTAssertEqual("class Sample: MySuperClass, ITest, ITest2 {\n}", ClassWriter.default.write(description: classDescription))
    }

    func testWriteEmptyClassWithImplementsOnly() {
        var classDescription = ClassDescription(name: "Sample")
        classDescription.implements.append("ITest")
        XCTAssertEqual("class Sample: ITest {\n}", ClassWriter.default.write(description: classDescription))
    }

    func testWriteClassWith2Properties() {
        var classDescription = ClassDescription(name: "Sample")
        classDescription.properties.append(PropertyDescription(name: "hello", type: "String?"))
        classDescription.properties.append(PropertyDescription(name: "other", type: "Int", documentation: "required property !"))
        XCTAssertEqual("class Sample {\n\tvar hello: String?\n\t// required property !\n\tvar other: Int\n}", ClassWriter.default.write(description: classDescription))
    }

    func testWriteClassWithAttributes() {
        var classDescription = ClassDescription(name: "Sample")
        classDescription.attributes.append("@available(iOS 10.0, macOS 10.12, *)")
        XCTAssertEqual("@available(iOS 10.0, macOS 10.12, *)\nclass Sample {\n}", ClassWriter.default.write(description: classDescription))
    }

    func testWriteClassWithPropertyAndMethods() {
        var classDescription = ClassDescription(name: "Sample")
        classDescription.properties.append(PropertyDescription(name: "hello", type: "String?"))
        classDescription.methods.append(MethodDescription(name: "test", code: CodeBuilder()))
        classDescription.methods.append(MethodDescription(name: "test2", code: CodeBuilder()))
        XCTAssertEqual("class Sample {\n\tvar hello: String?\n\n\tfunc test() {\n\t}\n\n\tfunc test2() {\n\t}\n}", ClassWriter.default.write(description: classDescription))
    }
    
    static var allTests = [
        ("testWriteEmptyClass", testWriteEmptyClass),
        ("testWriteEmptyPublicClassWithExtends", testWriteEmptyPublicClassWithExtends),
        ("testWriteEmptyClassWithExtendsAnd2Implements", testWriteEmptyClassWithExtendsAnd2Implements),
        ("testWriteEmptyClassWithImplementsOnly", testWriteEmptyClassWithImplementsOnly),
        ("testWriteClassWith2Propperties", testWriteClassWith2Properties),
        ("testWriteClassWithAttributes", testWriteClassWithAttributes),
        ("testWriteClassWithPropertyAndMethods", testWriteClassWithPropertyAndMethods),
    ]
}

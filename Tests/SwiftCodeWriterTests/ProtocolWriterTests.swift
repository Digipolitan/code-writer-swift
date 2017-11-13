import XCTest
@testable import SwiftCodeWriter

class ProtocolWriterTests: XCTestCase {

    func testWriteEmptyProtocolWithDocumentation() {
        let protocolDescription = ProtocolDescription(name: "Sample", documentation: "MySampleProtocol")
        XCTAssertEqual("/**\n * MySampleProtocol\n */\nprotocol Sample {\n}", ProtocolWriter.default.write(description: protocolDescription))
    }

    func testWriteEmptyPublicProtocolWith2Implements() {
        var protocolDescription = ProtocolDescription(name: "Sample", options: .init(visibility: .public))
        protocolDescription.implements.append("ITest")
        protocolDescription.implements.append("ITest2")
        XCTAssertEqual("public protocol Sample: ITest, ITest2 {\n}", ProtocolWriter.default.write(description: protocolDescription))
    }

    func testWriteEmptyProtocolWithImplementsOnly() {
        var protocolDescription = ProtocolDescription(name: "Sample")
        protocolDescription.implements.append("ITest")
        XCTAssertEqual("protocol Sample: ITest {\n}", ProtocolWriter.default.write(description: protocolDescription))
    }

    func testWriteProtocolWith2Properties() {
        var protocolDescription = ProtocolDescription(name: "Sample")
        protocolDescription.properties.append(PropertyDescription(name: "hello", type: "String?"))
        protocolDescription.properties.append(PropertyDescription(name: "other", options: .init(setVisibility: .private), type: "Int", documentation: "required property !"))
        XCTAssertEqual("protocol Sample {\n    var hello: String? { get set }\n    // required property !\n    var other: Int { get }\n}",
                       ProtocolWriter.default.write(description: protocolDescription))
    }

    func testWriteProtocolWithAttributes() {
        var protocolDescription = ProtocolDescription(name: "Sample")
        protocolDescription.attributes.append("@available(iOS 10.0, macOS 10.12, *)")
        XCTAssertEqual("@available(iOS 10.0, macOS 10.12, *)\nprotocol Sample {\n}", ProtocolWriter.default.write(description: protocolDescription))
    }

    func testWriteProtocolWithPropertyAndMethods() {
        var protocolDescription = ProtocolDescription(name: "Sample")
        protocolDescription.properties.append(PropertyDescription(name: "hello", type: "String?"))
        protocolDescription.methods.append(MethodDescription(name: "test"))
        protocolDescription.methods.append(MethodDescription(name: "test2"))
        XCTAssertEqual("protocol Sample {\n    var hello: String? { get set }\n\n    func test()\n\n    func test2()\n}", ProtocolWriter.default.write(description: protocolDescription))
    }

    static var allTests = [
        ("testWriteEmptyProtocolWithDocumentation", testWriteEmptyProtocolWithDocumentation),
        ("testWriteEmptyPublicProtocolWith2Implements", testWriteEmptyPublicProtocolWith2Implements),
        ("testWriteEmptyProtocolWithImplementsOnly", testWriteEmptyProtocolWithImplementsOnly),
        ("testWriteProtocolWith2Properties", testWriteProtocolWith2Properties),
        ("testWriteProtocolWithAttributes", testWriteProtocolWithAttributes)
    ]
}

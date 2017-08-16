//
//  ExtensionDescription.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation

public struct ExtensionDescription {

    public struct Options {
        public let visibility: Visibility

        public init(visiblity: Visibility = .default) {
            self.visibility = visiblity
        }
    }

    public let target: String
    public let options: Options
    public var modules: [String]
    public var implements: [String]
    public var initializers: [InitializerDescription]
    public var methods: [MethodDescription]
    public var properties: [PropertyDescription]
    public let documentation: String?

    public init(target: String, options: Options = Options(), modules: [String] = [], documentation: String? = nil) {
        self.target = target
        self.options = options
        self.modules = modules
        self.documentation = documentation
        self.implements = []
        self.initializers = []
        self.methods = []
        self.properties = []
    }

    public func moduleDependencies() -> [String] {
        var modules = Set<String>()
        modules.formUnion(self.modules)
        for initializer in self.initializers {
            modules.formUnion(initializer.modules)
        }
        for method in self.methods {
            modules.formUnion(method.modules)
        }
        for property in self.properties {
            if let module = property.module {
                modules.insert(module)
            }
        }
        return Array(modules)
    }
}

//
//  CostumeEnvironment.swift
//  CostumeKit
//
//  SwiftUI environment integration for costumes/themes.
//

import SwiftUI

// MARK: - Type-Erased Costume Wrapper

/// A type-erased wrapper for costumes to allow storage in SwiftUI environment.
public struct AnyCostume: @unchecked Sendable {
    private let _name: @Sendable () -> String
    private let _description: @Sendable () -> String
    private let _underlying: Any

    /// Creates a type-erased costume wrapper.
    public init<C: Costume>(_ costume: C) {
        self._name = { costume.name }
        self._description = { costume.description }
        self._underlying = costume
    }

    /// The costume's name.
    public var name: String { _name() }

    /// The costume's description.
    public var description: String { _description() }

    /// Attempts to cast the underlying costume to a specific type.
    public func `as`<C: Costume>(_ type: C.Type) -> C? {
        _underlying as? C
    }
}

// MARK: - Environment Key

private struct CostumeEnvironmentKey: EnvironmentKey {
    static let defaultValue: AnyCostume? = nil
}

extension EnvironmentValues {
    /// The current costume in the environment.
    ///
    /// Usage:
    /// ```swift
    /// struct ContentView: View {
    ///     @Environment(\.costume) var costume
    ///
    ///     var body: some View {
    ///         if let myCostume = costume?.as(MyAppCostume.self) {
    ///             Text("Theme: \(myCostume.name)")
    ///         }
    ///     }
    /// }
    /// ```
    public var costume: AnyCostume? {
        get { self[CostumeEnvironmentKey.self] }
        set { self[CostumeEnvironmentKey.self] = newValue }
    }
}

// MARK: - View Extension

extension View {
    /// Sets the costume (theme) for this view and its descendants.
    ///
    /// Usage:
    /// ```swift
    /// ContentView()
    ///     .costume(MyAppCostume())
    /// ```
    public func costume<C: Costume>(_ costume: C) -> some View {
        environment(\.costume, AnyCostume(costume))
    }
}

// MARK: - Typed Costume Access

extension View {
    /// Reads a specific costume type from the environment and provides it to a view builder.
    ///
    /// Usage:
    /// ```swift
    /// Text("Hello")
    ///     .withCostume(MyAppCostume.self) { costume in
    ///         Text("Theme: \(costume?.name ?? "None")")
    ///     }
    /// ```
    public func withCostume<C: Costume, Content: View>(
        _ type: C.Type,
        @ViewBuilder content: @escaping (C?) -> Content
    ) -> some View {
        modifier(CostumeReaderModifier(costumeType: type, content: content))
    }
}

private struct CostumeReaderModifier<C: Costume, Content: View>: ViewModifier {
    let costumeType: C.Type
    let content: (C?) -> Content

    @Environment(\.costume) private var anyCostume

    func body(content: Self.Content) -> some View {
        self.content(anyCostume?.as(costumeType))
    }
}

import SwiftUI

@Observable
public final class CSLPresenter<T: Identifiable> {
    
    // MARK: - Static Properties
    
    public static var emptyModel: CSLPresenter<CSLAnyIdentifiable> { .init(model: .init()) }
    
    // MARK: - Observable
    
    public var model: T?
    public var isPresented: Bool
    
    // MARK: - Initialization
    
    public init(model: T? = nil) {
        self.model = model
        
        isPresented = false
    }

    // MARK: - Public Functions
    
    public func present() { isPresented = true } 
}

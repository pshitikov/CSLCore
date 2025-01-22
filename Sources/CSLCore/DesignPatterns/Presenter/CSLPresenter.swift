import SwiftUI

@Observable
public final class CSLPresenter<T: Identifiable> {
    
    var model: T?
    var isPresented = false
}

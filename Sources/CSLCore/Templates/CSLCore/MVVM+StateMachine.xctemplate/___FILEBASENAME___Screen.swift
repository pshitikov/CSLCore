import SwiftUI

struct ___VARIABLE_NAME___Screen: View { // swiftlint:disable:this type_name
    
    // MARK: - Enums
    
    private enum Values {
        
        static let screenTitle = "Title"
    }
    
    // MARK: - Properties
    
    @State
    private var screenModel: ScreenModel
    
    // MARK: - Initialization
    
    init(screenModel: ScreenModel) { _screenModel = State(initialValue: screenModel) }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            contentView
                .onAppear { screenModel.send(event: .onAppearScreen) }
                .navigationTitle(Values.screenTitle)
        }
    }
}

// MARK: - Views

extension ___VARIABLE_NAME___Screen {
    
    private var contentView: some View {
        Group {
            switch screenModel.state {
            case .initial: CSLEmptyListView()
            case .loading: CSLProgressView()
            case .data: listView
            }
        }
    }
    
    private var listView: some View {
        List {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
    }
}

// MARK: - Screens

extension ___VARIABLE_NAME___Screen { }

// MARK: - Previews

#Preview { ___VARIABLE_NAME___Screen(screenModel: .init()) }

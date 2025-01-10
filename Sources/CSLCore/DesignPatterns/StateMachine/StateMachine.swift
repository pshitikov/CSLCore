import SwiftUI

/// A behavioral design pattern implementation of `StateMachine`.
///
/// This class is used in scenarios where an object needs to change its behavior based on its state during the program's execution.
/// It allows transitions between states triggered by incoming events.
@Observable
open class StateMachine<State, Event>: NSObject, StateMachineProtocol where State: Equatable {
    
    // MARK: - Properties
    
    /// The current state of the state machine.
    ///
    /// This property is updated whenever a state transition occurs.
    /// The `leaveState(_:)` method is called before the current state is updated,
    /// and the `enterState(_:)` and `handleStateUpdate(_:new:)` methods are invoked for the new state.
    public private(set) var state: State {
        willSet { leaveState(state) }
        
        didSet {
            enterState(state)
            handleStateUpdate(oldValue, new: state)
        }
    }
    
    // MARK: - Initialization
    
    /// Initializes a new instance of the `StateMachine` with an initial state.
    ///
    /// - Parameter initialState: The initial state of the state machine.
    public init(_ initialState: State) { state = initialState }
    
    // MARK: - Open Functions
    
    /// Processes an incoming event and determines the next state.
    ///
    /// Subclasses must override this method to handle events and define state transitions.
    /// If no state transition is needed, return `nil`.
    ///
    /// - Parameter event: The event that triggers the state transition.
    /// - Returns: The next state, or `nil` if no transition is required.
    open func handleEvent(_ event: Event) -> State? { fatalError("Override handleEvent(_:)") }
    
    /// Handles updates when the state changes.
    ///
    /// Subclasses can override this method to add custom behavior when the state transitions.
    ///
    /// - Parameters:
    ///   - oldState: The state before the transition.
    ///   - newState: The state after the transition.
    open func handleStateUpdate(_ oldState: State, new newState: State) { /* Default implementation */ }
    
    /// Sends an event to the state machine, potentially triggering a state transition.
    ///
    /// This method calls `handleEvent(_:)` to determine the next state.
    /// If a new state is returned, the `state` property is updated.
    ///
    /// - Parameter event: The event to process.
    open func send(event: Event) {
        guard let state = handleEvent(event) else { return }
        
        self.state = state
    }
    
    /// Handles logic when leaving a state.
    ///
    /// Subclasses can override this method to define specific behavior
    /// that should occur before transitioning out of the current state.
    ///
    /// - Parameter state: The state being exited.
    open func leaveState(_ state: State) { /* Default implementation */ }
    
    /// Handles logic when entering a state.
    ///
    /// Subclasses can override this method to define specific behavior
    /// that should occur after transitioning into the new state.
    ///
    /// - Parameter state: The state being entered.
    open func enterState(_ state: State) { /* Default implementation */ }
}

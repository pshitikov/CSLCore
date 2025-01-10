import SwiftUI

/// A protocol that defines the structure for a state machine that manages
/// state transitions based on events.
///
/// The `StateMachineProtocol` is intended to be adopted by classes or structs that
/// implement state machines. It requires a state and event type, along with methods
/// for handling state updates and event processing.
public protocol StateMachineProtocol {
    
    // MARK: - Associated types
    
    /// The type representing the state of the state machine.
    ///
    /// This type must conform to `Equatable` so that state comparisons can be performed.
    associatedtype State: Equatable
    
    /// The type representing the events that trigger state transitions.
    associatedtype Event
    
    // MARK: - Properties
    
    /// The current state of the state machine.
    ///
    /// This property holds the state at any given point in time. It is updated
    /// when a transition occurs based on the processing of events.
    var state: State { get }
    
    // MARK: - Functions
    
    /// Handles updates when the state changes.
    ///
    /// This method is called whenever the state transitions. The `oldState` is the
    /// state before the transition, and `newState` is the state after the transition.
    /// Subclasses or conforming types can override this method to implement custom
    /// behavior during the state change.
    ///
    /// - Parameters:
    ///   - oldState: The state before the transition.
    ///   - newState: The state after the transition.
    func handleStateUpdate(_ oldState: State, new newState: State)
    
    /// Processes an incoming event and determines the next state.
    ///
    /// This method is called to handle events and define how the state machine
    /// transitions from the current state. It returns the next state or `nil` if
    /// no transition occurs.
    ///
    /// - Parameter event: The event that triggers the state transition.
    /// - Returns: The next state, or `nil` if no transition occurs.
    func handleEvent(_ event: Event) -> State?
    
    /// Sends an event to the state machine, potentially triggering a state transition.
    ///
    /// This method calls `handleEvent(_:)` to determine the next state. If a new state
    /// is returned, the state machine updates its `state` property.
    ///
    /// - Parameter event: The event to process.
    func send(event: Event)
    
    /// Handles logic when leaving a state.
    ///
    /// This method is called when the state machine transitions out of a given state.
    /// Subclasses or conforming types can override this method to implement custom
    /// behavior that should occur before exiting the state.
    ///
    /// - Parameter state: The state being exited.
    func leaveState(_ state: State)
    
    /// Handles logic when entering a state.
    ///
    /// This method is called when the state machine transitions into a given state.
    /// Subclasses or conforming types can override this method to implement custom
    /// behavior that should occur when entering the state.
    ///
    /// - Parameter state: The state being entered.
    func enterState(_ state: State)
}

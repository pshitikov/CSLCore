import Foundation

/// `MulticastDelegate` allows you to easily create a "multicast delegate" for a given protocol or class.
/// This version is thread-safe using DispatchQueue and barrier blocks for synchronization.
open class MulticastDelegate<T> {
    
    // MARK: - Properties
    
    /// The delegates hash table used to store the delegates.
    private let delegates: NSHashTable<AnyObject>
    
    /// A serial dispatch queue used to synchronize access to the delegates collection.
    private let queue = DispatchQueue(label: "MulticastDelegateSerialQueue")
    
    /// A Boolean value indicating whether the delegates collection is empty.
    ///
    /// - Returns: `true` if there are no delegates, `false` if there is at least one delegate.
    public var isEmpty: Bool { queue.sync { delegates.allObjects.isEmpty } }
    
    // MARK: - Initialization
    
    /// Initializes a new `MulticastDelegate` instance.
    ///
    /// - Parameter strongReferences: A Boolean value that determines whether delegates should be strongly referenced.
    ///   If `false`, delegates will be weakly referenced. The default value is `false`.
    public init(strongReferences: Bool = false) {
        delegates = strongReferences
        ? NSHashTable<AnyObject>()
        : NSHashTable<AnyObject>.weakObjects()
    }
    
    /// Initializes a new `MulticastDelegate` instance with custom storage options.
    ///
    /// - Parameter options: The storage options to use for the delegates hash table.
    public init(options: NSPointerFunctions.Options) {
        delegates = NSHashTable<AnyObject>(options: options, capacity: 0)
    }
}

// MARK: - Public Methods

extension MulticastDelegate {
    
    /// Adds a delegate to the list of multicast delegates.
    ///
    /// - Parameter delegate: The delegate to be added.
    public func addDelegate(_ delegate: T) {
        queue.async(flags: .barrier) { [weak self] in
            guard let self else { return }
            
            self.delegates.add(delegate as AnyObject)
        }
    }
    
    /// Removes a previously added delegate.
    ///
    /// - Parameter delegate: The delegate to be removed.
    public func removeDelegate(_ delegate: T) {
        queue.async(flags: .barrier) { [weak self] in
            guard let self else { return }
            
            for currentDelegate in self.delegates.allObjects.reversed() where currentDelegate === delegate as AnyObject {
                self.delegates.remove(currentDelegate)
            }
        }
    }
    
    /// Removes all previously added delegates.
    public func removeAllDelegates() {
        queue.async(flags: .barrier) { [weak self] in
            guard let self else { return }
            
            self.delegates.removeAllObjects()
        }
    }
    
    /// Invokes a closure on each delegate in the multicast delegate list.
    ///
    /// - Parameter invocation: The closure to be invoked on each delegate. The closure will receive each delegate as its argument.
    public func invokeDelegates(_ invocation: (T) -> Void) {
        queue.sync { [weak self] in
            guard let self else { return }
            
            for delegate in self.delegates.allObjects.reversed() {
                guard let delegate = delegate as? T else { return }
                
                invocation(delegate)
            }
        }
    }
    
    /// Determines if the multicast delegate contains a specific delegate.
    ///
    /// - Parameter delegate: The delegate to check for in the multicast delegate list.
    /// - Returns: `true` if the delegate is found in the list, otherwise `false`.
    public func containsDelegate(_ delegate: T) -> Bool {
        queue.sync { [weak self] in
            guard let self else { return false }
            
            return self.delegates.contains(delegate as AnyObject)
        }
    }
}

import XCTest

final class ArrayExtensionTests: XCTestCase {

    func testRemoveElement() {
        var numbers = [1, 2, 3, 4, 5]
        
        // Test removing an existing element
        let removed = numbers.remove(element: 3)
        XCTAssertEqual(removed, 3, "Expected to remove element 3.")
        XCTAssertEqual(numbers, [1, 2, 4, 5], "Array should not contain the removed element.")
        
        // Test removing a non-existing element
        let nonExistentRemove = numbers.remove(element: 10)
        XCTAssertNil(nonExistentRemove, "Expected nil when removing an element that does not exist.")
        XCTAssertEqual(numbers, [1, 2, 4, 5], "Array should remain unchanged.")
        
        // Test removing the first element
        let firstRemoved = numbers.remove(element: 1)
        XCTAssertEqual(firstRemoved, 1, "Expected to remove the first element.")
        XCTAssertEqual(numbers, [2, 4, 5], "First element should be removed.")
        
        // Test removing the last element
        let lastRemoved = numbers.remove(element: 5)
        XCTAssertEqual(lastRemoved, 5, "Expected to remove the last element.")
        XCTAssertEqual(numbers, [2, 4], "Last element should be removed.")
    }
    
    func testPutElement() {
        var strings = ["Alice", "Bob", "Charlie"]
        
        // Test adding a new element
        strings.put(element: "Eve")
        XCTAssertEqual(strings, ["Alice", "Bob", "Charlie", "Eve"], "New element should be added at the end.")
        
        // Test replacing an existing element
        strings.put(element: "Bob")
        XCTAssertEqual(strings, ["Alice", "Bob", "Charlie", "Eve"], "Existing element should remain unchanged.")
        
        // Test adding another new element
        strings.put(element: "Dave")
        XCTAssertEqual(strings, ["Alice", "Bob", "Charlie", "Eve", "Dave"], "New element should be appended.")
    }
}

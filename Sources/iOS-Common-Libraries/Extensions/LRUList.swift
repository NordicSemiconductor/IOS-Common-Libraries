//
//  LRUList.swift
//  iOSCommonLibraries
//
//  Created by Sylwester Zielinski on 02/01/2026.
//

public final class LRUList<T> {
    
    private class Node {
        var value: T
        var next: Node?
        weak var prev: Node?
        
        init(value: T) {
            self.value = value
        }
    }
    
    private let capacity: Int
    private var count: Int = 0
    
    private var head: Node?
    private var tail: Node?
    
    init(capacity: Int) {
        self.capacity = max(1, capacity)
    }
    
    func add(_ value: T) {
        let newNode = Node(value: value)
        
        addToHead(newNode)
        
        if count < capacity {
            count += 1
        } else {
            removeTail()
        }
    }
    
    public var elements: [T] {
        var result: [T] = []
        result.reserveCapacity(capacity)
        var current = tail
        while let node = current {
            result.append(node.value)
            current = node.next
        }
        return result
    }

    private func addToHead(_ node: Node) {
        if let currentHead = head {
            node.prev = currentHead
            currentHead.next = node
            head = node
        } else {
            head = node
            tail = node
        }
    }
    
    private func removeTail() {
        guard let oldTail = tail else { return }
        
        if let newTail = oldTail.next {
            newTail.prev = nil
            tail = newTail
        } else {
            head = nil
            tail = nil
        }
        
        oldTail.next = nil
        oldTail.prev = nil
    }
}

//
//  Node.swift
//  GomobileIPFS
//
//  Created by Guilhem Fanton on 07/11/2019.
//

import Foundation
import Mobile

public enum NodeError: Error {
  case error(String)
  case runtimeError(Error, String)
}

public class Node {
    let node: MobileNodeProtocol

    public init(_ repo: Repo) throws {
        var err: NSError?
        
        if let node = MobileNewNode(repo.goRepo, &err) {
            self.node = node
        } else {
            throw RepoError.error("failed start node, unknow error")
        }
        
        if let error = err {
            throw NodeError.runtimeError(error, "failed to create node")
        }
    }
    
    public func close() throws{
        self.node.close()
    }
}

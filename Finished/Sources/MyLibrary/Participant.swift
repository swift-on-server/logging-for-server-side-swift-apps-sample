import Foundation
import Logging

public struct Participant: Hashable, Equatable {
    public let id: UUID
    public let name: String
    
    public init(
        id: UUID = .init(),
        name: String
    ) {
        self.id = id
        self.name = name
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

extension Participant {

    var loggerMetadata: Logger.Metadata {
        [
            "participant.id": "\(id)",
            "participant.name": "\(name)",
        ]
    }
}

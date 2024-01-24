import Foundation

public struct Meeting {

    let id: UUID
    private var participants: Set<Participant>
    private var isInProgress: Bool

    public init(
        id: UUID
    ) {
        self.id = id
        self.participants = .init()
        self.isInProgress = false
    }
    
    // MARK: -

    public mutating func add(_ participant: Participant) {
        if isInProgress {
            print("🤫✋ \(participant.name)")
        }
        
        guard !participants.contains(participant) else {
            return
        }

        participants.insert(participant)
    }
    
    public mutating func remove(_ participant: Participant) {
        if isInProgress {
            print("🤫👋 \(participant.name)")
        }
        guard participants.contains(participant) else {
            return
        }

        participants.remove(participant)
    }
    
    // MARK: -

    public mutating func start() {
        guard !isInProgress else {
            return
        }
        
        guard !participants.isEmpty else {
            return
        }
        isInProgress = true

        for participant in participants {
            print("✋ \(participant.name)")
        }
    }
    
    public mutating func end() {
        guard isInProgress else {
            return
        }

        for participant in participants {
            print("👋 \(participant.name)")
        }
        participants.removeAll()
    }
}

import Foundation

public struct Meeting {
    
    public enum Issue: Error, CustomDebugStringConvertible {
        case notEnoughParticipants

        public var debugDescription: String {
            switch self {
            case .notEnoughParticipants: "not enough participants"
            }
        }
    }

    let id: UUID
    private var participants: Set<Participant>
    private var isInProgress: Bool
    
    public var hasEnoughParticipants: Bool {
        participants.count > 1
    }

    public init(
        id: UUID
    ) {
        self.id = id
        self.participants = .init()
        self.isInProgress = false
    }
    
    func beSilentIfNeeded(_ participant: Participant) {
        guard isInProgress else {
            return
        }
        print("🤫 Please, be silent \(participant.name)!")
    }
    
    func greet(_ participant: Participant) {
        print("✋ Hello \(participant.name)!")
        beSilentIfNeeded(participant)
    }
    
    func bye(_ participant: Participant) {
        print("👋 Good bye \(participant.name)!")
        beSilentIfNeeded(participant)
    }
    
    func welcome(_ participant: Participant) {
        print("🙏 Welcome to the meeting \(participant.name)!")
    }
    
    func thankYou(_ participant: Participant) {
        print("✅ Thank you \(participant.name)!")
    }
    
    // MARK: -

    public mutating func add(_ participant: Participant) {
        if isInProgress {
            greet(participant)
        }
        if participants.contains(participant) {
            return
        }
        participants.insert(participant)
    }
    
    public mutating func remove(_ participant: Participant) {
        if isInProgress {
            bye(participant)
        }
        guard participants.contains(participant) else {
            return
        }
        participants.remove(participant)
    }
    
    // MARK: -

    public mutating func start() throws {
        if isInProgress {
            return
        }
        guard hasEnoughParticipants else {
            throw Meeting.Issue.notEnoughParticipants
        }
        isInProgress = true

        for participant in participants {
            welcome(participant)
        }
    }
    
    public mutating func end() {
        guard isInProgress else {
            return
        }
        for participant in participants {
            thankYou(participant)
        }
        participants.removeAll()
    }
}

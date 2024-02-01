import Foundation
import Logging

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
    private var logger: Logger

    public var hasEnoughParticipants: Bool {
        participants.count > 1
    }
    
    public init(
        id: UUID,
        logger: Logger = .init(label: "meeting-logger")
    ) {
        self.id = id
        self.participants = .init()
        self.isInProgress = false
        self.logger = logger
        self.logger[metadataKey: "meeting.id"] = "\(id)"
        
        self.logger.trace("meeting room is ready")
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
        logger.debug(
            "trying to add participant",
            metadata: participant.loggerMetadata
        )
        
        if isInProgress {
            greet(participant)
            logger.trace("meeting is in progress")
        }
        
        if participants.contains(participant) {
            logger.trace(
                "couldn't add participant, already there",
                metadata: participant.loggerMetadata
            )
            return
        }

        participants.insert(participant)

        logger.debug("participant added", metadata: [
            "participants": "\(participants.count)"
        ])
    }
    
    public mutating func remove(_ participant: Participant) {
        logger.debug(
            "trying to remove participant",
            metadata: participant.loggerMetadata
        )

        if isInProgress {
            bye(participant)
            logger.trace("meeting is in progress")
        }
        guard participants.contains(participant) else {
            logger.trace(
                "can't remove participant, not there",
                metadata: participant.loggerMetadata
            )
            return
        }

        participants.remove(participant)
        
        logger.debug("participant removed", metadata: [
            "participants": "\(participants.count)"
        ])
    }
    
    // MARK: -

    public mutating func start() throws {
        logger.debug("trying to start the meeting")
        
        if isInProgress {
            logger.trace("already in progress")
            return
        }

        guard hasEnoughParticipants else {
            throw Meeting.Issue.notEnoughParticipants
        }

        isInProgress = true

        for participant in participants {
            logger.trace("participating", metadata: participant.loggerMetadata)
            welcome(participant)
        }

        logger.debug("meeting started", metadata: [
            "participants.count": "\(participants.count)",
        ])
    }
    
    public mutating func end() {
        logger.debug("trying to end the meeting")
        
        guard isInProgress else {
            logger.trace("meeting is not in progress yet")
            return
        }

        for participant in participants {
            logger.trace(
                "saying goodbye to participant",
                metadata: participant.loggerMetadata
            )
            thankYou(participant)
        }
        participants.removeAll()

        logger.debug("meeting finished")
    }
}

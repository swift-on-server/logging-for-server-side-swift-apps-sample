import Foundation
import Logging

public struct Meeting {

    let id: UUID
    private var participants: Set<Participant>
    private var isInProgress: Bool
    private var logger: Logger

    public init(
        id: UUID,
        logger: Logger
    ) {
        self.id = id
        self.participants = .init()
        self.isInProgress = false
        self.logger = logger
        self.logger[metadataKey: "meeting.id"] = "\(id)"
        
        self.logger.trace("meeting room is ready")
    }
    
    // MARK: -

    public mutating func add(_ participant: Participant) {
        logger.debug("trying to add participant", metadata: [
            "participant.id": "\(participant.id)",
            "participant.name": "\(participant.name)",
        ])
        
        if isInProgress {
            print("🤫✋ \(participant.name)")
            logger.notice("meeting is in progress")
        }
        
        guard !participants.contains(participant) else {
            logger.warning("couldn't add participant, already there", metadata: [
                "participant.id": "\(participant.id)",
                "participant.name": "\(participant.name)",
            ])
            return
        }

        participants.insert(participant)

        logger.debug("participant added", metadata: [
            "participant.id": "\(participant.id)",
            "participant.name": "\(participant.name)",
            "participants.count": "\(participants.count)",
        ])
    }
    
    public mutating func remove(_ participant: Participant) {
        logger.debug("trying to remove participant", metadata: [
            "participant.id": "\(participant.id)",
            "participant.name": "\(participant.name)",
        ])

        if isInProgress {
            print("🤫👋 \(participant.name)")
            logger.notice("meeting is in progress")
        }
        guard participants.contains(participant) else {
            logger.warning("can't remove participant, not there", metadata: [
                "participant.id": "\(participant.id)",
                "participant.name": "\(participant.name)",
            ])
            return
        }

        participants.remove(participant)
        logger.debug("participant removed", metadata: [
            "participant.id": "\(participant.id)",
            "participant.name": "\(participant.name)",
            "participants.count": "\(participants.count)",
        ])
    }
    
    // MARK: -

    public mutating func start() {
        logger.debug("trying to start the meeting")
        
        guard !isInProgress else {
            logger.warning("already in progress")
            return
        }
        
        guard !participants.isEmpty else {
            logger.warning("no participants")
            return
        }
        isInProgress = true

        for participant in participants {
            logger.trace("participating", metadata: [
                "participant.id": "\(participant.id)",
                "participant.name": "\(participant.name)",
            ])
            print("✋ \(participant.name)")
        }

        logger.debug("meeting started", metadata: [
            "participants.count": "\(participants.count)",
        ])
    }
    
    public mutating func end() {
        logger.debug("trying to end the meeting")
        
        guard isInProgress else {
            logger.warning("meeting is not in progress yet")
            return
        }

        for participant in participants {
            logger.trace("removing participant", metadata: [
                "participant.id": "\(participant.id)",
                "participant.name": "\(participant.name)",
            ])
            print("👋 \(participant.name)")
        }
        participants.removeAll()

        logger.debug("meeting finished")
    }
}

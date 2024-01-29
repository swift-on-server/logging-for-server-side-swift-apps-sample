import MyLibrary
import Logging
import Foundation

@main
struct MyApp {
    
    static func main() async throws {
        // setenv("MY_APP_LOG_LEVEL", "trace", 1)
        let appLogger = Logger.env("my-app", logLevel: .info)
        
        // setenv("MY_LIBRARY_LOG_LEVEL", "trace", 1)
        let libLogger = Logger.env("my-library", logLevel: .info)
        
        appLogger.info("Start a meeting")
        let bob = Participant(name: "Bob")
        let john = Participant(name: "John")
        let kate = Participant(name: "Kate")
        let mike = Participant(name: "Mike")
        
        appLogger.notice("Preparing the meeting")
        var meeting = Meeting(
            id: .init(),
            logger: libLogger
        )
        
        appLogger.notice("Add the participants, except Mike...")
        
        meeting.add(bob)
        meeting.add(john)
        meeting.add(kate)
        
        appLogger.warning("Trying to remove Mike from the list, but he is not on the list.")
        meeting.remove(mike)
        
        appLogger.info("Start the meeting")
        meeting.start()
        
        appLogger.notice("Add Mike to the list")
        meeting.add(mike)
        
        appLogger.notice("Remove Bob to the list")
        meeting.remove(bob)
        
        appLogger.info("End the meeting")
        meeting.end()
        
        appLogger.info("Meeting finished")
    }
}

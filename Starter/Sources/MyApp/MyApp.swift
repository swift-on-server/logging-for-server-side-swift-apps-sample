import MyLibrary
import Foundation

@main
struct MyApp {
    
    static func main() {
        
        let bob = Participant(name: "Bob")
        let john = Participant(name: "John")
        let kate = Participant(name: "Kate")
        let mike = Participant(name: "Mike")

        var meeting = Meeting(
            id: .init()
        )
        
        if !meeting.hasEnoughParticipants {
            print("⚠️ the meeting has not enouh participants just yet")
        }
                
        meeting.add(bob)
        meeting.add(john)
        meeting.add(kate)

        meeting.remove(mike)

        do {
            try meeting.start()
        }
        catch {
            print("\(error)")
        }
        
        meeting.add(mike)
        
        meeting.remove(bob)
        
        meeting.end()
    }
}

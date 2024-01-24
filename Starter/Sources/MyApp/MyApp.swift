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
                
        meeting.add(bob)
        meeting.add(john)
        meeting.add(kate)

        meeting.remove(mike)

        meeting.start()
        
        meeting.add(mike)
        
        meeting.remove(bob)
        
        meeting.end()
    }
}

import Foundation
import Socket

public class SyringePumpController: ObservableObject {
    var communicator: SyringePumpCommunicator?
    
    /*
     creates the communicator that connects to the converter over an ethernet socket.
     */
    public init(address: String, port: Int, timeout: TimeInterval) async throws {
        do {
            communicator = try SyringePumpCommunicator(address: address, port: Int(port), timeout: timeout)
            print("Connected to the syringe pump")
        } catch {
            print("Failed to connect: \(error)")
        }
    }
    
    deinit {
        communicator?.socket.close()
        communicator = nil
        print("socket closed")
    }

    func send(_ sendData: String) {
        let sendString = sendData + "\r\n"
        
        guard let communicator else {
            print("ERROR: send - communicator == nil")
            return
        }
        
        print("Syringe pump controller sent: \(sendString)")
        if let data = sendString.data(using: .utf8) {
            do {
                try communicator.write(data: data)
            } catch {
                print("Failed to send data: \(error)")
            }
        }
    }
    
    enum pumpNumber: String, CaseIterable, Identifiable {
        var id: Self { self }

        case p0 = "Pump 1"
        case p1 = "Pump 2"

        var queryString: String {
            switch self {
            case .p0: return "00"
            case .p1: return "01"
            }
        }
    }


    /*
     sends basic start command to pump of given number
     input is not checked or validated
     */
    public func startPumping(pump: String) {
        self.send("") // Sending empty string first seems to make things more consistent
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.send("\(pump)RUN") // starting pump
        }
    }
    
    /*
     sends command to start pump of given number
     input is not checked or validated
     */
    public func stopPumping(pump: String) {
        send("\(pump)STP")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.send("\(pump)STP") // entering rate mode
        }
    }
}

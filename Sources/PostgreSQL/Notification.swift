import CPostgreSQL

public struct Notification {
    public let pid: Int
    public let channel: String
    public let payload: String?
    
    init(pgNotify: PGnotify) {
        channel = String(cString: pgNotify.relname)
        pid = Int(pgNotify.be_pid)
        
        if pgNotify.extra != nil {
            payload = String(cString: pgNotify.extra)
        }
        else {
            payload = nil
        }
    }
}

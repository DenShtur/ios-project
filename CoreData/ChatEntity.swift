import Foundation
import CoreData

@objc(ChatEntity)
public class ChatEntity: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var isGroup: Bool
    @NSManaged public var lastMessageId: String?
    @NSManaged public var participants: [String] // User IDs
    @NSManaged public var messages: NSSet?
}

extension ChatEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatEntity> {
        return NSFetchRequest<ChatEntity>(entityName: "ChatEntity")
    }
}

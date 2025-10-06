import Foundation
import CoreData

@objc(MessageEntity)
public class MessageEntity: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var chatId: String
    @NSManaged public var senderId: String
    @NSManaged public var text: String?
    @NSManaged public var mediaId: String?
    @NSManaged public var timestamp: Date
    @NSManaged public var isRead: Bool
}

extension MessageEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MessageEntity> {
        return NSFetchRequest<MessageEntity>(entityName: "MessageEntity")
    }
}

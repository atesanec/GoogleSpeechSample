// Функции для работы с файлами

@class CFileInfo;

@interface CFileOperations : NSObject {
}

// Получить путь к папке Documents
+(NSString*)getDocumentsPath;
// Получить путь к папке Library
+(NSString*)getLibraryPath;
// Получить путь у папке Cache
+(NSString*)getCachePath;

@end
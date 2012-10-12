// Функции для работы с файлами

#import "FileOperations.h"

@implementation CFileOperations

+(NSString*)getDocumentsPath
{
	NSArray* paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
	NSString* documentsPath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	return documentsPath;
}

+(NSString*)getLibraryPath
{
	NSArray* paths = NSSearchPathForDirectoriesInDomains( NSLibraryDirectory, NSUserDomainMask, YES );
	NSString* documentsPath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	return documentsPath;
}

+(NSString*)getCachePath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
	NSString* cachePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	return cachePath;
}

@end

// Клиент сервиса распознавания голоса

@interface CGoogleSpeechClient : NSObject {
@private
    NSURLConnection* _connection;
    NSMutableData* _responseData;
}

-(void)queryRecognizeSoundFile:(NSString*)fileName;

@end

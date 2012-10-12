// Клиент сервиса распознавания голоса

#import "GoogleSpeechClient.h"

static NSString* GoogleSpeechUrl = @"https://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&lang=ru";

@interface CGoogleSpeechClient()

@property(nonatomic, strong) NSURLConnection* connection;
@property(nonatomic, strong) NSMutableData* responseData;

// Методы делегата NSURLConnection
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection; 

@end

@implementation CGoogleSpeechClient

@synthesize connection = _connection;
@synthesize responseData = _responseData;

-(void)queryRecognizeSoundFile:(NSString*)fileName
{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:GoogleSpeechUrl]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSData dataWithContentsOfFile:fileName]];
    
	[request setValue:@"Mozilla/5.0" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"audio/x-flac; rate=16000" forHTTPHeaderField:@"Content-Type"];
    
    self.responseData = [NSMutableData data];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [_connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse*)response
{
    if( [response statusCode] != 200 ) {
        NSLog(@"Invalid service response: %@",
              [NSHTTPURLResponse localizedStringForStatusCode:[response statusCode]]);
        [connection cancel];
        return;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Translate service error:%@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString* text = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
   
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:text message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end

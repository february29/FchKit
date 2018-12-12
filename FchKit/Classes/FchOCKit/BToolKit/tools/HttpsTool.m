//
//  HttpsTool.m
//  Fch_Location
//
//  Created by bai on 16/7/22.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "HttpsTool.h"


static NSString *server = @"fchder";
static NSString *p12file = @"fch";
static NSString *p12pwd = @"xianzhi-0729";

@interface HttpsTool()<NSURLSessionDataDelegate>{
    NSURLSessionConfiguration *configuration;
    NSURLSession *session;
}
@end


@implementation HttpsTool

+(instancetype)sharedInstance{
    static HttpsTool *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[[self class]alloc]init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];

    }
    return self;
}


-(NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self POST:URLString parameters:parameters progress:nil success:success failure:failure];
}


-(NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress *uploadProgress) )uploadProgress
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject ))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSAssert(URLString!=nil, @"requsetURLStr must be not a nil value");
    NSMutableString *fainalURL = [NSMutableString stringWithString:URLString];
    if (parameters) {
        
        [[parameters allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx==0) {
                [fainalURL appendString:@"?"];
                [fainalURL appendString:obj];
                [fainalURL appendString:@"="];
                [fainalURL appendString:[parameters objectForKey:obj]];
            }else{
                [fainalURL appendString:@"&"];
                [fainalURL appendString:obj];
                [fainalURL appendString:@"="];
                [fainalURL appendString:[parameters objectForKey:obj]];

            }
        }];
        
    }
    
    NSURL *url = [NSURL URLWithString:fainalURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"GET"];
    
    
    
    NSURLSessionDataTask *task;
    task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //更显UI
            if (error) {
                if (failure) {
                    failure(task, error);
                }
            } else {
                if (success) {
                    
                    success(task, data);
                }
            }

        });
        
    }];
    [task resume];
    
    return task;

}


- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    NSString *method = challenge.protectionSpace.authenticationMethod;
    NSLog(@"%@", method);
    if([method isEqualToString:NSURLAuthenticationMethodServerTrust]){
        NSString *host = challenge.protectionSpace.host;
        NSLog(@"%@", host);
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        return;
    }
    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"fch" ofType:@"p12"];
    NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];
    CFDataRef inPKCS12Data = (CFDataRef)CFBridgingRetain(PKCS12Data);
    SecIdentityRef identity;        // 读取p12证书中的内容
    OSStatus result = [self extractP12Data:inPKCS12Data toIdentity:&identity];
    
    if(result != errSecSuccess){
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        return;
    }
    SecCertificateRef certificate = NULL;
    SecIdentityCopyCertificate (identity, &certificate);
    const void *certs[] = {certificate};
    CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
    NSURLCredential *credential = [NSURLCredential credentialWithIdentity:identity certificates:(NSArray*)CFBridgingRelease(certArray) persistence:NSURLCredentialPersistencePermanent];
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
}
-(OSStatus) extractP12Data:(CFDataRef)inP12Data toIdentity:(SecIdentityRef*)identity {        OSStatus securityError = errSecSuccess;
    CFStringRef password = CFSTR("xianzhi-0729");
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inP12Data, options, &items);
    if (securityError == 0) {
        CFDictionaryRef ident = CFArrayGetValueAtIndex(items,0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(ident, kSecImportItemIdentity);
        *identity = (SecIdentityRef)tempIdentity;
    }
    if (options) {
        CFRelease(options);
    }
    return securityError;
}


#pragma mark AFNetWorking

-(AFHTTPSessionManager *)httpsManager{
    
    AFHTTPSessionManager *httpsManager = [AFHTTPSessionManager manager];
    httpsManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    httpsManager.responseSerializer.acceptableContentTypes = [httpsManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    httpsManager.requestSerializer.timeoutInterval = 10.0f;
    
    [httpsManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    __weak typeof(httpsManager) wkhttpsManager = httpsManager;
    [httpsManager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession * _Nonnull session, NSURLAuthenticationChallenge * _Nonnull challenge, NSURLCredential *__autoreleasing  _Nullable * _Nullable credential) {
       // NSLog(@"----received challenge----");
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *__credential = nil;
        if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
           // NSLog(@"----server verify client----");
            if ([wkhttpsManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                __credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if (__credential) {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                }else{
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            }else{
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        }else{
            //client authentication
            
           // NSLog(@"----client verify server---- %@",challenge.protectionSpace);
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSString *p12 = [[NSBundle mainBundle] pathForResource:p12file ofType:@"p12"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if (![fileManager fileExistsAtPath:p12]) {
                NSLog(@"%@.p12 file not exist!",p12file);
            }else{
                NSData *pkcs12Data = [NSData dataWithContentsOfFile:p12];
                //__strong typeof([NHAFEngine class]) strongSelf = weakSelf;
                if ([self extractIdentity:&identity andTrust:&trust fromPKCS12Data:pkcs12Data]) {
                    SecCertificateRef certificate = NULL;
                    SecIdentityCopyCertificate(identity, &certificate);
                    const void *certs[] = {certificate};
                    CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
                    __credential = [NSURLCredential credentialWithIdentity:identity certificates:(__bridge NSArray *)certArray persistence:NSURLCredentialPersistencePermanent];
                    disposition = NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        *credential = __credential;
        return disposition;
    }];

    
    //set security policy
    AFSecurityPolicy *t_policy;
    NSString *cerFilePath = [[NSBundle mainBundle] pathForResource:server ofType:@"cer"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cerFilePath]) {
        NSData *CAData = [NSData dataWithContentsOfFile:cerFilePath];
        t_policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        [t_policy setAllowInvalidCertificates:true];
        [t_policy setValidatesDomainName:false];
        [t_policy setPinnedCertificates:[NSSet setWithObjects:CAData, nil]];
        NSLog(@"security policy certificate");
    }else{
        AFSecurityPolicy *t_policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [t_policy setAllowInvalidCertificates:true];
        [t_policy setValidatesDomainName:false];
    }
    httpsManager.securityPolicy = t_policy;
   


    return httpsManager;
}


-(BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    
    OSStatus securityErr = errSecSuccess;
    //client certificate password
    NSDictionary *optionsDic = [NSDictionary dictionaryWithObject:p12pwd forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityErr = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data, (__bridge CFDictionaryRef)optionsDic, &items);
    if (securityErr == errSecSuccess) {
        CFDictionaryRef mineIdentAndTrust = CFArrayGetValueAtIndex(items, 0);
        const void *tmpIdentity = NULL;
        tmpIdentity = CFDictionaryGetValue(mineIdentAndTrust, kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tmpIdentity;
        const void *tmpTrust = NULL;
        tmpTrust = CFDictionaryGetValue(mineIdentAndTrust, kSecImportItemTrust);
        *outTrust = (SecTrustRef)tmpTrust;
    }else{
        NSLog(@"failed to extract identity/trust with err code :%d",securityErr);
        return false;
    }
    return true;
}

+(void)addhttpsSecurityPolicyForAFHTTPSessionManager:(AFHTTPSessionManager *)httpsManager{
    
}

@end

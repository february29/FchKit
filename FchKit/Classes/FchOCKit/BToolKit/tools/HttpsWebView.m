//
//  HttpsWebView.m
//  Fch_OA
//
//  Created by bai on 16/8/12.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "HttpsWebView.h"


static NSString *server = @"fchder";
static NSString *p12file = @"fch";
static NSString *p12pwd = @"xianzhi-0729";



@interface HttpsWebView()<UIWebViewDelegate,NSURLConnectionDelegate>{
    NSURLConnection *_urlConnection;
    NSURLRequest *_request;
    BOOL _authenticated;
}
@end


@implementation HttpsWebView


//==================================================


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSLog(@"Did start loading: %@ auth:%d", [[request URL]absoluteString],_authenticated);
    _request = request;
    
    if (!_authenticated) {
        _authenticated =NO;
        
        _urlConnection = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
        
        [_urlConnection start];
        
        return NO;
    }
    
    return YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // 102 == WebKitErrorFrameLoadInterruptedByPolicyChange
    NSLog(@"***********error:%@,errorcode=%ld,errormessage:%@",error.domain,(long)error.code,error.description);
    if (!([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code ==102)) {
        //[self dismissWithError:error animated:YES];
    }
}



#pragma mark - NURLConnection delegate


- (void)connection:(NSURLConnection *)connection

willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge

{
    
    
    
    NSString *thePath = [[NSBundle mainBundle] pathForResource:p12file ofType:@"p12"];
    
    NSLog(@"thePath===========%@",thePath);
    
    NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];
    
    CFDataRef inPKCS12Data = (__bridge CFDataRef)PKCS12Data;
    
    
    
    SecIdentityRef identity = NULL;
    
    // extract the ideneity from the certificate
    
    [self extractIdentity :inPKCS12Data :&identity];
    
    
    
    SecCertificateRef certificate = NULL;
    
    SecIdentityCopyCertificate (identity, &certificate);
    
    
    
    const void *certs[] = {certificate};
    
    //                        CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
    
    // create a credential from the certificate and ideneity, then reply to the challenge with the credential
    
    //NSLog(@"identity=========%@",identity);
    
    NSURLCredential *credential = [NSURLCredential credentialWithIdentity:identity certificates:nil persistence:NSURLCredentialPersistencePermanent];
    
    
    
    //           credential = [NSURLCredential credentialWithIdentity:identity certificates:(__bridge NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
    
    
    
    [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    
    
    
    
    
}

- (OSStatus)extractIdentity:(CFDataRef)inP12Data :(SecIdentityRef*)identity {
    
    OSStatus securityError = errSecSuccess;
    
    
    
    CFStringRef password = CFSTR("xianzhi-0729");
    
    const void *keys[] = { kSecImportExportPassphrase };
    
    const void *values[] = { password };
    
    
    
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    
    
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    
    securityError = SecPKCS12Import(inP12Data, options, &items);
    
    
    
    if (securityError == 0)
        
    {
        
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

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
    NSLog(@"WebController Got auth challange via NSURLConnection");
    
    if ([challenge previousFailureCount] ==0)
    {
        _authenticated =YES;
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    } else
    {
        [[challenge sender]cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response;
{
    NSLog(@"WebController received response via NSURLConnection");
    
    // remake a webview call now that authentication has passed ok.
    _authenticated =YES;
    [self loadRequest:_request];
    
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return[protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}


//==================================================


-(AFHTTPSessionManager *)httpsManager{
    AFHTTPSessionManager *httpsManager = nil;
    
    httpsManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    httpsManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    httpsManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
    
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



- (void)httpsLoadRequest:(NSURLRequest *)request{
    
    
    __weak typeof (self) wkself = self;
    NSURLSessionDataTask *dataTask = [self.httpsManager GET:request.URL.absoluteString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSString *htmlString =  [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding]; ;
       
        [wkself loadData:responseObject MIMEType:nil textEncodingName:nil baseURL:[task.currentRequest URL]];
        
        //[wkself loadHTMLString:htmlString baseURL:nil];
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
            [self.delegate webViewDidFinishLoad:self];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
            [self.delegate webView:self didFailLoadWithError:error];
        }
    }];
    
    [dataTask resume];
    
    if ([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.delegate webViewDidStartLoad:self];
    }
}


- (void)httpsLoadRequest2:(NSURLRequest *)request{
    
}


@end

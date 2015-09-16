//
//  ImageDownloadManager.h
//  SampleAppImageDownload
//
//  Created by Saalis Umer on 29/07/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol ImageDownloadManagerDelegate <NSObject>

@optional
- (void)loadImageForURL:(NSURL *)url imageId:(NSString *)imageId
             didComplete:(UIImage *)image;

- (void)loadImageForURL:(NSURL *)url imageId:(NSString *)imageId
             didFailWithError:(NSError *)error;

@end

@interface ImageDownloadManager : NSObject

+ (ImageDownloadManager *) instance;

- (UIImage *)imageForURL:(NSURL *)url imageId:(NSString *)imageId;

- (UIImage *)loadImageForURL:(NSURL *)url imageId:(NSString *)imageId
                  delegate:(id<ImageDownloadManagerDelegate>)delegate;

- (NSError *)saveImageData:(NSData *)imageData forURL:(NSURL *)url imageId:(NSString *)imageId;

- (void)cancelLoadingPendingRequests;

- (void)pruneImagesFromDocumentsDirectory;
- (void)pruneImagesOlderThan:(NSDate *)thresholdDate;

- (int)numberOfImageOperationsRunning;

@end

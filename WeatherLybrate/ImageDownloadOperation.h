//
//  ImageDownloadOperation.h
//  SampleAppImageDownload
//
//  Created by Saalis Umer on 29/07/15.
//  Copyright (c) 2015 Saalis Umer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloadManager.h"
#import <UIKit/UIKit.h>

@interface ImageDownloadOperation : NSOperation

@property(readonly, copy) NSURL *url;
@property(strong , readonly) NSString *imageId;

@property(readonly, weak) id<ImageDownloadManagerDelegate> delegate;

- (id)initWithURL:(NSURL *)url imageId:(NSString *)imageId delegate:(id<ImageDownloadManagerDelegate>)delegate;

@end

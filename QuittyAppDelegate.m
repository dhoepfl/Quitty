//
//  QuittyAppDelegate.m
//  Quitty
//
//  Created by Daniel Höpfl on 26.01.11.
//  Copyright 2011 Daniel Höpfl. All rights reserved.
//

#import "QuittyAppDelegate.h"

@interface QuittyAppDelegate()

- (void) switchHandler:(NSNotification*) notification;

@end


@implementation QuittyAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    NSNotificationCenter *nc = [[NSWorkspace sharedWorkspace] notificationCenter];
    [nc addObserver:self
           selector:@selector(switchHandler:)
               name:NSWorkspaceSessionDidResignActiveNotification
             object:nil];
}

- (void) switchHandler:(NSNotification*) notification
{
    BOOL iTunesIsRunning = NO;
    NSArray * launchedApplications = [[NSWorkspace sharedWorkspace] launchedApplications];
    for (NSDictionary *app in launchedApplications) {
        if ([@"com.apple.iTunes" isEqualToString:[app objectForKey:@"NSApplicationBundleIdentifier"]]){
            iTunesIsRunning = YES;
            break;
        }
    }

    if (iTunesIsRunning) {
        NSAppleScript *as = [[[NSAppleScript alloc] initWithSource:@"tell app \"iTunes\" to quit"] autorelease];
        NSDictionary *error;
        [as executeAndReturnError:&error];
    }
}

@end

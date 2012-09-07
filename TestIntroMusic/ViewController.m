//
//  ViewController.m
//  TestIntroMusic
//
//  Created by Karl Stenerud on 9/7/12.
//  Copyright (c) 2012 Karl Stenerud. All rights reserved.
//

#import "ViewController.h"
#import "ObjectAL.h"
#import "OALAudioTrack.h"

#define kIntroTrackFileName @"ColdFunk-Intro.caf"
#define kLoopTrackFileName @"ColdFunk.caf"

@interface ViewController ()

@property(nonatomic, readwrite, retain) OALAudioTrack* mainTrack;
@property(nonatomic, readwrite, retain) OALAudioTrack* introTrack;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.introTrack = [OALAudioTrack track];
    self.mainTrack = [OALAudioTrack track];

    [self startMusic];
}

- (void) startMusic
{
    [self.introTrack preloadFile:kIntroTrackFileName];
    [self.mainTrack preloadFile:kLoopTrackFileName];
    self.mainTrack.numberOfLoops = -1;

    // Play the main track at volume 0 to secure the hardware channel for it.
    self.mainTrack.volume = 0;
    [self.mainTrack play];

    // Start the intro playing on a software channel, then stop the main track.
    [self.introTrack play];
    [self.mainTrack stop];

    // Have the main track start again after the intro track's duration elapses.
    NSTimeInterval playAt = self.mainTrack.deviceCurrentTime + self.introTrack.duration;
    [self.mainTrack playAtTime:playAt];
    self.mainTrack.volume = 1;
}

@end

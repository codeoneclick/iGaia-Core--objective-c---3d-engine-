//
//  iGaiaSoundMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 22/05/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "iGaiaSoundMgr.h"

@interface iGaiaSoundMgr()

@property(nonatomic, assign) ALCcontext* m_context;
@property(nonatomic, assign) ALCdevice* m_device;

@property(nonatomic, strong) NSMutableArray* m_sources;

@property(nonatomic, strong) NSMutableDictionary* m_sounds;
@property(nonatomic, strong) NSMutableDictionary* m_music;

@property(nonatomic, assign) AVAudioPlayer* m_backgroundAudio;
@property(nonatomic, assign) ALfloat m_backgroundVolume;


- (BOOL)initOpenAL;
- (NSUInteger) nextAvailableSource;
- (AudioFileID) openAudioFile:(NSString*)theFilePath;
- (UInt32) audioFileSize:(AudioFileID)fileDescriptor;
@end


@implementation iGaiaSoundMgr

- (id)init
{
	if(self = [super init])
    {
		_m_sources = [NSMutableArray new];
		_m_sounds = [NSMutableDictionary new];
		_m_music = [NSMutableDictionary new];
		
		_m_backgroundVolume = 1.0f;

        _m_device = alcOpenDevice(NULL);
        if(_m_device)
        {
            _m_context = alcCreateContext(_m_device, NULL);
            alcMakeContextCurrent(_m_context);
            NSUInteger sourceId;
            for(int index = 0; index < kMaxSources; index++)
            {
                alGenSources(1, &sourceId);
                [soundSources addObject:[NSNumber numberWithUnsignedInt:sourceID]];
            }
            
            // Return YES as we have successfully initialized OpenAL
            return YES;
        }
        // Something went wrong so return NO
        return NO;

		
		// Set up the OpenAL
		BOOL result = [self initOpenAL];
		if(!result)	return nil;
		return self;
	}
	[self release];
	return nil;
}


/*
 This method is used to initialize OpenAL.  It gets the default device, creates a new context 
 to be used and then preloads the define # sources.  This preloading means we wil be able to play up to
 (max 32) different sounds at the same time
 */
- (BOOL) initOpenAL {
	// Get the device we are going to use for sound.  Using NULL gets the default device
	}

- (void) shutdownSoundManager {
	@synchronized(self) {
		if(sharedSoundManager != nil) {
			[self dealloc];
		}
	}
}


- (void) loadSoundWithKey:(NSString*)theSoundKey 
				 fileName:(NSString*)theFileName 
				  fileExt:(NSString*)theFileExt 
				frequency:(NSUInteger)theFrequency {
	
	// Get the full path of the audio file
	NSString *filePath = [[NSBundle mainBundle] pathForResource:theFileName ofType:theFileExt];
	
	// Now we need to open the file
	AudioFileID fileID = [self openAudioFile:filePath];
	
	// Find out how big the actual audio data is
	UInt32 fileSize = [self audioFileSize:fileID];
	
	// Create a location for the audio data to live temporarily
	unsigned char *outData = malloc(fileSize);
	
	// Load the byte data from the file into the data buffer
	OSStatus result = noErr;
	result = AudioFileReadBytes(fileID, FALSE, 0, &fileSize, outData);
	AudioFileClose(fileID);
	
	if(result != 0) {
		NSLog(@"ERROR SoundEngine: Cannot load sound: %@", theFileName);
		return;
	}
	
	NSUInteger bufferID;
	
	// Generate a buffer within OpenAL for this sound
	alGenBuffers(1, &bufferID);
	
	// Place the audio data into the new buffer
	alBufferData(bufferID, AL_FORMAT_STEREO16, outData, fileSize, theFrequency);
	
	// Save the buffer to be used later
	[soundLibrary setObject:[NSNumber numberWithUnsignedInt:bufferID] forKey:theSoundKey];
	
	// Clean the buffer
	if(outData) {
		free(outData);
		outData = NULL;
	}
}


- (void) loadBackgroundMusicWithKey:(NSString*)theMusicKey fileName:(NSString*)theFileName fileExt:(NSString*)theFileExt {
	
	NSString *path = [[NSBundle mainBundle] pathForResource:theFileName ofType:theFileExt];
	[musicLibrary setObject:path forKey:theMusicKey];
}


/*
 Used to load an audiofile from the file path which is provided.
 */
- (AudioFileID) openAudioFile:(NSString*)theFilePath {
	
	AudioFileID outAFID;
	// Create an NSURL which will be used to load the file.  This is slightly easier
	// than using a CFURLRef
	NSURL *afUrl = [NSURL fileURLWithPath:theFilePath];
	
	// Open the audio file provided
	OSStatus result = AudioFileOpenURL((CFURLRef)afUrl, kAudioFileReadPermission, 0, &outAFID);
	
	// If we get a result that is not 0 then something has gone wrong.  We report it and 
	// return the out audio file id
	if(result != 0)	{
		NSLog(@"ERROR SoundEngine: Cannot open file: %@", theFilePath);
		return nil;
	}
	
	return outAFID;
}


/*
 This helper method returns the file size in bytes for a given AudioFileID
 */
- (UInt32) audioFileSize:(AudioFileID)fileDescriptor {
	UInt64 outDataSize = 0;
	UInt32 thePropSize = sizeof(UInt64);
	OSStatus result = AudioFileGetProperty(fileDescriptor, kAudioFilePropertyAudioDataByteCount, &thePropSize, &outDataSize);
	if(result != 0)	NSLog(@"ERROR: cannot file file size");
	return (UInt32)outDataSize;
}


/*
 Plays the sound which matches the key provided.  The Gain, pitch and if the sound should loop can
 also be set from the method signature
 */
- (NSUInteger) playSoundWithKey:(NSString*)theSoundKey gain:(ALfloat)theGain pitch:(ALfloat)thePitch location:(Vector2f)theLocation shouldLoop:(BOOL)theShouldLoop {
	
	ALenum err = alGetError(); // clear the error code
	
	// Find the buffer linked to the key which has been passed in
	NSNumber *numVal = [soundLibrary objectForKey:theSoundKey];
	if(numVal == nil) return 0;
	NSUInteger bufferID = [numVal unsignedIntValue];
	
	// Find an available source i.e. it is currently not playing anything
	NSUInteger sourceID = [self nextAvailableSource];
	
	// Make sure that the source is clean by resetting the buffer assigned to the source
	// to 0
	alSourcei(sourceID, AL_BUFFER, 0);
	//Attach the buffer we have looked up to the source we have just found
	alSourcei(sourceID, AL_BUFFER, bufferID);
	
	// Set the pitch and gain of the source
	alSourcef(sourceID, AL_PITCH, thePitch);
	alSourcef(sourceID, AL_GAIN, theGain);
	
	// Set the looping value
	if(theShouldLoop) {
		alSourcei(sourceID, AL_LOOPING, AL_TRUE);
	} else {
		alSourcei(sourceID, AL_LOOPING, AL_FALSE);
	}
	
	// Check to see if there were any errors
	err = alGetError();
	if(err != 0) {
		NSLog(@"ERROR SoundManager: %d", err);
		return 0;
	}
	
	// Now play the sound
	alSourcePlay(sourceID);
	
	// Return the source ID so that loops can be stopped etc
	return sourceID;
}


- (void) stopSoundWithKey:(NSString*)theSoundKey {
	
}


/*
 Play the background track which matches the key
 */
- (void) playMusicWithKey:(NSString*)theMusicKey timesToRepeat:(NSUInteger)theTimesToRepeat {
	
	NSError *error;
	
	NSString *path = [musicLibrary objectForKey:theMusicKey];
	
	if(!path) {
		NSLog(@"ERROR SoundEngine: The music key '%@' could not be found", theMusicKey);
		return;
	}
	
	// Initialize the AVAudioPlayer
	backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
	
	// If the backgroundMusicPlayer object is nil then there was an error
	if(!backgroundMusicPlayer) {
		NSLog(@"ERROR SoundManager: Could not play music for key '%d'", error);
		return;
	}		
	
	// Set the number of times this music should repeat.  -1 means never stop until its asked to stop
	[backgroundMusicPlayer setNumberOfLoops:theTimesToRepeat];
	
	// Set the volume of the music
	[backgroundMusicPlayer setVolume:backgroundMusicVolume];
	
	// Play the music
	[backgroundMusicPlayer play];
	
	
}


/*
 Stop playing the currently playing music
 */
- (void) stopPlayingMusic {
	[backgroundMusicPlayer stop];
}


/*
 Set the volume of the music which is between 0.0 and 1.0
 */
- (void) setBackgroundMusicVolume:(ALfloat)theVolume {
	
	// Set the volume iVar
	backgroundMusicVolume = theVolume;
	
	// Check to make sure that the audio player exists and if so set its volume
	if(backgroundMusicPlayer) {
		[backgroundMusicPlayer setVolume:backgroundMusicVolume];
		
	}
}


/* 
 Search through the max number of sources to find one which is not planning.  If one cannot
 be found that is not playing then the first one which is looping is stopped and used instead.
 If a source still cannot be found then the first source is stopped and used
 */
- (NSUInteger) nextAvailableSource {
	
	// Holder for the current state of the current source
	NSInteger sourceState;
	
	// Find a source which is not being used at the moment
	for(NSNumber *sourceNumber in soundSources) {
		alGetSourcei([sourceNumber unsignedIntValue], AL_SOURCE_STATE, &sourceState);
		// If this source is not playing then return it
		if(sourceState != AL_PLAYING) return [sourceNumber unsignedIntValue];
	}
	
	// If all the sources are being used we look for the first non looping source
	// and use the source associated with that
	NSInteger looping;
	for(NSNumber *sourceNumber in soundSources) {
		alGetSourcei([sourceNumber unsignedIntValue], AL_LOOPING, &looping);
		if(!looping) {
			// We have found a none looping source so return this source and stop checking
			NSUInteger sourceID = [sourceNumber unsignedIntValue];
			alSourceStop(sourceID);
			return sourceID;
		}
	}
	
	// If there are no looping sources to be found then just use the first sounrce and use that
	NSUInteger sourceID = [[soundSources objectAtIndex:0] unsignedIntegerValue];
	alSourceStop(sourceID);
	return sourceID;
}


- (id)retain {
    return self;
}


- (unsigned)retainCount {
    return UINT_MAX;  //denotes an object that cannot be released
} 


- (void)release {
    //do nothing
}


- (id)autorelease {
    return self;
}

- (void)dealloc {
	// Loop through the OpenAL sources and delete them
	for(NSNumber *numVal in soundSources) {
		NSUInteger sourceID = [numVal unsignedIntValue];
		alDeleteSources(1, &sourceID);
	}
	
	// Loop through the OpenAL buffers and delete 
	NSEnumerator *enumerator = [soundLibrary keyEnumerator];
	id key;
	while ((key = [enumerator nextObject])) {
		NSNumber *bufferIDVal = [soundLibrary objectForKey:key];
		NSUInteger bufferID = [bufferIDVal unsignedIntValue];
		alDeleteBuffers(1, &bufferID);		
	}
	
	// Release the arrays and dictionaries we have been using
	[soundLibrary release];
	[soundSources release];
	[musicLibrary release];
	
	// Disable and then destroy the context
	alcMakeContextCurrent(NULL);
	alcDestroyContext(context);
	
	// Close the device
	alcCloseDevice(device);
	
	[super dealloc];
}
@end

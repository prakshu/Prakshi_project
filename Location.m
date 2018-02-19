//
//  Location.m
//  JSONHandler
//
//  Created by Phillipus on 28/10/2013.
//  Copyright (c) 2013 Dada Beatnik. All rights reserved.
//

#import "Location.h"

@implementation Location
@synthesize Descriptrion,Title,url;
// Init the object with information from a dictionary
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init]) {
        // Assign all properties with keyed values from the dictionary
        Descriptrion = [jsonDictionary objectForKey:@"description"];
        Title = [jsonDictionary objectForKey:@"title"];
        url=[jsonDictionary objectForKey:@"imageHref"];
    }
    
    return self;
}

@end

//
//  VWWRESTParser.m
//  Smile
//
//  Created by Zakk Hoyt on 2/12/13.
//
//

#import "VWWRESTParser.h"
#import "VWWRedditAbout.h"
#import "VWWRedditUserData.h"
#import "VWWRedditData.h"
#import "VWWRedditErrors.h"
#import "VWWRedditLogin.h"


@implementation VWWRESTParser

//data =     {
//    "comment_karma" = 2041;
//    created = 1255988260;
//    "created_utc" = 1255984660;
//    "has_mail" = "<null>";
//    "has_mod_mail" = "<null>";
//    "has_verified_email" = 1;
//    id = 3omda;
//    "is_friend" = 0;
//    "is_gold" = 0;
//    "is_mod" = 0;
//    "link_karma" = 3043;
//    name = sneeden;
//    "over_18" = 1;
//};
//kind = t2;
+(BOOL)parseJSON:(NSDictionary*)json about:(VWWRedditAbout**)about{
    if(json == nil){
        return NO;
    }
    


    *about = [[VWWRedditAbout alloc]init];
    NSDictionary *dataDictionary = json[@"data"];
    VWWRedditUserData *data = [VWWRedditUserData userWithDictionary:dataDictionary];
    NSString *kind = json[@"kind"];
    
    
    (*about).data = data;
    (*about).kind = kind;
    
    return YES;
}


//{
//    json =     {
//        data =         {
//            cookie = "12394811,2013-04-20T22:42:57,308080f8dcea3b13ae6e3db21e487e4ce8d9a23b";
//            modhash = wl5ch9axap008f603fb3d014324c87422e178156207069c7c5;
//        };
//        errors =         (
//        );
//    };
//}
+(BOOL)parseJSON:(id)json data:(VWWRedditLogin**)login{

    NSDictionary *jsonDictionary = json[@"json"];
    NSDictionary *dataDictionary = jsonDictionary[@"data"];
    NSDictionary *errorsDictionary = jsonDictionary[@"errors"];
    
    (*login).data = [VWWRedditData dataWithDictionary:dataDictionary];
    (*login).errors = [VWWRedditErrors errorsWithDictionary:errorsDictionary];
    
    
    return YES;
}





//#pragma mark Private helpers
//+(void)examineDictionary:(NSDictionary*)dictionary forPage:(SMPagination**)page{
//    
//    BOOL paramFound = NO;
//    *page = [[SMPagination alloc]init];
//    
//    NSNumber* temp = dictionary[@"per_page"];
//    if(temp){
//        paramFound = YES;
//        (*page).perPageItemsCount = temp.intValue;
//    }
//    
//    temp = dictionary[@"total_count"];
//    if(temp){
//        paramFound = YES;
//        (*page).totalItemsCount = temp.intValue;
//    }
//    
//    temp = dictionary[@"page_number"];
//    if(temp){
//        paramFound = YES;
//        (*page).pageNumber = temp.intValue;
//    }
//    
//    // If we never found anythign, page should be nil.
//    if(paramFound == NO){
//        *page = nil;
//    }
//    
//}


#pragma mark Public methods
//+(BOOL)parseJSON:(id)json albums:(NSArray**)albums page:(SMPagination**)page{
//    return NO;
//}

//+(BOOL)parseJSON:(id)json assets:(NSArray**)assets page:(SMPagination**)page{
//
//    NSError* jsonError;
//    NSDictionary *dictionary;
//    if([json isKindOfClass:[NSDictionary class]]){
//        dictionary = json;
//    }
//    else{
//        dictionary = [NSJSONSerialization JSONObjectWithData:json
//                                                     options:kNilOptions
//                                                       error:&jsonError];
//        if(jsonError){
//            DDLogError(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
//            return NO;
//        }
//    }
//    [VWWRESTParser examineDictionary:dictionary forPage:page];
//    
//    NSMutableArray* mutableAssets = [@[]mutableCopy];
//    NSArray *assetsDictionaries = (NSArray*)dictionary[@"assets"];
//    for(NSDictionary *d in assetsDictionaries) {
//        [mutableAssets addObject:[SMAsset assetWithDictionary:d]];
//    }
//    *assets = (NSArray*)mutableAssets;
//    
//    return YES;
//}
//
//
//
//+(BOOL)parseJSON:(id)json devices:(NSArray**)devices page:(SMPagination**)page{
//    NSError *jsonError;
//    NSDictionary *dictionary;
//    if([json isKindOfClass:[NSDictionary class]]){
//        dictionary = json;
//    }
//    else{
//        dictionary = [NSJSONSerialization JSONObjectWithData:json
//                                                     options:kNilOptions
//                                                       error:&jsonError];
//        if(jsonError){
//            DDLogError(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
//            return NO;
//        }
//    }
//    
//    [VWWRESTParser examineDictionary:dictionary forPage:page];
//    
//    NSMutableArray* mutableDevices = [@[]mutableCopy];
//    NSArray *assetsDictionaries = (NSArray*)dictionary[@"devices"];
//    for(NSDictionary *d in assetsDictionaries) {
//        [mutableDevices addObject:[SMSource sourceWithDictionary:d]];
//    }
//    *devices = (NSArray*)mutableDevices;
//    
//    return YES;
//}
//
//
//+(BOOL)parseJSON:(id)json facetGUIProperties:(NSArray**)facetGUIProperties page:(SMPagination**)page{
//    NSError* jsonError;
//    NSDictionary *dictionary;
//    if(json == nil){
//        //NSAssert(NO, @"Somethign is not right!");
//        return NO;
//    }
//    if([json isKindOfClass:[NSDictionary class]]){
//        dictionary = json;
//    }
//    else{
//        dictionary = [NSJSONSerialization JSONObjectWithData:json
//                                                     options:kNilOptions
//                                                       error:&jsonError];
//        if(jsonError){
//            DDLogError(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
//            return NO;
//        }
//    }
//    
//    
//    if(jsonError){
//        DDLogError(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
//        return NO;
//    }
//    
//    [VWWRESTParser examineDictionary:dictionary forPage:page];
//    
//    NSMutableArray* mutableDictionary = [@[]mutableCopy];
//    NSArray *dictionaries = (NSArray*)dictionary[@"facet_order"];
//    for(NSDictionary *d in dictionaries) {
//        [mutableDictionary addObject:[SMFacetsGUIProperties facetsGUIPropertiesWithDictionary:d]];
//    }
//    *facetGUIProperties = (NSArray*)mutableDictionary;
//    
//    return YES;
//    
//}
//
//
//
//+(BOOL)parseJSON:(id)json facets:(NSArray**)facets page:(SMPagination**)page{
//    NSError *jsonError;
//    NSDictionary *dictionary;
//    if([json isKindOfClass:[NSDictionary class]]){
//        dictionary = json;
//    }
//    else{
//        dictionary = [NSJSONSerialization JSONObjectWithData:json
//                                                     options:kNilOptions
//                                                       error:&jsonError];
//        if(jsonError){
//            DDLogError(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
//            return NO;
//        }
//    }
//    
//    [VWWRESTParser examineDictionary:dictionary forPage:page];
//    
//    NSMutableArray* mutableFacets = [@[]mutableCopy];
//    NSArray *facetsDictionaries = (NSArray*)dictionary[@"pivot_facets"];
//    for(NSDictionary *d in facetsDictionaries) {
//        [mutableFacets addObject:[SMPivotFacet pivotFacetWithDictionary:d]];
//    }
//    *facets = (NSArray*)mutableFacets;
//    
//    return YES;
//
//}
//+(BOOL)parseJSON:(id)json followers:(NSArray**)followers page:(SMPagination**)page{
//    return NO;
//}
//+(BOOL)parseJSON:(id)json friends:(NSArray**)friends page:(SMPagination**)page{
//    return NO;
//}
//+(BOOL)parseJSON:(id)json services:(NSArray**)services page:(SMPagination**)page{
//    NSError* jsonError;
//    NSDictionary *dictionary;
//    if([json isKindOfClass:[NSDictionary class]]){
//        dictionary = json;
//    }
//    else{
//        dictionary = [NSJSONSerialization JSONObjectWithData:json
//                                                     options:kNilOptions
//                                                       error:&jsonError];
//        if(jsonError){
//            DDLogError(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
//            return NO;
//        }
//    }
//    
//    
//    [VWWRESTParser examineDictionary:dictionary forPage:page];
//    
//    NSMutableArray* mutableArray = [@[]mutableCopy];
//    for(NSString *s in dictionary){
//        [mutableArray addObject:s];
//    }
//    *services = (NSArray*)mutableArray;
//    
//    return YES;
//}
//
//
//// Expect a page with an array:
////{
////    "page_number":1,
////    "per_page":10,
////    "total_count":3,
////    "next_page":"",
////    "previous_page":"",
////    "first_page":"http://wbs.ht/api/v2/sources?page=1",
////    "last_page":"http://wbs.ht/api/v2/sources?page=1",
////    "sources":[]
////}
//+(BOOL)parseJSON:(id)json sources:(NSArray**)sources page:(SMPagination**)page{
//    NSError *jsonError;
//    NSDictionary *dictionary;
//    if([json isKindOfClass:[NSDictionary class]]){
//        dictionary = json;
//    }
//    else{
//        dictionary = [NSJSONSerialization JSONObjectWithData:json
//                                                     options:kNilOptions
//                                                       error:&jsonError];
//        if(jsonError){
//            DDLogError(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
//            return NO;
//        }
//    }
//    
//    [VWWRESTParser examineDictionary:dictionary forPage:page];
//    
//    NSMutableArray* mutableArray = [@[]mutableCopy];
//    NSArray *dictionaries = (NSArray*)dictionary[@"sources"];
//    for(NSDictionary *d in dictionaries) {
//        [mutableArray addObject:[SMSource sourceWithDictionary:d]];
//    }
//    *sources = (NSArray*)mutableArray;
//    
//    return YES;
//}
//
//
//+(BOOL)parseJSON:(id)json user:(SMUser*)user{
//    NSError* jsonError;
//    NSDictionary *dictionary;
//    if([json isKindOfClass:[NSDictionary class]]){
//        dictionary = json;
//    }
//    else{
//        dictionary = [NSJSONSerialization JSONObjectWithData:json
//                                                     options:kNilOptions
//                                                       error:&jsonError];
//        if(jsonError){
//            DDLogError(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
//            return NO;
//        }
//    }
//    
//    NSMutableArray* mutableArray = [@[]mutableCopy];
//    for(NSString *s in dictionary){
//        [mutableArray addObject:s];
//    }
//    
//    
//    return YES;
//}



@end

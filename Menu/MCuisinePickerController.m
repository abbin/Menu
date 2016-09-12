//
//  MCuisinePickerController.m
//  Menu
//
//  Created by Abbin Varghese on 08/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MCuisinePickerController.h"
#import "MConstants.h"
#import <Parse/Parse.h>
#import "MRemoteConfig.h"
#import "MTextFieldAlertController.h"

@interface MCuisinePickerController ()<UISearchBarDelegate>

@property (nonatomic, strong) void(^completionHandler)(MCuisine *);

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) PFQuery *cuisineQuery;

@end

@implementation MCuisinePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = kMCuisineClassNameKey;
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        self.objectsPerPage = 100;
        
        self.cuisineQuery = [PFQuery queryWithClassName:self.parseClassName];
    }
    
    return self;
}

- (PFQuery *)queryForTable {
    [self.cuisineQuery cancel];
    
    if (self.objects.count == 0) {
        self.cuisineQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [self.cuisineQuery orderByAscending:kMCuisineNameKey];
    
    if (self.searchBar.text.length>0) {
        NSArray* words = [self.searchBar.text componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString* trimmedString = [words componentsJoinedByString:@""];
        NSString *lowString = [trimmedString lowercaseString];
        
        [self.cuisineQuery whereKey:kMCuisineNameKey hasPrefix:lowString];
    }
    else{
        self.cuisineQuery = [PFQuery queryWithClassName:self.parseClassName];
        
        [self.cuisineQuery cancel];
        
        if (self.objects.count == 0) {
            self.cuisineQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
        }
        
        [self.cuisineQuery orderByAscending:kMCuisineNameKey];
    }
    
    return self.cuisineQuery;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self loadObjects];
}
- (IBAction)cancel:(id)sender {
    [self.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(MCuisine *)object{
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFTableViewCell"];
    cell.textLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    cell.textLabel.text = object.cuisineName;
    return cell;
}

- (IBAction)addNewCuisine:(id)sender {
    MTextFieldAlertController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MTextFieldAlertController"];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.titleString = @"New +";
    vc.messageString = @"Add a new cuisine to our database";
    [vc withCompletionHandler:^(MCuisine *cuisine) {
        [self dismissViewControllerAnimated:YES completion:^{
            _completionHandler(cuisine);
        }];
    }];
    [self presentViewController:vc animated:NO completion:nil];
    
};

-(void)withCompletionHandler:(void(^)(MCuisine *cuisine))handler{
    _completionHandler = handler;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:^{
        _completionHandler([self.objects objectAtIndex:indexPath.row]);
    }];
}

@end

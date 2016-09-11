//
//  MLocationPickerController.m
//  Menu
//
//  Created by Abbin Varghese on 09/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MLocationPickerController.h"
#import "AFNetworking.h"
#import "MConstants.h"
#import "NSMutableDictionary+MLocation.h"

@interface MLocationPickerController ()<UISearchBarDelegate>

@property (nonatomic, strong) void(^completionHandler)(NSMutableDictionary *);
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSURLSessionDataTask *dataTask;
@property (strong, nonatomic) NSArray *locArray;
@property (weak, nonatomic) IBOutlet UITableView *locTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation MLocationPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)cancel:(id)sender {
    [self.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

-(void)withCompletionHandler:(void(^)(NSMutableDictionary *location))handler{
    _completionHandler = handler;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.dataTask cancel];
    if (searchText.length>0) {
        NSArray* words = [searchText componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString* nospacestring = [words componentsJoinedByString:@""];
        
        NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
        NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=(cities)&components=country:%@&key=%@",nospacestring,countryCode,kMGoogleServerKey];
        NSURL *URL = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [self.activityIndicator startAnimating];
        self.dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (!error) {
                [self.activityIndicator stopAnimating];
                self.locArray = responseObject[@"predictions"];
                [self.locTableView reloadData];
            }
            else{
                if (error.code != -999) {
                    [self.activityIndicator stopAnimating];
                }
            }
        }];
        [self.dataTask resume];

    }
    else{
        self.locArray = nil;
        [self.locTableView reloadData];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.locArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if ([[self.locArray objectAtIndex:indexPath.row] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = [self.locArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [[[dict objectForKey:@"terms"] firstObject]objectForKey:@"value"];
        @try {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",[[[dict objectForKey:@"terms"] objectAtIndex:1] objectForKey:@"value"],[[[dict objectForKey:@"terms"] objectAtIndex:2] objectForKey:@"value"]];
        } @catch (NSException *exception) {
            @try {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[[[dict objectForKey:@"terms"] objectAtIndex:1] objectForKey:@"value"]];
            } @catch (NSException *exception) {
                cell.detailTextLabel.text = @"";
            }
        }
    }
    else{
        NSString *string = [self.locArray objectAtIndex:indexPath.row];
        cell.textLabel.text = string;
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.searchBar resignFirstResponder];
    
    NSString *placeID = [[self.locArray objectAtIndex:indexPath.row] objectForKey:@"place_id"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",placeID,kMGoogleServerKey];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    self.dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            NSMutableDictionary *location = [[NSMutableDictionary alloc]initLocationWithDictionary:[responseObject objectForKey:@"result"]];
            [self dismissViewControllerAnimated:YES completion:^{
                _completionHandler(location);
            }];
        }
    }];
    [self.dataTask resume];
}

@end

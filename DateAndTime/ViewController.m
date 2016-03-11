//
//  ViewController.m
//  DateAndTime
//
//  Created by Jennifer A Sipila on 3/5/16.
//  Copyright © 2016 Jennifer A Sipila. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *NYCLabel;

@property (weak, nonatomic) IBOutlet UIButton *parisLabel;

@property (weak, nonatomic) IBOutlet UIButton *moscowLabel;

@property (weak, nonatomic) IBOutlet UIButton *hongKongLabel;

@property (weak, nonatomic) IBOutlet UIButton *honoluluLabel;

@property (weak, nonatomic) IBOutlet UIButton *seattleLabel;

@property(nonatomic, strong)NSArray *labels;

@property(nonatomic, strong)NSDateComponents *components;

//Labels for UI

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@property(strong, nonatomic)NSArray *dateAndTime;

@property(strong, nonatomic)NSArray *dateAndTimeStrings;


@property(strong, nonatomic)NSTimer * timer;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.labels = @[self.NYCLabel, self.parisLabel, self.moscowLabel, self.hongKongLabel, self.honoluluLabel, self.seattleLabel];
    
    for (UIButton *button in self.labels)
    {
        UIColor *customBlue = [UIColor colorWithRed:0.0 green:200.0 blue:235.0 alpha:1.0];
        
        [button setTitleColor:customBlue forState:UIControlStateNormal];
        
        
        //[button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        
    }

    [self.NYCLabel setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    NSLog(@"timezones: %@", [NSTimeZone abbreviationDictionary]);
    
    [self.NYCLabel sendActionsForControlEvents: UIControlEventTouchUpInside]; //Artificially touches button.
    
    
}


-(NSArray *)getCurrentDateAndTimeWithFormattingForTimeZone: (NSString *)timeZone
{
    //NSString *timeZoneAbreviation = @"GMT";
    
    //Formatter, Locale & Time Zone For Date and Time.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSTimeZone *localTimeZone = [NSTimeZone timeZoneWithAbbreviation:timeZone];
    
    
    [dateFormatter setLocale:posix];
    [dateFormatter setDateFormat:@"EEEE MMMM dd y"];
    [dateFormatter setTimeZone:localTimeZone];
    
    [timeFormatter setLocale:posix];
    [timeFormatter setDateFormat:@"h:mm:ss a"];
    [timeFormatter setTimeZone:localTimeZone];
    
    
    //NSDate point in time.
    NSDate *now = [NSDate date];
    
    NSString *date = [dateFormatter stringFromDate:now];
    
    NSString *time = [timeFormatter stringFromDate:now];
    
    NSLog(@"%@", date);
    NSLog(@"%@", time);
    
    self.dateAndTimeStrings = @[date, time];

    
    return self.dateAndTimeStrings;
    
    
}


- (IBAction)newYorkCityButton:(id)sender
{
    
    
    [self.timer invalidate];
    self.timer = nil;
    
    
    
    [self setAllLabelsToBlueExceptSelected:self.NYCLabel];
    
    NSArray *newYorkDateAndTimeStrings = [self getCurrentDateAndTimeWithFormattingForTimeZone: @"EDT"];
    
    self.dateAndTimeStrings = newYorkDateAndTimeStrings;
    
    
    
    self.timeLabel.text = newYorkDateAndTimeStrings[1];
    
    self.dateLabel.text = newYorkDateAndTimeStrings[0];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(newYorkCityButton:) userInfo:nil repeats:YES];
    
    
}
- (IBAction)parisButton:(id)sender
{
    
    [self.timer invalidate];
    self.timer = nil;

    
    
    [self setAllLabelsToBlueExceptSelected:self.parisLabel];
    
    
    NSArray *parisDateAndTimeStrings = [self getCurrentDateAndTimeWithFormattingForTimeZone: @"CEST"];
    
    self.timeLabel.text = parisDateAndTimeStrings[1];
    
    self.dateLabel.text = parisDateAndTimeStrings[0];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(parisButton:) userInfo:nil repeats:YES];

}


- (IBAction)moscowButton:(id)sender
{
    [self.timer invalidate];
    self.timer = nil;

    
    [self setAllLabelsToBlueExceptSelected:self.moscowLabel];
    
    NSArray *moscowDateAndTimeStrings = [self getCurrentDateAndTimeWithFormattingForTimeZone: @"MSD"];
    
    self.timeLabel.text = moscowDateAndTimeStrings[1];
    
    self.dateLabel.text = moscowDateAndTimeStrings[0];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(moscowButton:) userInfo:nil repeats:YES];
    
}


- (IBAction)hongKongButton:(id)sender
{
    [self.timer invalidate];
    self.timer = nil;


    [self setAllLabelsToBlueExceptSelected:self.hongKongLabel];
    
    NSArray *hongKongDateAndTimeStrings = [self getCurrentDateAndTimeWithFormattingForTimeZone: @"HKT"];
    
    self.timeLabel.text = hongKongDateAndTimeStrings[1];
    
    self.dateLabel.text = hongKongDateAndTimeStrings[0];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(hongKongButton:) userInfo:nil repeats:YES];
    
    
}


- (IBAction)honoluluButton:(id)sender
{
    [self.timer invalidate];
    self.timer = nil;


    [self setAllLabelsToBlueExceptSelected:self.honoluluLabel];
    
    NSArray *honoluluDateAndTimeStrings = [self getCurrentDateAndTimeWithFormattingForTimeZone: @"HST"];
    
    self.timeLabel.text = honoluluDateAndTimeStrings[1];
    
    self.dateLabel.text = honoluluDateAndTimeStrings[0];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(honoluluButton:) userInfo:nil repeats:YES];
    
    
}


- (IBAction)seattleButton:(id)sender
{
    [self.timer invalidate];
    self.timer = nil;

    [self setAllLabelsToBlueExceptSelected:self.seattleLabel];
    
    NSArray *seattleDateAndTimeStrings = [self getCurrentDateAndTimeWithFormattingForTimeZone: @"PST"];
    
    self.timeLabel.text = seattleDateAndTimeStrings[1];
    
    self.dateLabel.text = seattleDateAndTimeStrings[0];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(seattleButton:) userInfo:nil repeats:YES];
    
}


-(void)setAllLabelsToBlueExceptSelected:(UIButton *) buttonLabel
{
    
    for (UIButton *button in self.labels)
    {
        UIColor *customBlue = [UIColor colorWithRed:0.0 green:200.0 blue:235.0 alpha:1.0];
        
        [button setTitleColor:customBlue forState:UIControlStateNormal];
    }
    
    [buttonLabel setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
}


@end

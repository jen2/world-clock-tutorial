//
//  ViewController.m
//  DateAndTime
//
//  Created by Jennifer A Sipila on 3/5/16.
//  Copyright © 2016 Jennifer A Sipila. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *nyc;
@property (nonatomic, weak) IBOutlet UIButton *paris;
@property (nonatomic, weak) IBOutlet UIButton *moscow;
@property (nonatomic, weak) IBOutlet UIButton *hongKong;
@property (nonatomic, weak) IBOutlet UIButton *honolulu;
@property (nonatomic, weak) IBOutlet UIButton *seattle;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@property(nonatomic, strong)NSString *timeZone;
@property(nonatomic, strong)UIButton *selectedButton;
@property(nonatomic, strong)NSTimer * timer;

@end

@implementation ViewController
    - (void)viewDidLoad {
        [super viewDidLoad];
        [self.nyc sendActionsForControlEvents: UIControlEventTouchUpInside];
        [self highlightSelected];
    }

    -(IBAction)cityButtonTapped:(UIButton *)sender {
        switch (sender.tag) {
            case 100:
                self.timeZone = @"EST";
                self.selectedButton = self.nyc;
                break;
                
            case 101:
                self.timeZone = @"CEST";
                self.selectedButton = self.paris;
                break;
                
            case 102:
                self.timeZone = @"MSD";
                self.selectedButton = self.moscow;
                break;
                
            case 103:
                self.timeZone = @"HKT";
                self.selectedButton = self.hongKong;
                break;
                
            case 104:
                self.timeZone = @"HST";
                self.selectedButton = self.honolulu;
                break;
                
            case 105:
                self.timeZone = @"PST";
                self.selectedButton = self.seattle;
                break;
                
            default:
                self.timeZone = @"EST";
                self.selectedButton = self.nyc;
                break;
        }
        [self setTappedCityTimer];
    }

    -(void)setTappedCityTimer {
        [self.timer invalidate];
        self.timer = nil;
        
        [self highlightSelected];
        [self unhighlightDeselected];
        
        [self setDateTimeLabelsWithTimeZone];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setDateTimeLabelsWithTimeZone) userInfo:nil repeats:YES];
    }

    -(void)setDateTimeLabelsWithTimeZone {
        NSArray *dateAndTime = [self formatCurrentDateTimeForTimeZone];
        self.timeLabel.text = dateAndTime[1];
        self.dateLabel.text = dateAndTime[0];
    }

     -(NSArray *)formatCurrentDateTimeForTimeZone {
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
         NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
         NSTimeZone *localTimeZone = [NSTimeZone timeZoneWithAbbreviation:self.timeZone];
         [dateFormatter setLocale:posix];
         [dateFormatter setDateFormat:@"EEEE MMMM dd y"];
         [dateFormatter setTimeZone:localTimeZone];
         [timeFormatter setLocale:posix];
         [timeFormatter setDateFormat:@"h:mm:ss a"];
         [timeFormatter setTimeZone:localTimeZone];
         
         NSDate *now = [NSDate date];
         NSString *date = [dateFormatter stringFromDate:now];
         NSString *time = [timeFormatter stringFromDate:now];
         
         NSArray *formattedDateAndTime = @[date, time];
         return formattedDateAndTime;
     }

    - (void)highlightSelected {
        self.selectedButton.tintColor = [UIColor yellowColor];
    }

    -(void)unhighlightDeselected {
        NSArray *cities = [@[self.nyc, self.paris, self.moscow, self.hongKong, self.honolulu, self.seattle]mutableCopy];
        NSMutableArray *unselectedCities = [NSMutableArray array];
        
        for (UIButton *city in cities) {
            if (city != self.selectedButton) {
                [unselectedCities addObject:city];
            }
        }
        [unselectedCities setValue:[UIColor blueColor] forKey:@"tintColor"];
    }
        
@end

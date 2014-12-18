#import <SpringBoard/SBAlertItem.h>
#import <SpringBoard/SBAlertItemsController.h>
#import <SpringBoard/SBUserNotificationAlert.h>

static NSString * CELLULAR_DATA_IS_TURNED_OFF_FOR_APP_NAME_string = nil;

%hook SBAlertItemsController

- (void) activateAlertItem:(id)alert {
    if ([alert isKindOfClass:[%c(SBLaunchAlertItem) class]]) {
        int _type = MSHookIvar<int>(alert, "_type");
        char _isDataAlert = MSHookIvar<char>(alert, "_isDataAlert");
        char _usesCellNetwork = MSHookIvar<char>(alert, "_usesCellNetwork");
        if (_type == 1) {
            BOOL cellPrompt = (_isDataAlert != 0 && _usesCellNetwork != 0);
            BOOL dataPrompt = (_isDataAlert != 0 && _usesCellNetwork != 1);
            if (cellPrompt || dataPrompt) {
                [self deactivateAlertItem:alert];
                return;
                
            }
            
        }
    }
    if ([alert isKindOfClass:[%c(SBUserNotificationAlert) class]]) {
        if ([[alert alertMessage] isEqual:CELLULAR_DATA_IS_TURNED_OFF_FOR_APP_NAME_string]) {
            [self deactivateAlertItem:alert];
            return;
        }
    }
    %orig;
}

%end

%ctor {
    NSBundle * carrierBundle = [[NSBundle alloc] initWithPath:@"/var/mobile/Library/CarrierDefault.bundle"];
    
    if (carrierBundle) {
        
        CELLULAR_DATA_IS_TURNED_OFF_FOR_APP_NAME_string = [[carrierBundle localizedStringForKey:@"YOU_CAN_TURN_ON_CELLULAR_DATA_FOR_THIS_APP_IN_SETTINGS" value:@"" table:@"DataUsage"] retain];
        
        [carrierBundle release];
        
    }
}
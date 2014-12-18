#line 1 "/Users/Zheng/Projects/NoCellularAlert/NoCellularAlert/NoCellularAlert.xm"
#import <SpringBoard/SBAlertItem.h>
#import <SpringBoard/SBAlertItemsController.h>
#import <SpringBoard/SBUserNotificationAlert.h>

static NSString * CELLULAR_DATA_IS_TURNED_OFF_FOR_APP_NAME_string = nil;

#include <logos/logos.h>
#include <substrate.h>
@class SBUserNotificationAlert; @class SBLaunchAlertItem; @class SBAlertItemsController; 
static void (*_logos_orig$_ungrouped$SBAlertItemsController$activateAlertItem$)(SBAlertItemsController*, SEL, id); static void _logos_method$_ungrouped$SBAlertItemsController$activateAlertItem$(SBAlertItemsController*, SEL, id); 
static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$SBUserNotificationAlert(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBUserNotificationAlert"); } return _klass; }static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$SBLaunchAlertItem(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBLaunchAlertItem"); } return _klass; }
#line 7 "/Users/Zheng/Projects/NoCellularAlert/NoCellularAlert/NoCellularAlert.xm"


static void _logos_method$_ungrouped$SBAlertItemsController$activateAlertItem$(SBAlertItemsController* self, SEL _cmd, id alert) {
    if ([alert isKindOfClass:[_logos_static_class_lookup$SBLaunchAlertItem() class]]) {
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
    if ([alert isKindOfClass:[_logos_static_class_lookup$SBUserNotificationAlert() class]]) {
        if ([[alert alertMessage] isEqual:CELLULAR_DATA_IS_TURNED_OFF_FOR_APP_NAME_string]) {
            [self deactivateAlertItem:alert];
            return;
        }
    }
    _logos_orig$_ungrouped$SBAlertItemsController$activateAlertItem$(self, _cmd, alert);
}



static __attribute__((constructor)) void _logosLocalCtor_e1bc82cf() {
    NSBundle * carrierBundle = [[NSBundle alloc] initWithPath:@"/var/mobile/Library/CarrierDefault.bundle"];
    
    if (carrierBundle) {
        
        CELLULAR_DATA_IS_TURNED_OFF_FOR_APP_NAME_string = [[carrierBundle localizedStringForKey:@"YOU_CAN_TURN_ON_CELLULAR_DATA_FOR_THIS_APP_IN_SETTINGS" value:@"" table:@"DataUsage"] retain];
        
        [carrierBundle release];
        
    }
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBAlertItemsController = objc_getClass("SBAlertItemsController"); MSHookMessageEx(_logos_class$_ungrouped$SBAlertItemsController, @selector(activateAlertItem:), (IMP)&_logos_method$_ungrouped$SBAlertItemsController$activateAlertItem$, (IMP*)&_logos_orig$_ungrouped$SBAlertItemsController$activateAlertItem$);} }
#line 47 "/Users/Zheng/Projects/NoCellularAlert/NoCellularAlert/NoCellularAlert.xm"

#import "SlerverPlugin.h"
#if __has_include(<slerver/slerver-Swift.h>)
#import <slerver/slerver-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "slerver-Swift.h"
#endif

@implementation SlerverPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSlerverPlugin registerWithRegistrar:registrar];
}
@end

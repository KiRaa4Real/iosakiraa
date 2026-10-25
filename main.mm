#import <UIKit/UIKit.h>
#include "GameStructs.h"

// មុខងារនេះនឹងរត់ស្វ័យប្រវត្តិពេល dylib ត្រូវបាន Load ចូលហ្គេម
__attribute__((constructor)) void initializer() {
    // หน่วงពេលបន្តិចចាំបង្ហាញ Menu ពេលចូលហ្គេមក្នុងរង្វង់ ៣ វិនាទី
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // สร้างផ្ទាំង Menu (Alert Popup) បង្ហាញលើអេក្រង់ iPhone
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Roskira Mod Menu"
                                                                        message:@"Mod Loaded Successfully! (Offsets Ready)"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
        
        // ប៊ូតុងបិទ/បើក ឬប៊ូតុង OK
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // ទីនេះអាចដាក់ Logic បន្ថែមពេលចុច OK
        }];
        
        [alert addAction:okAction];
        
        // បង្ហាញផ្ទាំង Menu លើអេក្រង់ហ្គេម
        UIViewController *rootVC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        [rootVC presentViewController:alert animated:YES completion:nil];
        
    });
}

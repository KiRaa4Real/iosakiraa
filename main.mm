#import <UIKit/UIKit.h>
#include "GameStructs.h"

// ស្ថានភាពមុខងារ (Toggle States)
bool isNoRecoilEnabled = false;
bool isSpeedEnabled = false;
bool isEspEnabled = false;

@interface ModMenuViewController : UIViewController
@property (nonatomic, strong) UIView *menuView;
@end

@implementation ModMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ផ្ទាំង Menu ធំ (Floating Panel)
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(40, 60, 340, 260)];
    self.menuView.backgroundColor = [UIColor colorWithRed:0.10 green:0.10 blue:0.14 alpha:0.95];
    self.menuView.layer.cornerRadius = 14.0f;
    self.menuView.layer.borderColor = [UIColor systemPinkColor].CGColor;
    self.menuView.layer.borderWidth = 2.5f;
    self.menuView.clipsToBounds = YES;
    
    // ផ្លាកចំណងជើង (Title)
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 320, 30)];
    titleLabel.text = @"🔥 ROSKIRA VIP MOD 🔥";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.menuView addSubview:titleLabel];
    
    // --- មុខងារទី ១៖ NO RECOIL ---
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 200, 30)];
    lbl1.text = @"NO RECOIL 100%";
    lbl1.textColor = [UIColor whiteColor];
    lbl1.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    
    UISwitch *sw1 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 60, 0, 0)];
    [sw1 setOn:isNoRecoilEnabled];
    [sw1 addTarget:self action:@selector(toggleNoRecoil:) forControlEvents:UIControlEventValueChanged];
    
    // --- មុខងារទី ២៖ SPEED HACK ---
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 200, 30)];
    lbl2.text = @"SPEED HACK";
    lbl2.textColor = [UIColor whiteColor];
    lbl2.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    
    UISwitch *sw2 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 110, 0, 0)];
    [sw2 setOn:isSpeedEnabled];
    [sw2 addTarget:self action:@selector(toggleSpeed:) forControlEvents:UIControlEventValueChanged];
    
    // --- មុខងារទី ៣៖ ESP BOX ---
    UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 200, 30)];
    lbl3.text = @"ESP PLAYER";
    lbl3.textColor = [UIColor whiteColor];
    lbl3.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    
    UISwitch *sw3 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 160, 0, 0)];
    [sw3 setOn:isEspEnabled];
    [sw3 addTarget:self action:@selector(toggleEsp:) forControlEvents:UIControlEventValueChanged];
    
    // ប៊ូតុងបិទផ្ទាំង (Close Button)
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    closeBtn.frame = CGRectMake(90, 210, 160, 35);
    [closeBtn setTitle:@"MINIMIZE / CLOSE" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    closeBtn.backgroundColor = [UIColor systemRedColor];
    closeBtn.layer.cornerRadius = 8.0f;
    [closeBtn addTarget:self action:@selector(closeMenu) forControlEvents:UIControlEventTouchUpInside];
    
    // បញ្ចូលបنگیComponents ទាំងអស់ចូល View
    [self.menuView addSubview:lbl1]; [self.menuView addSubview:sw1];
    [self.menuView addSubview:lbl2]; [self.menuView addSubview:sw2];
    [self.menuView addSubview:lbl3]; [self.menuView addSubview:sw3];
    [self.menuView addSubview:closeBtn];
    
    [self.view addSubview:self.menuView];
}

- (void)toggleNoRecoil:(UISwitch *)sender { isNoRecoilEnabled = sender.isOn; }
- (void)toggleSpeed:(UISwitch *)sender { isSpeedEnabled = sender.isOn; }
- (void)toggleEsp:(UISwitch *)sender { isEspEnabled = sender.isOn; }

- (void)closeMenu {
    self.view.window.hidden = YES;
}

@end

// បង្កើត Window ដាច់ដោយឡែកសម្រាប់ Menu
UIWindow *modWindow = nil;

void ShowFloatingMenu() {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!modWindow) {
            UIWindowScene *scene = (UIWindowScene *)[[[UIApplication sharedApplication] connectedScenes] allObjects].firstObject;
            if (scene) {
                modWindow = [[UIWindow alloc] initWithWindowScene:scene];
            } else {
                modWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            }
            modWindow.windowLevel = UIWindowLevelAlert + 1;
            modWindow.rootViewController = [[ModMenuViewController alloc] init];
        }
        modWindow.hidden = NO;
        [modWindow makeKeyAndVisible];
    });
}

// មុខងាររត់ស្វ័យប្រវត្តិពេល Load dylib ចូលហ្គេម
__attribute__((constructor)) void initializer() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ShowFloatingMenu();
    });
}

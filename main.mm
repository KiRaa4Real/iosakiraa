#import <UIKit/UIKit.h>
#import "GameStructs.h"
#include <mach-o/dyld.h>

// ស្ថានភាពមុខងារ (Toggle States)
bool isSpeedBuffEnabled = false;
bool isNearbyBuffEnabled = false;
bool isNoRecoilEnabled = false;

@class ModMenuWindow;

@interface ModMenuViewController : UIViewController
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIButton *floatingBtn;
@end

// Custom Window សម្រាប់ Pass-through Touch ទៅហ្គេម ១០០%
@interface ModMenuWindow : UIWindow
@property (nonatomic, strong) ModMenuViewController *menuVC;
@end

@implementation ModMenuWindow
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.menuVC.menuView.hidden && [self.menuVC.menuView pointInside:[self convertPoint:point toView:self.menuVC.menuView] withEvent:event]) {
        return YES;
    }
    if (!self.menuVC.floatingBtn.hidden && [self.menuVC.floatingBtn pointInside:[self convertPoint:point toView:self.menuVC.floatingBtn] withEvent:event]) {
        return YES;
    }
    return NO;
}
@end

@implementation ModMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    // ១. ផ្ទាំង Menu ធំ (Floating Panel) - កម្ពស់ 270 សម្រាប់ ៣ មុខងារ
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(40, 60, 340, 270)];
    self.menuView.backgroundColor = [UIColor colorWithRed:0.10 green:0.10 blue:0.14 alpha:0.95];
    self.menuView.layer.cornerRadius = 14.0f;
    self.menuView.layer.borderColor = [UIColor systemPinkColor].CGColor;
    self.menuView.layer.borderWidth = 2.5f;
    self.menuView.clipsToBounds = YES;
    
    // ចងជើង (Title)
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 320, 30)];
    titleLabel.text = @"🔥 ROSKIRA VIP MOD 🔥";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.menuView addSubview:titleLabel];
    
    // --- មុខងារទី ១៖ SPEED BUFF ---
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 55, 200, 25)];
    lbl1.text = @"SPEED BUFF";
    lbl1.textColor = [UIColor yellowColor];
    lbl1.font = [UIFont systemFontOfSize:13 weight:UIFontWeightBold];
    
    UISwitch *sw1 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 55, 0, 0)];
    [sw1 setOn:isSpeedBuffEnabled];
    [sw1 addTarget:self action:@selector(toggleSpeedBuff:) forControlEvents:UIControlEventValueChanged];

    // --- មុខងារទី ២៖ NEARBY BUFF ---
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 95, 200, 25)];
    lbl2.text = @"NEARBY BUFF";
    lbl2.textColor = [UIColor cyanColor];
    lbl2.font = [UIFont systemFontOfSize:13 weight:UIFontWeightBold];
    
    UISwitch *sw2 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 95, 0, 0)];
    [sw2 setOn:isNearbyBuffEnabled];
    [sw2 addTarget:self action:@selector(toggleNearbyBuff:) forControlEvents:UIControlEventValueChanged];

    // --- មុខងារទី ៣៖ NO RECOIL 100 ---
    UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 135, 200, 25)];
    lbl3.text = @"NO RECOIL 100";
    lbl3.textColor = [UIColor greenColor];
    lbl3.font = [UIFont systemFontOfSize:13 weight:UIFontWeightBold];
    
    UISwitch *sw3 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 135, 0, 0)];
    [sw3 setOn:isNoRecoilEnabled];
    [sw3 addTarget:self action:@selector(toggleNoRecoil:) forControlEvents:UIControlEventValueChanged];
    
    // ប៊ូតុង Minimize / Close
    UIButton *minimizeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    minimizeBtn.frame = CGRectMake(90, 190, 160, 35);
    [minimizeBtn setTitle:@"MINIMIZE / CLOSE" forState:UIControlStateNormal];
    [minimizeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    minimizeBtn.backgroundColor = [UIColor systemRedColor];
    minimizeBtn.layer.cornerRadius = 8.0f;
    [minimizeBtn addTarget:self action:@selector(minimizeMenu) forControlEvents:UIControlEventTouchUpInside];
    
    // បញ្ចូល Components ទាំងអស់ចូល Menu
    [self.menuView addSubview:lbl1]; [self.menuView addSubview:sw1];
    [self.menuView addSubview:lbl2]; [self.menuView addSubview:sw2];
    [self.menuView addSubview:lbl3]; [self.menuView addSubview:sw3];
    [self.menuView addSubview:minimizeBtn];
    
    // ២. ប៊ូតុងអណ្តែតតូច (Floating Button)
    self.floatingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.floatingBtn.frame = CGRectMake(20, 120, 50, 50);
    self.floatingBtn.backgroundColor = [UIColor systemPinkColor];
    [self.floatingBtn setTitle:@"ROS" forState:UIControlStateNormal];
    [self.floatingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.floatingBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.floatingBtn.layer.cornerRadius = 25.0f;
    self.floatingBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    self.floatingBtn.layer.shadowOffset = CGSizeMake(0, 2);
    self.floatingBtn.layer.shadowOpacity = 0.6f;
    self.floatingBtn.layer.shadowRadius = 4.0f;
    [self.floatingBtn addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    self.floatingBtn.hidden = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.floatingBtn addGestureRecognizer:pan];
    
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.floatingBtn];
}

// 🟢 Speed Buff Action
- (void)toggleSpeedBuff:(UISwitch *)sender {
    isSpeedBuffEnabled = sender.isOn;
    uint64_t slide = _dyld_get_image_vmaddr_slide(0);
    if (slide > 0 && isSpeedBuffEnabled) {
        double val = boostSpeedBuff; // 1.51709e+09
        // កូដសរសេរចូល Memory ហ្គេមត្រង់នេះ
    }
}

// 🟢 Nearby Buff Action
- (void)toggleNearbyBuff:(UISwitch *)sender {
    isNearbyBuffEnabled = sender.isOn;
    if (isNearbyBuffEnabled) {
        Nearby = 20.0; // បងអាចកែជា 5.0, 10.0 ឬ 20.0 តាមតម្រូវការ
    } else {
        Nearby = 1.1;
    }
}

// 🟢 No Recoil 100 Action
- (void)toggleNoRecoil:(UISwitch *)sender {
    isNoRecoilEnabled = sender.isOn;
    uint64_t slide = _dyld_get_image_vmaddr_slide(0);
    if (slide > 0) {
        if (isNoRecoilEnabled) {
            double numVal = noRecoilNum;       // -10.0
            double nbF64  = noRecoilNearbyF64; // 1000.0
            float nbF32   = noRecoilNearbyF32; // 1.875
            float target  = noRecoilTarget;    // 0.0
            
            // កូដសរសេរចូល Memory តាម NO_RECOIL_OFFSET (0x100) ត្រង់នេះ
        } else {
            // ពេលបិទ ដាក់តម្លៃដើមវិញ
        }
    }
}

- (void)minimizeMenu {
    self.menuView.hidden = YES;
    self.floatingBtn.hidden = NO;
}

- (void)openMenu {
    self.menuView.hidden = NO;
    self.floatingBtn.hidden = YES;
}

- (void)handlePan:(UIPanGestureRecognizer * _Nonnull)gesture {
    CGPoint translation = [gesture translationInView:self.view];
    CGPoint center = gesture.view.center;
    gesture.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
    [gesture setTranslation:CGPointZero inView:self.view];
}

@end

ModMenuWindow *modWindow = nil;

void ShowFloatingMenu() {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!modWindow) {
            UIWindowScene *scene = (UIWindowScene *)[[[UIApplication sharedApplication] connectedScenes] allObjects].firstObject;
            ModMenuViewController *vc = [[ModMenuViewController alloc] init];
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            if (scene) {
                modWindow = [[ModMenuWindow alloc] initWithWindowScene:scene];
            } else {
                modWindow = [[ModMenuWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            }
#pragma clang diagnostic pop

            modWindow.menuVC = vc;
            modWindow.windowLevel = UIWindowLevelAlert + 1;
            modWindow.rootViewController = vc;
            modWindow.backgroundColor = [UIColor clearColor];
        }
        modWindow.hidden = NO;
        [modWindow makeKeyAndVisible];
    });
}

__attribute__((constructor)) void initializer() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ShowFloatingMenu();
    });
}

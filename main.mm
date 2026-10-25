#import <UIKit/UIKit.h>
#import "GameStructs.h"

// ស្ថានភាពមុខងារ (Toggle States)
bool isNoRecoilEnabled = false;
bool isSpeedEnabled = false;
bool isEspEnabled = false;
bool isAimbotEnabled = false;
bool isSpeedBuffEnabled = false;
bool isNearbyBuffEnabled = false;

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
    
    // ១. ផ្ទាំង Menu ធំ (Floating Panel) - កម្ពស់ 380 សម្រាប់ដាក់គ្រប់មុខងារ
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(40, 60, 340, 380)];
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
    
    // --- មុខងារទី ១៖ NO RECOIL ---
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 200, 25)];
    lbl1.text = @"NO RECOIL 100%";
    lbl1.textColor = [UIColor whiteColor];
    lbl1.font = [UIFont systemFontOfSize:13 weight:UIFontWeightBold];
    
    UISwitch *sw1 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 50, 0, 0)];
    [sw1 setOn:isNoRecoilEnabled];
    [sw1 addTarget:self action:@selector(toggleNoRecoil:) forControlEvents:UIControlEventValueChanged];
    
    // --- មុខងារទី ២៖ SPEED HACK ---
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 200, 25)];
    lbl2.text = @"SPEED HACK";
    lbl2.textColor = [UIColor whiteColor];
    lbl2.font = [UIFont systemFontOfSize:13 weight:UIFontWeightBold];
    
    UISwitch *sw2 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 90, 0, 0)];
    [sw2 setOn:isSpeedEnabled];
    [sw2 addTarget:self action:@selector(toggleSpeed:) forControlEvents:UIControlEventValueChanged];
    
    // --- មុខងារទី ៣៖ ESP PLAYER ---
    UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 200, 25)];
    lbl3.text = @"ESP PLAYER";
    lbl3.textColor = [UIColor whiteColor];
    lbl3.font = [UIFont systemFontOfSize:13 weight:UIFontWeightBold];
    
    UISwitch *sw3 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 130, 0, 0)];
    [sw3 setOn:isEspEnabled];
    [sw3 addTarget:self action:@selector(toggleEsp:) forControlEvents:UIControlEventValueChanged];
    
    // --- មុខងារទី ៤៖ AIMBOT ---
    UILabel *lbl4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 200, 25)];
    lbl4.text = @"AIMBOT 360";
    lbl4.textColor = [UIColor whiteColor];
    lbl4.font = [UIFont systemFontOfSize:13 weight:UIFontWeightBold];
    
    UISwitch *sw4 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 170, 0, 0)];
    [sw4 setOn:isAimbotEnabled];
    [sw4 addTarget:self action:@selector(toggleAimbot:) forControlEvents:UIControlEventValueChanged];
    
    // --- មុខងារទី ៥៖ SPEED BUFF (boostSpeedBuff) ---
    UILabel *lbl5 = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, 200, 25)];
    lbl5.text = @"SPEED BUFF";
    lbl5.textColor = [UIColor yellowColor];
    lbl5.font = [UIFont systemFontOfSize:13 weight:UIFontWeightBold];
    
    UISwitch *sw5 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 210, 0, 0)];
    [sw5 setOn:isSpeedBuffEnabled];
    [sw5 addTarget:self action:@selector(toggleSpeedBuff:) forControlEvents:UIControlEventValueChanged];

    // --- មុខងារទី ៦៖ NEARBY BUFF (Nearby = 5/10/20) ---
    UILabel *lbl6 = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, 200, 25)];
    lbl6.text = @"NEARBY BUFF";
    lbl6.textColor = [UIColor cyanColor];
    lbl6.font = [UIFont systemFontOfSize:13 weight:UIFontWeightBold];
    
    UISwitch *sw6 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 250, 0, 0)];
    [sw6 setOn:isNearbyBuffEnabled];
    [sw6 addTarget:self action:@selector(toggleNearbyBuff:) forControlEvents:UIControlEventValueChanged];
    
    // ប៊ូតុង Minimize / Close
    UIButton *minimizeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    minimizeBtn.frame = CGRectMake(90, 305, 160, 35);
    [minimizeBtn setTitle:@"MINIMIZE / CLOSE" forState:UIControlStateNormal];
    [minimizeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    minimizeBtn.backgroundColor = [UIColor systemRedColor];
    minimizeBtn.layer.cornerRadius = 8.0f;
    [minimizeBtn addTarget:self action:@selector(minimizeMenu) forControlEvents:UIControlEventTouchUpInside];
    
    // បញ្ចូល Components ទាំងអស់ចូល Menu
    [self.menuView addSubview:lbl1]; [self.menuView addSubview:sw1];
    [self.menuView addSubview:lbl2]; [self.menuView addSubview:sw2];
    [self.menuView addSubview:lbl3]; [self.menuView addSubview:sw3];
    [self.menuView addSubview:lbl4]; [self.menuView addSubview:sw4];
    [self.menuView addSubview:lbl5]; [self.menuView addSubview:sw5];
    [self.menuView addSubview:lbl6]; [self.menuView addSubview:sw6];
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

- (void)toggleNoRecoil:(UISwitch *)sender { isNoRecoilEnabled = sender.isOn; }
- (void)toggleSpeed:(UISwitch *)sender { isSpeedEnabled = sender.isOn; }
- (void)toggleEsp:(UISwitch *)sender { isEspEnabled = sender.isOn; }
- (void)toggleAimbot:(UISwitch *)sender { isAimbotEnabled = sender.isOn; }

// 🟢 Speed Buff Action (ហៅតម្លៃ boostSpeedBuff ពី GameStructs.h)
- (void)toggleSpeedBuff:(UISwitch *)sender {
    isSpeedBuffEnabled = sender.isOn;
    if (isSpeedBuffEnabled) {
        double activeSpeedBuff = boostSpeedBuff; // 1.51709e+09
        // ដាក់កូដសរសេរចូល Memory ហ្គេមទីនេះ
    } else {
        // តម្លៃដើមពេលបិទ
    }
}

// 🟢 Nearby Buff Action (ប្តូរតម្លៃ Nearby ពី 1.1 ទៅ 20 ឬ 5, 10)
- (void)toggleNearbyBuff:(UISwitch *)sender {
    isNearbyBuffEnabled = sender.isOn;
    if (isNearbyBuffEnabled) {
        Nearby = 20.0; // បងអាចប្តូរជា 5.0, 10.0 ឬ 20.0 តាមតម្រូវការ
    } else {
        Nearby = 1.1; // តម្លៃដើមវិញ
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
            if (scene) {
                modWindow = [[ModMenuWindow alloc] initWithWindowScene:scene];
            } else {
                modWindow = [[ModMenuWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            }
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

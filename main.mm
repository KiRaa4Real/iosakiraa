#import <UIKit/UIKit.h>
#include "GameStructs.h"

// ស្ថានភាពមុខងារ (Toggle States)
bool isNoRecoilEnabled = false;
bool isSpeedEnabled = false;
bool isEspEnabled = false;

@interface ModMenuViewController : UIViewController
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIButton *floatingBtn;
@end

@implementation ModMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    // ១. ផ្ទាំង Menu ធំ (Floating Panel)
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(40, 60, 340, 260)];
    self.menuView.backgroundColor = [UIColor colorWithRed:0.10 green:0.10 blue:0.14 alpha:0.95];
    self.menuView.layer.cornerRadius = 14.0f;
    self.menuView.layer.borderColor = [UIColor systemPinkColor].CGColor;
    self.menuView.layer.borderWidth = 2.5f;
    self.menuView.clipsToBounds = YES;
    
    // ចងជើង (Title)
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
    
    // --- មុខងារទី ៣៖ ESP PLAYER ---
    UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 200, 30)];
    lbl3.text = @"ESP PLAYER";
    lbl3.textColor = [UIColor whiteColor];
    lbl3.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    
    UISwitch *sw3 = [[UISwitch alloc] initWithFrame:CGRectMake(260, 160, 0, 0)];
    [sw3 setOn:isEspEnabled];
    [sw3 addTarget:self action:@selector(toggleEsp:) forControlEvents:UIControlEventValueChanged];
    
    // ប៊ូតុង Minimize / Close (លាក់ Menu ធំ ទុកប៊ូតុងតូច)
    UIButton *minimizeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    minimizeBtn.frame = CGRectMake(90, 210, 160, 35);
    [minimizeBtn setTitle:@"MINIMIZE / CLOSE" forState:UIControlStateNormal];
    [minimizeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    minimizeBtn.backgroundColor = [UIColor systemRedColor];
    minimizeBtn.layer.cornerRadius = 8.0f;
    [minimizeBtn addTarget:self action:@selector(minimizeMenu) forControlEvents:UIControlEventTouchUpInside];
    
    [self.menuView addSubview:lbl1]; [self.menuView addSubview:sw1];
    [self.menuView addSubview:lbl2]; [self.menuView addSubview:sw2];
    [self.menuView addSubview:lbl3]; [self.menuView addSubview:sw3];
    [self.menuView addSubview:minimizeBtn];
    
    // ២. ប៊ូតុងអណ្តែតតូច (Floating Button) សម្រាប់ចុចបើក Menu វិញ
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
    self.floatingBtn.hidden = YES; // ដំបូងបង្ហាញ Menu ធំ ដូច្នេះលាក់ប៊ូតុងតូចសិន
    
    // ដាក់ឱ្យប៊ូតុងតូចអាចអូសទាញ (Drag) ទៅមកលើអេក្រង់បាន
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.floatingBtn addGestureRecognizer:pan];
    
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.floatingBtn];
}

- (void)toggleNoRecoil:(UISwitch *)sender { isNoRecoilEnabled = sender.isOn; }
- (void)toggleSpeed:(UISwitch *)sender { isSpeedEnabled = sender.isOn; }
- (void)toggleEsp:(UISwitch *)sender { isEspEnabled = sender.isOn; }

// លាក់ Menu ធំ បង្ហាញប៊ូតុងតូច
- (void)minimizeMenu {
    self.menuView.hidden = YES;
    self.floatingBtn.hidden = NO;
}

// បង្ហាញ Menu ធំ លាក់ប៊ូតុងតូចវិញ
- (void)openMenu {
    self.menuView.hidden = NO;
    self.floatingBtn.hidden = YES;
}

// មុខងារអូសប៊ូតុងតូចទៅមកលើអេក្រង់ហ្គេម
- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self.view];
    CGPoint center = gesture.view.center;
    gesture.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
    [gesture setTranslation:CGPointZero inView:self.view];
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
            modWindow.backgroundColor = [UIColor clearColor];
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

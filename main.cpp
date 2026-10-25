#include "GameStructs.h"
#include <iostream>

// មុខងារនេះនឹងរត់ស្វ័យប្រវត្តិភ្លាមៗពេល .dylib ត្រូវបាន Load ចូលក្នុងហ្គេម iOS
__attribute__((constructor)) void initializer() {
    // ទីនេះជាកន្លែងដាក់ Logic សម្រាប់អាន ឬកែប្រែ Memory លើ iOS
}

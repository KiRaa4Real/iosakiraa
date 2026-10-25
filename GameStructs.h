#pragma once
#include <stdint.h>

// --- --- DEFINES & OFFSETS --- ---
#define OFFSET_LOCALPLAYER 0x1ED77D4
#define OFFSET_CLIENT 0x1ED7418

// --- --- MOD VALUES --- ---
inline double boostSpeedBuff = 1.51709e+09;
inline double Nearby = 1.1;

// --- --- NO RECOIL 100 CONFIG --- ---
#define NO_RECOIL_OFFSET 0x100
inline double noRecoilNum = -10.0;
inline double noRecoilNearbyF64 = 1000.0;
inline float noRecoilNearbyF32 = 1.875f;
inline float noRecoilTarget = 0.0f;

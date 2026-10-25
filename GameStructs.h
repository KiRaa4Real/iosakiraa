#pragma once
#include <cstdint>

// Forward Declarations
class Meta;
class MetaInfo;
class PtrTable;
class BWPyModel;
class Table;

// --- DEFINES ---
#define OFFSET_LOCALPLAYER 0x1ED77D4
#define OFFSET_CLIENT      0x1ED7418

// --- CLASS META ---
class Meta
{
public:
    char _0x0000[4];
    MetaInfo* m_pMeta; //0x0004 
    char _0x0008[4];
    char* pName; //0x000C  Land, Athlete, Plane, PlayerAvatar
};

// --- CLASS TABLE ---
class Table
{
public:
    char pad_0x0000[0x14]; //0x0000
    PtrTable* m_PtrTable; //0x0014 
    char pad_0x0018[0x3EC]; //0x0018
}; //Size=0x0404

// --- CLASS ENTITY ---
class Entity
{
public:
    int32_t type; //0x0000 
    Meta* m_pMeta; //0x0004 
    void* m_pUnk; //0x0008 
   int32_t m_ObjectId; //0x000C 

    float m_Position[4]; //0x0010 
    char _0x0020[24];
    float m_Yaw; //0x0038 
    float m_Pitch; //0x003C 
    char _0x0040[40];

    float m_Position2[4]; //0x0068 
    char _0x0078[60];

    BWPyModel* m_pModel; //0x00B4
    Table* m_Table; //0x0100
    char pad_0x0104[0x33C]; //0x0104
};

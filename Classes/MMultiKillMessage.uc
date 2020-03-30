class MMultiKillMessage extends LocalMessagePlus;

var(Messages)   localized string    DoubleKillString;
var(Messages)   localized string    MultiKillString;
var(Messages)   localized string    MegaKillString;
var(Messages)   localized string    UltraKillString;
var(Messages)   localized string    MonsterKillString;
var(Messages)   localized string    LudicrousKillString;
var(Messages)   localized string    HolyShitString;

static function float GetOffset(int Switch, float YL, float ClipY )
{
    return (Default.YPos/768.0) * ClipY + YL;
}

static function int GetFontSize( int Switch )
{
    if ( Switch == 1 )
        return Default.FontSize;
    else
        return 2;
}

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    switch (Switch)
    {
        case 1:
            return Default.DoubleKillString;
            break;
        case 2:
            return Default.MultiKillString;
            break;
        case 3:
            return Default.MegaKillString;
            break;
        case 4:
            return default.UltraKillString;
            break;
        case 5:
            return Default.MonsterKillString;
            break;
        case 6:
            return Default.LudicrousKillString;
            break;
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
        case 16:
        case 17:
        case 18:
        case 19:
        case 20:
            return Default.HolyShitString;
            break;
    }
    return "";
}

static simulated function ClientReceive(
    PlayerPawn P,
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

    switch (Switch)
    {
        case 1:
            P.ClientPlaySound(sound'DoubleKill',, true);
            break;
        case 2:
            P.ClientPlaySound(sound'MultiKill',, true);
            break;
        case 3:
            P.ClientPlaySound(sound'MegaKill',, true);
            break;
        case 4:
            P.ClientPlaySound(sound'UltraKill',, true);
            break;
        case 5:
            P.ClientPlaySound(sound'MonsterKill',, true);
            break;
        case 6:
            P.ClientPlaySound(sound'LudicrousKill',, true);
            break;
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
        case 16:
        case 17:
        case 18:
        case 19:
        case 20:
            P.ClientPlaySound(sound'HolyShit',, true);
            break;
    }
}

defaultproperties
{
    DoubleKillString="Double Kill!"
    MultiKillString="Multi Kill!"
    MegaKillString="Mega Kill!"
    UltraKillString="ULTRA KILL!!"
    MonsterKillString="M O N S T E R  K I L L !!!"
    LudicrousKillString="L U D I C R O U S  K I L L !!!"
    HolyShitString="H O L Y  S H I T!!!"
    FontSize=1
    bIsSpecial=True
    bIsUnique=True
    bFadeMessage=True
    DrawColor=(R=255, G=0, B=0, A=0)
    YPos=196.00
    bCenter=True
}

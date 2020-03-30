class CombosEx expands Mutator;

#exec AUDIO IMPORT FILE="Sounds\DoubleKill.WAV" NAME="DoubleKill"
#exec AUDIO IMPORT FILE="Sounds\MultiKill.WAV" NAME="MultiKill"
#exec AUDIO IMPORT FILE="Sounds\MegaKill.WAV" NAME="MegaKill"
#exec AUDIO IMPORT FILE="Sounds\UltraKill.WAV" NAME="UltraKill"
#exec AUDIO IMPORT FILE="Sounds\MonsterKill.WAV" NAME="MonsterKill"
#exec AUDIO IMPORT FILE="Sounds\LudicrousKill.WAV" NAME="LudicrousKill"
#exec AUDIO IMPORT FILE="Sounds\HolyShit.WAV" NAME="HolyShit"

function PostBeginPlay ()
{
         super.PostBeginPlay();
         Level.Game.DeathMessageClass = class'DDeathMessagePlus';
}
defaultproperties
{
}

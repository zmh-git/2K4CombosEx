class CombosExSA expands MessagingSpectator config(System);

var config int AnnounceLevel;
var CombosEx mut;

struct KillerInfo {
	var PlayerReplicationInfo PRI;
	var float LastKillTime;
	var int Level;
	var int multiplier;
};

var KillerInfo Killers[64];	// 32 should be enough...

event PostBeginPlay()
{
	Super.PostBeginPlay();
	mut = Level.Spawn(class'CombosEx');
	mut.NextMutator = Level.Game.BaseMutator;
	Level.Game.BaseMutator = mut;
	Log("### 2k4CombosEx Initialized v1.0 - � )�DoE�(-AnthraX 2004, Enhanced by zmh");
	SaveConfig();
}

function int FindPlayer(PlayerReplicationInfo PRI)	// Finds the player with this pri, if not found, it returns a free index.
{
	local int x;

	for (x = 0; x < 64; x++)
	{
		if (Killers[x].PRI == PRI)
			return x;
	}

	for (x = 0; x < 64; x++)
	{
		if (Killers[x].PRI == None)
		{
			Killers[x].PRI = PRI;
			Killers[x].LastKillTime = 0.0;
			Killers[x].Level = 0;
			Killers[x].multiplier = 0;
			return x;
		}
	}

	for (x = 0; x < 64; x++)	// Don't panic just yet.
	{
		if (Killers[x].Level == 0)
		{
			Killers[x].PRI = PRI;
			Killers[x].LastKillTime = 0.0;
			Killers[x].multiplier = 0;
			Killers[x].PRI = None;
			return x;
		}
	}

	return rand(64);		// This stinks, return a random entry.
}

function DoKill(PlayerReplicationInfo PRI)
{
	local int x;
	local string s;
    // Log("#### kill by"@PRI.PlayerName);
	x = FindPlayer(PRI);

	if (Level.TimeSeconds - Killers[x].LastKillTime < 3.0)
	{
		s = Class'MMultiKillMessage'.Static.GetString(++Killers[x].Level);
		if (s != "" && Killers[x].Level >= AnnounceLevel)
		{
			// Ultra
			if (Killers[x].Level == 4) {
				Level.Game.BroadcastMessage(PRI.PlayerName@"had an"@s);
			}
			// Other than Ultra
			else
			{
				
				if (Killers[x].Level > 7) 
				{
					// Second HS and beyond.
					Killers[x].multiplier++;
					Level.Game.BroadcastMessage(PRI.PlayerName@"had an"@s$" (*"$Killers[x].multiplier$")");
				}
			}
			// Any combo kill besides Ultra and multiple HS
			Level.Game.BroadcastMessage(PRI.PlayerName@"had a"@s);
		}
	}
	else
	{
		Killers[x].Level = 0;
		Killers[x].multiplier = 0;
	}

	Killers[x].LastKillTime = Level.TimeSeconds;
}

function DoDeath(PlayerReplicationInfo PRI)
{
	local int x;

	x = FindPlayer(PRI);

	Killers[x].Level = 0;
	Killers[x].LastKillTime = 0.0;
	Killers[x].multiplier = 0;
}

function ReceiveLocalizedMessage( class<LocalMessage> Message, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject )
{
	switch(Message)
	{
		Case Class'DDeathMessagePlus':	switch(Switch)
						{
							Case 0:
							Case 8:
								DoKill(RelatedPRI_1);	// Got a kill
								DoDeath(RelatedPRI_2);	// Got a death
								break;
							Case 1:
							Case 2:
							Case 3:
							Case 4:
							Case 5:
							Case 6:
							Case 7:
								DoDeath(RelatedPRI_1);	// Suicide (Death)
								break;
							Default:
								break;
						}
						break;
	}
}

function ClientMessage( coerce string S, optional name Type, optional bool bBeep )
{
}

function TeamMessage( PlayerReplicationInfo PRI, coerce string S, name Type, optional bool bBeep )
{
}

function ClientVoiceMessage(PlayerReplicationInfo Sender, PlayerReplicationInfo Recipient, name messagetype, byte messageID)
{
}

defaultproperties
{
    AnnounceLevel=1
}

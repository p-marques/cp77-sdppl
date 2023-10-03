public static exec func SDPPL_LevelUp(gi: GameInstance, proficiencyTypeInt: Int32) -> Void {
    let pds: ref<PlayerDevelopmentSystem>;
    let player: ref<PlayerPuppet>;
    let proficiencyType: gamedataProficiencyType;
    let experienceToAdd: Int32;
    let addExpRequest: ref<AddExperience>;

    if Equals(proficiencyTypeInt, 5) ||
        Equals(proficiencyTypeInt, 12) ||
        Equals(proficiencyTypeInt, 14) ||
        Equals(proficiencyTypeInt, 15) ||
        Equals(proficiencyTypeInt, 18) ||
        Equals(proficiencyTypeInt, 19) {
        proficiencyType = IntEnum<gamedataProficiencyType>(proficiencyTypeInt);

        pds = GameInstance.GetScriptableSystemsContainer(gi).Get(n"PlayerDevelopmentSystem") as PlayerDevelopmentSystem;
        player = GameInstance.GetPlayerSystem(gi).GetLocalPlayerMainGameObject() as PlayerPuppet;

        experienceToAdd = pds.GetRemainingExpForLevelUp(player, proficiencyType);
        if experienceToAdd > 0 {
            addExpRequest = new AddExperience();
            addExpRequest.Set(player, experienceToAdd, proficiencyType, true);
            pds.QueueRequest(addExpRequest);
        }
    }
}

// -- Allowed gamedataProficiencyType --
// CoolSkill = 5
// IntelligenceSkill = 12
// Level = 14
// ReflexesSkill = 15
// StrengthSkill = 18
// TechnicalAbilitySkill = 19

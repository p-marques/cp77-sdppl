public static exec func SDPPL_LevelUp(gi: GameInstance, proficiencyTypeString: String) -> Void {
    let pds: ref<PlayerDevelopmentSystem>;
    let player: ref<PlayerPuppet>;
    let proficiencyTypeInt: Int32;
    let proficiencyType: gamedataProficiencyType;
    let experienceToAdd: Int32;
    let addExpRequest: ref<AddExperience>;

    proficiencyTypeInt = Cast<Int32>(EnumValueFromName(n"gamedataProficiencyType", StringToName(proficiencyTypeString)));

    if proficiencyTypeInt >= 0 && proficiencyTypeInt <= 12 {
        proficiencyType = IntEnum<gamedataProficiencyType>(proficiencyTypeInt);

        pds = GameInstance.GetScriptableSystemsContainer(gi).Get(n"PlayerDevelopmentSystem") as PlayerDevelopmentSystem;
        player = GameInstance.GetPlayerSystem(gi).GetLocalPlayerMainGameObject() as PlayerPuppet;

        experienceToAdd = pds.GetRemainingExpForLevelUp(player, proficiencyType);
        if experienceToAdd > 0 {
            addExpRequest = new AddExperience();
            addExpRequest.Set(player, experienceToAdd, proficiencyType, true);
            pds.QueueRequest(addExpRequest);

            LogChannel(n"SDPPL", "Added " + experienceToAdd + " " + proficiencyTypeString + " experience.");
        }
        else {
            LogChannel(n"SDPPL", "No experience added since ::GetRemainingExpForLevelUp returned a negative value.");
        }
    }
    else {
        LogChannel(n"SDPPL", "\"" + proficiencyTypeString + "\" is not recognized.");
    }
}
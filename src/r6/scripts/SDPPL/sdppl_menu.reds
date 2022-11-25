module SDPPL.Menu

import SDPPL.Settings.SDPPLSettings

public class SDPPLMenu extends SDPPLSettings {
    @runtimeProperty("ModSettings.mod", "Set Dev Points Per Level")
    @runtimeProperty("ModSettings.category", "Main")
    @runtimeProperty("ModSettings.displayName", "Enabled")
    @runtimeProperty("ModSettings.description", "Enable/Disable mod.")
    public let IsEnabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "Set Dev Points Per Level")
    @runtimeProperty("ModSettings.category", "On Character Level Up")
    @runtimeProperty("ModSettings.displayName", "Attribute Points")
    @runtimeProperty("ModSettings.description", "Attribute point(s) awarded on character level up.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "0")
    @runtimeProperty("ModSettings.max", "5")
    public let AttributePointsOnCharacterLevelUp: Int32 = 1;

    @runtimeProperty("ModSettings.mod", "Set Dev Points Per Level")
    @runtimeProperty("ModSettings.category", "On Character Level Up")
    @runtimeProperty("ModSettings.displayName", "Perk Points")
    @runtimeProperty("ModSettings.description", "Perk point(s) awarded on character level up.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "0")
    @runtimeProperty("ModSettings.max", "5")
    public let PerkPointsOnCharacterLevelUp: Int32 = 1;

    @runtimeProperty("ModSettings.mod", "Set Dev Points Per Level")
    @runtimeProperty("ModSettings.category", "On Skill Level Up")
    @runtimeProperty("ModSettings.displayName", "Perk Points")
    @runtimeProperty("ModSettings.description", "Perk point(s) awarded on skill level up.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "0")
    @runtimeProperty("ModSettings.max", "5")
    public let PerkPointsOnSkillLevelUp: Int32 = 0;

    protected func SetupSettings() -> Void {
        SDPPL_RegisterMenu(this);
    }

    protected func GetIsEnabled() -> Bool {
        return this.IsEnabled;
    }

    protected func GetAttributePointsOnCharacterLevelUp(level: Int32) -> Int32 {
        return this.AttributePointsOnCharacterLevelUp;
    }

    protected func GetPerkPointsOnCharacterLevelUp(level: Int32) -> Int32 {
        return this.PerkPointsOnCharacterLevelUp;
    }

    protected func GetPerkPointsOnSkillLevelUp() -> Int32 {
        return this.PerkPointsOnSkillLevelUp;
    }

    protected func GetUseCustomAttributePointsMap() -> Bool {
        return false;
    }

    protected func GetUseCustomSkillPointsMap() -> Bool {
        return false;
    }

    protected func GetUseConditionalPointGain() -> Bool {
        return false;
    }
}

@if(!ModuleExists("ModSettingsModule"))
public func SDPPL_RegisterMenu(listener: ref<IScriptable>) {}

@if(ModuleExists("ModSettingsModule"))
public func SDPPL_RegisterMenu(listener: ref<IScriptable>) {
    ModSettings.RegisterListenerToClass(listener);
}
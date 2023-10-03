module SDPPL.Settings

public class SDPPLSettings {
    private let perkPointsOnSkillLevelUp : Int32;
		private let useConditionalPointGain : Bool;
		private let useCustomAttributePointsMap : Bool;
		private let customAttributePointsMap : array<Int32>;
		private let customAttributePointsMapDefaultValue : Int32;
		private let useCustomSkillPointsMap : Bool;
		private let customSkillPointsMap : array<Int32>;
		private let customSkillPointsMapDefaultValue : Int32;
		private let attributePointsOnCharacterLevelUp : Int32;
		private let perkPointsOnCharacterLevelUp : Int32;

    public func SetupSettings() -> Void {
        // ------ Settings Start ------

		// Perk points gained on every skill level up. Compounds with perks gained from skill progression.
		// Default = 0
		this.perkPointsOnSkillLevelUp = 0;

		// Flag to enable/disable conditional point gain on character level up. This flag also applies to custom maps.
		// Default = false
		this.useConditionalPointGain = false;

		// Flag to enable/disable use of new attribute point map. You can define overrides on a level by level basis below.
		// Default = false
		this.useCustomAttributePointsMap = false;

		// Attribute points custom map default value.
		// Default = 1
		this.customAttributePointsMapDefaultValue = 1;

		// Flag to enable/disable use of new skill point map. You can define overrides on a level by level basis below.
		// Default = false
		this.useCustomSkillPointsMap = false;

		// Skill points custom map default value.
		// Default = 1
		this.customSkillPointsMapDefaultValue = 1;

		// Attribute points gained on character level up. Ignored if using custom map.
		// Default = 1
		this.attributePointsOnCharacterLevelUp = 1;

		// Perk points gained on character level up. Ignored if using custom map.
		// Default = 1
		this.perkPointsOnCharacterLevelUp = 1;

		// ------ Settings End ------

    	this.SetupNewPointMaps();
    }

    private func SetupNewPointMaps() -> Void {
		if this.useCustomAttributePointsMap {
			this.SetupAtttributePointMap();
		}

		if this.useCustomSkillPointsMap {
			this.SetupSkillPointMap();
		}
	}

    // Attribute point map setup.
	private func SetupAtttributePointMap() -> Void {
		let i : Int32 = 0;

		while i < 60 {
			ArrayPush(this.customAttributePointsMap, this.customAttributePointsMapDefaultValue);

			i += 1;
		}

		// ------ Attribute Points Map Overrides Starts ------

		// this.customAttributePointsMap[21] = 0; // Example. At level 22 don't give an attribute point.

		// ------ Attribute Points Map Overrides Ends ------
	}

	// Skill point map setup.
	private func SetupSkillPointMap() -> Void {
		let i : Int32 = 0;

		while i < 60 {
			ArrayPush(this.customSkillPointsMap, this.customSkillPointsMapDefaultValue);

			i += 1;
		}

		// ------ Skill Points Map Overrides Starts ------

		// this.customSkillPointsMap[21] = 0; // Example. At level 22 don't give a skill point.

		// ------ Skill Points Map Overrides Ends ------
	}

    public func GetIsEnabled() -> Bool {
        return true;
    }

    public func GetAttributePointsOnCharacterLevelUp(level: Int32) -> Int32 {
		if this.GetUseCustomAttributePointsMap() {
			return this.customAttributePointsMap[level - 1];
		}

		return this.attributePointsOnCharacterLevelUp;
	}

	public func GetPerkPointsOnCharacterLevelUp(level: Int32) -> Int32 {
		if this.GetUseCustomSkillPointsMap() {
			return this.customSkillPointsMap[level - 1];
		}

		return this.perkPointsOnCharacterLevelUp;
	}

	public func GetPerkPointsOnSkillLevelUp() -> Int32 {
		return this.perkPointsOnSkillLevelUp;
	}

	public func GetUseCustomAttributePointsMap() -> Bool {
		return this.useCustomAttributePointsMap;
	}

	public func GetUseCustomSkillPointsMap() -> Bool {
		return this.useCustomSkillPointsMap;
	}

	public func GetUseConditionalPointGain() -> Bool {
		return this.useConditionalPointGain;
	}

	// With this condition player is awarded points if level is even.
	public func GetShouldAwardPoints(level : Int32) -> Bool {
		if level % 2 == 0 {
			return true;
		}

		return false;
	}
}
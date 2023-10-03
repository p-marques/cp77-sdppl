module SDPPL.Base
import SDPPL.Settings.SDPPLSettings

public class SDPPL extends ScriptableSystem {
    private let player: ref<PlayerPuppet>;
    private let statsSystem: ref<StatsSystem>;
    private let levelUpListener: ref<LevelChangedListener>;
    private let playerDevelopmentData: ref<PlayerDevelopmentData>;
    private let settings: ref<SDPPLSettings>;

    private func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void {
        this.player = GameInstance.GetPlayerSystem(request.owner.GetGame()).GetLocalPlayerMainGameObject() as PlayerPuppet;
        this.playerDevelopmentData = PlayerDevelopmentSystem.GetData(this.player);

        this.RegisterListeners();

        this.settings = new SDPPLSettings();

        this.settings.SetupSettings();
    }

    private final func OnPlayerDetach(request: ref<PlayerDetachRequest>) -> Void {
        this.statsSystem.UnregisterListener(Cast<StatsObjectID>(this.player.GetEntityID()), this.levelUpListener);
    }

    private func RegisterListeners() -> Void {
        this.statsSystem = GameInstance.GetStatsSystem(this.GetGameInstance());
        this.levelUpListener = new LevelChangedListener();
        this.levelUpListener.sdppl = this;
        this.statsSystem.RegisterListener(Cast<StatsObjectID>(this.player.GetEntityID()), this.levelUpListener);
    }

    private func OnLevelUpRequest(request: ref<HandleLevelUpRequest>) -> Void {
        if !this.settings.GetIsEnabled() {
            return;
        }

        if Equals(request.newLevel, 1) {
            return;
        }

        if Equals(request.statType, gamedataStatType.Level) {
            this.HandlePlayerLevelUp(request.newLevel);
        }
        else {
            this.HandleSkillLevelUp();
        }
    }

    private func HandlePlayerLevelUp(newLevel: Int32) -> Void {
        let attributePointsDelta: Int32 = 0;
        let perkPointsDelta: Int32 = 0;

        if this.settings.GetUseConditionalPointGain() && !this.settings.GetShouldAwardPoints(newLevel) {
            attributePointsDelta = -1;
            perkPointsDelta = -1;
        }
        else {
            attributePointsDelta = this.settings.GetAttributePointsOnCharacterLevelUp(newLevel) - 1;
            perkPointsDelta = this.settings.GetPerkPointsOnCharacterLevelUp(newLevel) - 1;
        }

        if attributePointsDelta != 0 {
            this.playerDevelopmentData.AddDevelopmentPoints(attributePointsDelta, gamedataDevelopmentPointType.Attribute);
        }

        if perkPointsDelta != 0 {
            this.playerDevelopmentData.AddDevelopmentPoints(perkPointsDelta, gamedataDevelopmentPointType.Primary);
        }
    }

    private func HandleSkillLevelUp() -> Void {
        let perkPointsToAdd: Int32 = this.settings.GetPerkPointsOnSkillLevelUp();

        if perkPointsToAdd > 0 {
            this.playerDevelopmentData.AddDevelopmentPoints(perkPointsToAdd, gamedataDevelopmentPointType.Primary);
        }
    }

    public static func IsStatASkill(statType: gamedataStatType) -> Bool {
        switch statType {
            case statType.CoolSkill:
            case statType.IntelligenceSkill:
            case statType.ReflexesSkill:
            case statType.StrengthSkill:
            case statType.TechnicalAbilitySkill:
                return true;
        }

        return false;
    }
}

public class HandleLevelUpRequest extends ScriptableSystemRequest {
    public let statType: gamedataStatType;
    public let newLevel: Int32;
}

public class LevelChangedListener extends ScriptStatsListener {
    public let sdppl: ref<SDPPL>;

    public func OnStatChanged(ownerID: StatsObjectID, statType: gamedataStatType, diff: Float, total: Float) -> Void {
        let request: ref<HandleLevelUpRequest>;

        if Equals(statType, gamedataStatType.Level) || SDPPL.IsStatASkill(statType) {
            request = new HandleLevelUpRequest();
            request.statType = statType;
            request.newLevel = Cast<Int32>(total);

            if IsDefined(this.sdppl) {
                this.sdppl.QueueRequest(request);
            }
        }
    }
}

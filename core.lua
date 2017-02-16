

    local TEXTURE       = [[Interface\AddOns\modui\statusbar\texture\name2.tga]]
    local FRAME_TEXTURE = [[Interface\AddOns\modui-TallHealthBar\Textures\UI-TargetingFrame]]
    local orig          = {}

    orig.TargetFrame_CheckClassification    = TargetFrame_CheckClassification
    orig.HealthBar_OnValueChanged           = HealthBar_OnValueChanged

    PlayerFrameBackground:SetHeight(41)
    PlayerFrameBackground.bg:Hide()

    PlayerFrameHealthBar:SetHeight(29)
    PlayerFrameHealthBar:SetPoint('TOPLEFT', 106, -22)
    PlayerFrameHealthBar:SetStatusBarTexture(TEXTURE)

    PlayerFrameTexture:SetTexture(FRAME_TEXTURE)
    PlayerStatusTexture:SetTexture[[Interface\AddOns\modui-TallHealthBar\Textures\UI-Player-Status]]

    PlayerFrameHealthBarText:SetPoint('CENTER', 50, 5)

    TargetFrameNameBackground:Hide()

    TargetFrameHealthBar:SetHeight(29)
    TargetFrameHealthBar:SetPoint('TOPLEFT', 6, -22)
    TargetFrameHealthBar:SetStatusBarTexture(TEXTURE)

    if MobHealth3 then
        MobHealth3BlizzardHealthText:ClearAllPoints()
        MobHealth3BlizzardHealthText:SetPoint('CENTER', TargetFrame, -50, 5)

        MobHealth3BlizzardPowerText:ClearAllPoints()
        MobHealth3BlizzardPowerText:SetPoint('CENTER', TargetFrame, -50, -8)
    end

    function TargetFrame_CheckClassification()
        orig.TargetFrame_CheckClassification()
        TargetFrameTexture:SetTexture(FRAME_TEXTURE)
    end

    function HealthBar_OnValueChanged(v, smooth)
        orig.HealthBar_OnValueChanged(v, smooth)
        if this == PlayerFrameHealthBar or (this == TargetFrameHealthBar and UnitIsPlayer(this.unit)) then
            local _, class = UnitClass(this.unit)
            local colour = RAID_CLASS_COLORS[class]
            this:SetStatusBarColor(colour.r, colour.g, colour.b)
        end
    end

    if IsAddOnLoaded'modui-FocusFrame' then
        local _, class = UnitClass'player'

        orig.FocusFrame_CheckClassification = FocusFrame_CheckClassification
        orig.FocusFrame_HealthUpdate        = FocusFrame_HealthUpdate

        FocusFrameNameBackground:Hide()

        FocusFrameHealthBar:SetHeight(29)
        FocusFrameHealthBar:SetPoint('TOPLEFT', 6, -22)
        FocusFrameHealthBar:SetStatusBarTexture(TEXTURE)

        FocusFrameHealthBarText:SetPoint('CENTER', -50, 5)

        FocusFrameManaBarText:SetPoint('CENTER', -50, -8)

        FocusDeadText:SetPoint('CENTER', -50, 5)

        function FocusFrame_CheckClassification(unit)
            orig.FocusFrame_CheckClassification(unit)
            FocusFrameTexture:SetTexture(FRAME_TEXTURE)
            if UnitIsPlayer(unit) then _, class = UnitClass(unit) end
        end

        function FocusFrame_HealthUpdate(unit)
            orig.FocusFrame_HealthUpdate(unit)
            local data = FocusFrame_GetFocusData(CURR_FOCUS_TARGET)
            if data.npc == '1' then
                local colour = RAID_CLASS_COLORS[class]
                FocusFrameHealthBar:SetStatusBarColor(colour.r, colour.g, colour.b)
            end
        end
    end

    --

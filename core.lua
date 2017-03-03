

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
        local Focus     = _G['FocusData']
        local class

        FocusFrameNameBackground:Hide()

        FocusFrameHealthBar:SetHeight(29)
        FocusFrameHealthBar:SetPoint('TOPLEFT', 6, -22)
        FocusFrameHealthBar:SetStatusBarTexture(TEXTURE)

        FocusFrameHealthBarText:SetPoint('CENTER', -50, 5)

        FocusFrameManaBarText:SetPoint('CENTER', -50, -8)

        FocusDeadText:SetPoint('CENTER', -50, 5)

        Focus:OnEvent('UNIT_CLASSIFICATION_CHANGED', function()
            FocusFrameTexture:SetTexture(FRAME_TEXTURE)
            if Focus:GetData'unitIsPlayer' then
                local unit = Focus:GetData'unit'
                _, class = UnitClass(unit)
            end
        end)

        Focus:OnEvent('UNIT_HEALTH_OR_POWER', function()
            if Focus:GetData'unitIsPlayer' then
                local colour = RAID_CLASS_COLORS[class]
                FocusFrameHealthBar:SetStatusBarColor(colour.r, colour.g, colour.b)
            end
        end)
    end

    --

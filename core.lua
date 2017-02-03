

    local TEXTURE   = [[Interface\AddOns\modui\statusbar\texture\name2.tga]]
    local _, class  = UnitClass'player'
    local colour    = RAID_CLASS_COLORS[class]
    local orig      = {}

    orig.TargetFrame_CheckClassification    = TargetFrame_CheckClassification
    orig.HealthBar_OnValueChanged           = HealthBar_OnValueChanged

    PlayerFrameBackground:SetHeight(29)
    PlayerFrameBackground.bg:Hide()

    PlayerFrameHealthBar:SetHeight(29)
    PlayerFrameHealthBar:SetPoint('TOPLEFT', 106, -22)
    PlayerFrameHealthBar:SetStatusBarTexture(TEXTURE)

    PlayerFrameHealthBarText:SetPoint('CENTER', 50, 5)

    PlayerFrameTexture:SetTexture[[Interface\AddOns\modui-TallHealthBar\Textures\UI-TargetingFrame]]
    PlayerStatusTexture:SetTexture[[Interface\AddOns\modui-TallHealthBar\Textures\UI-Player-Status]]

    TargetFrameNameBackground:Hide()

    TargetFrameHealthBar:SetHeight(29)
    TargetFrameHealthBar:SetPoint('TOPLEFT', 6, -22)
    TargetFrameHealthBar:SetStatusBarTexture(TEXTURE)

    TargetDeadText:SetPoint('CENTER', -50, 6)

    function TargetFrame_CheckClassification()
        orig.TargetFrame_CheckClassification()
        TargetFrameTexture:SetTexture[[Interface\AddOns\modui-TallHealthBar\Textures\UI-TargetingFrame]]
    end

    function HealthBar_OnValueChanged(v, smooth)
        if this == PlayerFrameHealthBar then
            PlayerFrameHealthBar:SetStatusBarColor(colour.r, colour.g, colour.b, 1)
        else
            if this == TargetFrameHealthBar and UnitIsPlayer'target' then
                local _, class = UnitClass'target'
                local colour = RAID_CLASS_COLORS[class]
                TargetFrameHealthBar:SetStatusBarColor(colour.r, colour.g, colour.b, 1)
            else
                orig.HealthBar_OnValueChanged(v, smooth)
            end
        end
    end

    --

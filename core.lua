

    local TEXTURE   = [[Interface\AddOns\modui\statusbar\texture\name2.tga]]
    local _, class  = UnitClass'player'
    local colour    = RAID_CLASS_COLORS[class]
    local orig      = {}

    orig.HealthBar_OnValueChanged           = HealthBar_OnValueChanged
    orig.TargetFrame_CheckClassification    = TargetFrame_CheckClassification

    PlayerFrameBackground:SetHeight(29)
    PlayerFrameBackground.bg:Hide()

    PlayerFrameHealthBar:SetHeight(29)
    PlayerFrameHealthBar:SetPoint('TOPLEFT', 106, -22)
    PlayerFrameHealthBar:SetStatusBarTexture(TEXTURE)

    PlayerFrameHealthBarText:SetPoint('CENTER', 50, 5)

    PlayerFrameTexture:SetTexture[[Interface\AddOns\modui-UnitFramesImproved\Textures\UI-TargetingFrame]]
    PlayerStatusTexture:SetTexture[[Interface\AddOns\modui-UnitFramesImproved\Textures\UI-Player-Status]]

    TargetFrameNameBackground:Hide()

    TargetFrameHealthBar:SetHeight(29)
    TargetFrameHealthBar:SetPoint('TOPLEFT', 6, -22)
    TargetFrameHealthBar:SetStatusBarTexture(TEXTURE)

    TargetDeadText:SetPoint('CENTER', -50, 6)

    TargetFrameNameBackground:Hide()


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

    function TargetFrame_CheckClassification()
        orig.TargetFrame_CheckClassification()
        local  classification = UnitClassification'target'
        if     classification == 'worldboss' then
            TargetFrameTexture:SetTexture[[Interface\AddOns\modui-UnitFramesImproved\Textures\UI-TargetingFrame-Elite]]
        elseif classification == 'rareelite' then
            TargetFrameTexture:SetTexture[[Interface\AddOns\modui-UnitFramesImproved\Textures\UI-TargetingFrame-Rare-Elite]]
        elseif classification == 'elite' then
            TargetFrameTexture:SetTexture[[Interface\AddOns\modui-UnitFramesImproved\Textures\UI-TargetingFrame-Elite]]
        elseif classification == 'rare' then
            TargetFrameTexture:SetTexture[[Interface\AddOns\modui-UnitFramesImproved\Textures\UI-TargetingFrame-Rare]]
        else
            TargetFrameTexture:SetTexture[[Interface\AddOns\modui-UnitFramesImproved\Textures\UI-TargetingFrame]]
        end
    end

    --

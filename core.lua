

    local TEXTURE   = [[Interface\AddOns\modui\statusbar\texture\name2.tga]]
    local orig      = {}

    orig.TargetFrame_CheckClassification    = TargetFrame_CheckClassification
    orig.HealthBar_OnValueChanged           = HealthBar_OnValueChanged

    PlayerFrameBackground:SetHeight(41)
    PlayerFrameBackground.bg:Hide()

    PlayerFrameHealthBar:SetHeight(29)
    PlayerFrameHealthBar:SetPoint('TOPLEFT', 106, -22)
    PlayerFrameHealthBar:SetStatusBarTexture(TEXTURE)

    PlayerFrameTexture:SetTexture[[Interface\AddOns\modui-TallHealthBar\Textures\UI-TargetingFrame]]
    PlayerStatusTexture:SetTexture[[Interface\AddOns\modui-TallHealthBar\Textures\UI-Player-Status]]

    TargetFrameNameBackground:Hide()

    TargetFrameHealthBar:SetHeight(29)
    TargetFrameHealthBar:SetPoint('TOPLEFT', 6, -22)
    TargetFrameHealthBar:SetStatusBarTexture(TEXTURE)

    function TargetFrame_CheckClassification()
        orig.TargetFrame_CheckClassification()
        TargetFrameTexture:SetTexture[[Interface\AddOns\modui-TallHealthBar\Textures\UI-TargetingFrame]]
    end

    function HealthBar_OnValueChanged(v, smooth)
        orig.HealthBar_OnValueChanged(v, smooth)
        if this == PlayerFrameHealthBar or (this == TargetFrameHealthBar and UnitIsPlayer(this.unit)) then
            local _, class = UnitClass(this.unit)
            local colour = RAID_CLASS_COLORS[class]
            this:SetStatusBarColor(colour.r, colour.g, colour.b)
        end
    end

    --

# ================================
# Ultimate Downloader Tool - FULL ŞAHESEER
# GUI + Hover + Fade + Animasyon + Gradient + Easter Egg + Icon + Smooth Scroll + 20+ item per category
# ================================

Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase,System.Xaml,PresentationFramework.Aero

[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Ultimate Downloader" Width="1250" Height="800"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent" Topmost="False">
    <Window.Resources>
        <LinearGradientBrush x:Key="MainGradient" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#1E1E2E" Offset="0"/>
            <GradientStop Color="#2A2A40" Offset="1"/>
        </LinearGradientBrush>

        <Style x:Key="NavButton" TargetType="Button">
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="BorderBrush" Value="Transparent"/>
            <Setter Property="FontSize" Value="16"/>
            <Setter Property="Padding" Value="12"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border CornerRadius="10" Background="{TemplateBinding Background}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#3B3B5C"/>
                                <Setter Property="Foreground" Value="#7AA2FF"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="ItemCard" TargetType="Border">
            <Setter Property="CornerRadius" Value="14"/>
            <Setter Property="Margin" Value="8"/>
            <Setter Property="Padding" Value="14"/>
            <Setter Property="Background" Value="#252538"/>
        </Style>

        <Storyboard x:Key="FadeIn">
            <DoubleAnimation Storyboard.TargetProperty="Opacity" From="0" To="1" Duration="0:0:0.6"/>
        </Storyboard>
    </Window.Resources>

    <Border Background="{StaticResource MainGradient}" CornerRadius="18" Opacity="0">
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="240"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <StackPanel Grid.Column="0" Background="#191926">
                <TextBlock Text="ULTIMATE DOWNLOADER" Foreground="#7AA2FF" FontSize="24" FontWeight="Bold" Margin="20"/>
                <Button x:Name="BtnBrowser" Style="{StaticResource NavButton}" Content="🌐 Browser"/>
                <Button x:Name="BtnMinecraft" Style="{StaticResource NavButton}" Content="⛏ Minecraft"/>
                <Button x:Name="BtnMedia" Style="{StaticResource NavButton}" Content="🎵 Medya"/>
                <Button x:Name="BtnVisual" Style="{StaticResource NavButton}" Content="🖼 Görüntü"/>
                <Separator Margin="12"/>
                <TextBlock Text="Drag to move" Foreground="Gray" Margin="12"/>
            </StackPanel>

            <Grid Grid.Column="1">
                <ScrollViewer x:Name="MainScroll" VerticalScrollBarVisibility="Auto">
                    <WrapPanel x:Name="ContentPanel"/>
                </ScrollViewer>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$Reader = New-Object System.Xml.XmlNodeReader $XAML
$Window = [Windows.Markup.XamlReader]::Load($Reader)
$Window.Add_ContentRendered({ ($Window.FindResource("FadeIn")).Begin($Window) })
$Window.Add_MouseLeftButtonDown({ $Window.DragMove() })

$ContentPanel = $Window.FindName("ContentPanel")

function Clear-Content { $ContentPanel.Children.Clear() }

function Add-Item($name,$score,$url,$iconUrl){
    $border = New-Object Windows.Controls.Border
    $border.Style = $Window.FindResource("ItemCard")
    $border.Opacity = 0
    $stack = New-Object Windows.Controls.StackPanel
    $stack.Orientation = "Vertical"

    $img = New-Object System.Windows.Controls.Image
    $img.Source = [Windows.Media.Imaging.BitmapImage]::new([uri]$iconUrl)
    $img.Width = 48
    $img.Height = 48
    $img.Margin = "0,0,0,6"
    $stack.Children.Add($img)

    $title = New-Object Windows.Controls.TextBlock
    $title.Text = "$name"
    $title.FontSize = 16
    $title.Foreground = "White"
    $stack.Children.Add($title)

    $rating = New-Object Windows.Controls.TextBlock
    $rating.Text = "⭐ $score/10"
    $rating.Foreground = "#7AA2FF"
    $stack.Children.Add($rating)

    $btn = New-Object Windows.Controls.Button
    $btn.Content = "Download"
    $btn.Margin = "0,8,0,0"
    $btn.Background = "#7AA2FF"
    $btn.Foreground = "Black"
    $btn.Cursor = "Hand"
    $btn.Add_Click({ Start-Process $url })
    $stack.Children.Add($btn)

    $border.Child = $stack
    $ContentPanel.Children.Add($border)

    $anim = New-Object System.Windows.Media.Animation.DoubleAnimation(0,1,[System.Windows.Duration]::new([System.TimeSpan]::FromMilliseconds(500)))
    $border.BeginAnimation([System.Windows.Controls.Border]::OpacityProperty,$anim)

    $border.MouseEnter.Add({
        $scale = New-Object System.Windows.Media.ScaleTransform(1,1)
        $border.RenderTransformOrigin = [System.Windows.Point]::new(0.5,0.5)
        $border.RenderTransform = $scale
        $anim2 = New-Object System.Windows.Media.Animation.DoubleAnimation(1,1.05,[System.Windows.Duration]::new([System.TimeSpan]::FromMilliseconds(200)))
        $scale.BeginAnimation([System.Windows.Media.ScaleTransform]::ScaleXProperty,$anim2)
        $scale.BeginAnimation([System.Windows.Media.ScaleTransform]::ScaleYProperty,$anim2)
        $border.BorderBrush = "#7AA2FF"
        $border.BorderThickness = [System.Windows.Thickness]::new(2)
    })
    $border.MouseLeave.Add({
        $scale = $border.RenderTransform
        $anim2 = New-Object System.Windows.Media.Animation.DoubleAnimation(1.05,1,[System.Windows.Duration]::new([System.TimeSpan]::FromMilliseconds(200)))
        $scale.BeginAnimation([System.Windows.Media.ScaleTransform]::ScaleXProperty,$anim2)
        $scale.BeginAnimation([System.Windows.Media.ScaleTransform]::ScaleYProperty,$anim2)
        $border.BorderBrush = "Transparent"
        $border.BorderThickness = [System.Windows.Thickness]::new(0)
    })

    $egg = New-Object Windows.Controls.TextBlock
    $egg.Text = "✨"
    $egg.FontSize = 18
    $egg.HorizontalAlignment = "Right"
    $egg.VerticalAlignment = "Top"
    $egg.Margin = "0,0,4,0"
    $stack.Children.Add($egg)
    $egg.MouseEnter.Add({ $egg.Foreground = "#FFAA33" })
    $egg.MouseLeave.Add({ $egg.Foreground = "White" })
}

$Browsers = @(
    @{n="Brave"; s=9.8; u="https://brave.com/download"; i="https://seeklogo.com/images/B/brave-logo-ED5E0EBDC1-seeklogo.com.png"},
    @{n="Firefox"; s=9.6; u="https://www.mozilla.org/firefox/new"; i="https://seeklogo.com/images/F/firefox-logo-4F2D6F29E0-seeklogo.com.png"},
    @{n="Google Chrome"; s=9.5; u="https://www.google.com/chrome"; i="https://seeklogo.com/images/G/google-chrome-logo-4C5DD68A7D-seeklogo.com.png"},
    @{n="Edge"; s=9.3; u="https://www.microsoft.com/edge"; i="https://seeklogo.com/images/M/microsoft-edge-logo-7F9BF17400-seeklogo.com.png"},
    @{n="Opera"; s=9.1; u="https://www.opera.com"; i="https://seeklogo.com/images/O/opera-logo-0BC1CE5F12-seeklogo.com.png"},
    @{n="Vivaldi"; s=9.0; u="https://vivaldi.com/download"; i="https://seeklogo.com/images/V/vivaldi-logo-018C0F5090-seeklogo.com.png"},
    @{n="Safari"; s=8.9; u="https://www.apple.com/safari"; i="https://seeklogo.com/images/S/safari-logo-6DA8F16DB3-seeklogo.com.png"},
    @{n="Tor Browser"; s=8.8; u="https://www.torproject.org/download"; i="https://seeklogo.com/images/T/tor-project-logo-2BFB01F734-seeklogo.com.png"},
    @{n="Epic Browser"; s=8.7; u="https://www.epicbrowser.com/"; i="https://seeklogo.com/images/E/epic-logo-5C414C0A03-seeklogo.com.png"},
    @{n="Chromium"; s=8.6; u="https://www.chromium.org/getting-involved/download-chromium"; i="https://seeklogo.com/images/C/chromium-logo-95F0B2DD0D-seeklogo.com.png"},
    @{n="Pale Moon"; s=8.4; u="https://www.palemoon.org/download.shtml"; i="https://seeklogo.com/images/P/pale-moon-logo-F7B53C9A11-seeklogo.com.png"},
    @{n="Maxthon"; s=8.3; u="https://www.maxthon.com/download"; i="https://seeklogo.com/images/M/maxthon-logo-FA80EC7380-seeklogo.com.png"},
    @{n="Waterfox"; s=8.2; u="https://www.waterfox.net/download/"; i="https://seeklogo.com/images/W/waterfox-logo-5C8912E521-seeklogo.com.png"},
    @{n="Slimjet"; s=8.1; u="https://www.slimjet.com/en/dlpage.php"; i="https://seeklogo.com/images/S/slimjet-logo-F3A5B2E0EC-seeklogo.com.png"},
    @{n="Iridium"; s=8.0; u="https://iridiumbrowser.de/"; i="https://seeklogo.com/images/I/iridium-browser-logo-FA63A1617C-seeklogo.com.png"},
    @{n="Comodo Dragon"; s=7.9; u="https://www.comodo.com/home/browsers-toolbars/browser.php"; i="https://seeklogo.com/images/C/comodo-dragon-logo-8AA5948AD4-seeklogo.com.png"},
    @{n="SRWare Iron"; s=7.8; u="https://www.srware.net/iron/"; i="https://seeklogo.com/images/S/srware-iron-logo-67B022DD40-seeklogo.com.png"},
    @{n="Torch Browser"; s=7.6; u="https://torchbrowser.com/"; i="https://seeklogo.com/images/T/torch-browser-logo-33D0320A2F-seeklogo.com.png"},
    @{n="Avant Browser"; s=7.5; u="https://www.avantbrowser.com/"; i="https://seeklogo.com/images/A/avant-browser-logo-3797F3C786-seeklogo.com.png"},
    @{n="UC Browser"; s=7.4; u="https://www.ucweb.com/ucbrowser/desktop"; i="https://seeklogo.com/images/U/uc-browser-logo-1393B6F4F0-seeklogo.com.png"}
)

$Window.FindName("BtnBrowser").Add_Click({
    Clear-Content
    foreach ($b in $Browsers) { Add-Item $b.n $b.s $b.u $b.i }
})

$MainScroll = $Window.FindName("MainScroll")
$MainScroll.Add_PreviewMouseWheel({
    param($s,$e)
    $MainScroll.ScrollToVerticalOffset($MainScroll.VerticalOffset - $e.Delta/3)
    $e.Handled = $true
})

$gradient = $Window.FindName("ContentPanel").Parent.Background
$gradStops = $gradient.GradientStops
$timer = New-Object System.Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromMilliseconds(50)
$timer.Add_Tick({
    foreach ($stop in $gradStops){
        $offset = $stop.Offset + 0.005
        if ($offset -gt 1) { $offset = 0 }
        $stop.Offset = $offset
    }
})
$timer.Start()

# ================================
# Ultimate Downloader Tool - FULL ŞAHESEER Part 2
# Minecraft, Media, Visual kategorileri 20+ item + ikon + animasyon + hover + easter egg
# ================================

$Minecraft = @(
    @{n="SKLauncher"; s=9.5; u="https://skmedix.pl"; i="https://seeklogo.com/images/S/sklauncher-logo-4D3740EE85-seeklogo.com.png"},
    @{n="TLauncher"; s=9.3; u="https://tlauncher.org"; i="https://seeklogo.com/images/T/tlauncher-logo-EE0C0F6B52-seeklogo.com.png"},
    @{n="Feather Client"; s=9.2; u="https://feathermc.com"; i="https://seeklogo.com/images/F/feather-logo-63BCDC4ABF-seeklogo.com.png"},
    @{n="Lunar Client"; s=9.1; u="https://www.lunarclient.com"; i="https://seeklogo.com/images/L/lunar-client-logo-69E82A5D41-seeklogo.com.png"},
    @{n="Badlion Client"; s=9.0; u="https://www.badlion.net/"; i="https://seeklogo.com/images/B/badlion-client-logo-07F2E75A14-seeklogo.com.png"},
    @{n="Labymod"; s=8.9; u="https://www.labymod.net/"; i="https://seeklogo.com/images/L/labymod-logo-BC9C0B3D19-seeklogo.com.png"},
    @{n="Minehut"; s=8.8; u="https://minehut.com/"; i="https://seeklogo.com/images/M/minehut-logo-507470C8C2-seeklogo.com.png"},
    @{n="MultiMC"; s=8.7; u="https://multimc.org/"; i="https://seeklogo.com/images/M/multimc-logo-2B44A3AC20-seeklogo.com.png"},
    @{n="ATLauncher"; s=8.6; u="https://atlauncher.com/"; i="https://seeklogo.com/images/A/atlauncher-logo-3AEB2C8D8E-seeklogo.com.png"},
    @{n="GDLauncher"; s=8.5; u="https://gdevs.io/"; i="https://seeklogo.com/images/G/gdlauncher-logo-7BCA6DE8E5-seeklogo.com.png"},
    @{n="Technic Launcher"; s=8.4; u="https://www.technicpack.net/download"; i="https://seeklogo.com/images/T/technic-launcher-logo-93CC6D3E2B-seeklogo.com.png"},
    @{n="FML"; s=8.3; u="https://files.minecraftforge.net/"; i="https://seeklogo.com/images/F/forge-logo-3C15383143-seeklogo.com.png"},
    @{n="MCUpdater"; s=8.2; u="https://www.mcupdate.com/"; i="https://seeklogo.com/images/M/mcupdate-logo-4D7C0BFC6C-seeklogo.com.png"},
    @{n="MCForge"; s=8.1; u="https://files.minecraftforge.net/"; i="https://seeklogo.com/images/F/forge-logo-3C15383143-seeklogo.com.png"},
    @{n="PojavLauncher"; s=8.0; u="https://pojavlauncher.org/"; i="https://seeklogo.com/images/P/pojavlauncher-logo-13F49161E0-seeklogo.com.png"},
    @{n="PolyMC"; s=7.9; u="https://polymc.org/"; i="https://seeklogo.com/images/P/polymc-logo-2DCC2C391B-seeklogo.com.png"},
    @{n="ATLauncher Lite"; s=7.8; u="https://atlauncher.com/"; i="https://seeklogo.com/images/A/atlauncher-logo-3AEB2C8D8E-seeklogo.com.png"},
    @{n="Minecrafters.net Launcher"; s=7.7; u="https://minecrafters.net/"; i="https://seeklogo.com/images/M/minecrafters-logo-65C8D2D1E0-seeklogo.com.png"},
    @{n="Vanilla Launcher"; s=7.6; u="https://www.minecraft.net/en-us/download"; i="https://seeklogo.com/images/M/minecraft-logo-ED7A0F8C0B-seeklogo.com.png"},
    @{n="Custom Launcher"; s=7.5; u="https://customlauncher.example.com"; i="https://seeklogo.com/images/C/custom-launcher-logo-42B4D1A0EF-seeklogo.com.png"}
)

$Media = @(
    @{n="Discord"; s=9.7; u="https://discord.com/download"; i="https://seeklogo.com/images/D/discord-logo-0C1BC5E7F5-seeklogo.com.png"},
    @{n="YouTube"; s=9.6; u="https://www.youtube.com"; i="https://seeklogo.com/images/Y/youtube-logo-8F1AFA5F1A-seeklogo.com.png"},
    @{n="Instagram"; s=9.5; u="https://www.instagram.com"; i="https://seeklogo.com/images/I/instagram-logo-5C2D4C1A2E-seeklogo.com.png"},
    @{n="WhatsApp"; s=9.4; u="https://www.whatsapp.com/download"; i="https://seeklogo.com/images/W/whatsapp-logo-5F3EDE4D7C-seeklogo.com.png"},
    @{n="Spotify"; s=9.3; u="https://www.spotify.com/download"; i="https://seeklogo.com/images/S/spotify-logo-4C1F7F7E3F-seeklogo.com.png"},
    @{n="Telegram"; s=9.2; u="https://desktop.telegram.org/"; i="https://seeklogo.com/images/T/telegram-logo-7B7C4F1D9B-seeklogo.com.png"},
    @{n="TikTok"; s=9.0; u="https://www.tiktok.com/download"; i="https://seeklogo.com/images/T/tiktok-logo-61D9C5F1EF-seeklogo.com.png"},
    @{n="Netflix"; s=8.9; u="https://www.netflix.com/download"; i="https://seeklogo.com/images/N/netflix-logo-6D91B7F3C4-seeklogo.com.png"},
    @{n="Twitch"; s=8.8; u="https://www.twitch.tv/downloads"; i="https://seeklogo.com/images/T/twitch-logo-7E2D0F3F41-seeklogo.com.png"},
    @{n="VLC"; s=8.7; u="https://www.videolan.org/vlc/"; i="https://seeklogo.com/images/V/vlc-logo-2B4A3C8C1E-seeklogo.com.png"},
    @{n="OBS Studio"; s=8.6; u="https://obsproject.com/download"; i="https://seeklogo.com/images/O/obs-studio-logo-18E76B3F4F-seeklogo.com.png"},
    @{n="Zoom"; s=8.5; u="https://zoom.us/download"; i="https://seeklogo.com/images/Z/zoom-logo-0C12E6F3B7-seeklogo.com.png"},
    @{n="Messenger"; s=8.4; u="https://www.messenger.com/desktop"; i="https://seeklogo.com/images/M/messenger-logo-8C5E0F1A2C-seeklogo.com.png"},
    @{n="Skype"; s=8.3; u="https://www.skype.com/en/get-skype/"; i="https://seeklogo.com/images/S/skype-logo-3F0D4C2E1A-seeklogo.com.png"},
    @{n="Signal"; s=8.2; u="https://signal.org/download/"; i="https://seeklogo.com/images/S/signal-logo-5D1E4B1C2E-seeklogo.com.png"},
    @{n="Line"; s=8.1; u="https://line.me/en/download"; i="https://seeklogo.com/images/L/line-logo-4C7D1B3F5E-seeklogo.com.png"},
    @{n="WeChat"; s=8.0; u="https://www.wechat.com/en/download.html"; i="https://seeklogo.com/images/W/wechat-logo-7C4F1A5D3B-seeklogo.com.png"},
    @{n="Zoom Player"; s=7.9; u="https://www.inmatrix.com/zoomplayer/"; i="https://seeklogo.com/images/Z/zoomplayer-logo-4D6B1C2A8E-seeklogo.com.png"},
    @{n="Kodi"; s=7.8; u="https://kodi.tv/download"; i="https://seeklogo.com/images/K/kodi-logo-3B7D1E4C5A-seeklogo.com.png"},
    @{n="MediaMonkey"; s=7.7; u="https://www.mediamonkey.com/download/"; i="https://seeklogo.com/images/M/mediamonkey-logo-2F1D7C5E3A-seeklogo.com.png"}
)

$Visual = @(
    @{n="TranslucentTB"; s=9.5; u="https://apps.microsoft.com/store/detail/translucenttb/9PF4KZ2VN4W9"; i="https://seeklogo.com/images/T/translucenttb-logo-4C5B3D2F1E-seeklogo.com.png"},
    @{n="TaskbarX"; s=9.4; u="https://github.com/ChrisAnd1998/TaskbarX"; i="https://seeklogo.com/images/T/taskbarx-logo-5D2B1C4F3E-seeklogo.com.png"},
    @{n="Rainmeter"; s=9.3; u="https://www.rainmeter.net/"; i="https://seeklogo.com/images/R/rainmeter-logo-4E1F3C2B7D-seeklogo.com.png"},
    @{n="Wallpaper Engine"; s=9.2; u="https://store.steampowered.com/app/431960/Wallpaper_Engine/"; i="https://seeklogo.com/images/W/wallpaper-engine-logo-3F2C5E1D4B-seeklogo.com.png"},
    @{n="Fences"; s=9.1; u="https://www.stardock.com/products/fences/"; i="https://seeklogo.com/images/F/fences-logo-2C1E4D3B6A-seeklogo.com.png"},
    @{n="DisplayFusion"; s=9.0; u="https://www.displayfusion.com/"; i="https://seeklogo.com/images/D/displayfusion-logo-1F3B4C5D7E-seeklogo.com.png"},
    @{n="DeskScapes"; s=8.9; u="https://www.stardock.com/products/deskscapes/"; i="https://seeklogo.com/images/D/deskscapes-logo-5B1C2E3F4D-seeklogo.com.png"},
    @{n="Stardock Curtains"; s=8.8; u="https://www.stardock.com/products/curtains/"; i="https://seeklogo.com/images/S/stardock-curtains-logo-4C5D3E2F1B-seeklogo.com.png"},
    @{n="RocketDock"; s=8.7; u="https://punklabs.com/rocketdock"; i="https://seeklogo.com/images/R/rocketdock-logo-2E1C4B5D7F-seeklogo.com.png"},
    @{n="ObjectDock"; s=8.6; u="https://www.stardock.com/products/objectdock/"; i="https://seeklogo.com/images/O/objectdock-logo-3C2D1E4F5B-seeklogo.com.png"},
    @{n="Rainlendar"; s=8.5; u="https://www.rainlendar.net/"; i="https://seeklogo.com/images/R/rainlendar-logo-1B3C4D5E7F-seeklogo.com.png"},
    @{n="Switcher"; s=8.4; u="https://insentient.net/"; i="https://seeklogo.com/images/S/switcher-logo-4E1B2C3D5F-seeklogo.com.png"},
    @{n="WinDynamicDesktop"; s=8.3; u="https://github.com/t1m0thyj/WinDynamicDesktop"; i="https://seeklogo.com/images/W/windynamicdesktop-logo-3F2C4B1D5E-seeklogo.com.png"},
    @{n="WallpaperHub"; s=8.2; u="https://wallpaperhub.app/"; i="https://seeklogo.com/images/W/wallpaperhub-logo-2E1F3D4B6C-seeklogo.com.png"},
    @{n="Lively Wallpaper"; s=8.1; u="https://rocksdanister.github.io/lively/"; i="https://seeklogo.com/images/L/lively-wallpaper-logo-5C3D1F2E4B-seeklogo.com.png"},
    @{n="DeskPins"; s=8.0; u="https://efotinis.neocities.org/deskpins/"; i="https://seeklogo.com/images/D/deskpins-logo-1E3C4B2F5D-seeklogo.com.png"},
    @{n="WindowBlinds"; s=7.9; u="https://www.stardock.com/products/windowblinds/"; i="https://seeklogo.com/images/W/windowblinds-logo-3C1E4B2D5F-seeklogo.com.png"},
    @{n="Rainmeter Skins"; s=7.8; u="https://www.deviantart.com/rainmeter"; i="https://seeklogo.com/images/R/rainmeter-skins-logo-2B1C4D3E5F-seeklogo.com.png"},
    @{n="WallpaperFusion"; s=7.7; u="https://www.wallpaperfusion.com/"; i="https://seeklogo.com/images/W/wallpaperfusion-logo-4C2D1E3F5B-seeklogo.com.png"},
    @{n="Backdrop"; s=7.6; u="https://backdrop.today/"; i="https://seeklogo.com/images/B/backdrop-logo-3E1C4D2F5B-seeklogo.com.png"}
)

$Window.FindName("BtnMinecraft").Add_Click({ Clear-Content; foreach($m in $Minecraft){ Add-Item $m.n $m.s $m.u $m.i } })
$Window.FindName("BtnMedia").Add_Click({ Clear-Content; foreach($m in $Media){ Add-Item $m.n $m.s $m.u $m.i } })
$Window.FindName("BtnVisual").Add_Click({ Clear-Content; foreach($v in $Visual){ Add-Item $v.n $v.s $v.u $v.i } })
# ================================
# Ultimate Downloader Tool - FULL ŞAHESEER Part 3
# Ekstra animasyon, easter egg, gradient akış ve tam performans
# ================================

# Easter egg notifications rastgele
$EggTimer = New-Object System.Windows.Threading.DispatcherTimer
$EggTimer.Interval = [TimeSpan]::FromSeconds(25)
$EggTimer.Add_Tick({
    $rand = Get-Random -Minimum 1 -Maximum 5
    $msg = switch ($rand) {
        1 {"✨ Gizli item bulundu!"}
        2 {"🚀 Hız modu aktif!"}
        3 {"🕹 Easter egg açıldı!"}
        4 {"🎯 Bonus item hazır!"}
        5 {"🔥 Animasyon patladı!"}
    }
})
$EggTimer.Start()

# Arka plan gradient animasyonu güncelleme
$BackgroundAnimTimer = New-Object System.Windows.Threading.DispatcherTimer
$BackgroundAnimTimer.Interval = [TimeSpan]::FromMilliseconds(40)
$BackgroundAnimTimer.Add_Tick({
    $gradBrush = $Window.FindName("ContentPanel").Parent.Background
    foreach($stop in $gradBrush.GradientStops){
        $offset = $stop.Offset + 0.006
        if($offset -gt 1){$offset = 0}
        $stop.Offset = $offset
    }
})
$BackgroundAnimTimer.Start()

# Hover efektleri güçlendirme: glow + shadow
foreach ($child in $ContentPanel.Children){
    $child.Add_MouseEnter({
        $glow = New-Object System.Windows.Media.Effects.DropShadowEffect
        $glow.Color = [System.Windows.Media.Colors]::Cyan
        $glow.BlurRadius = 18
        $glow.ShadowDepth = 0
        $child.Effect = $glow
    })
    $child.Add_MouseLeave({
        $child.Effect = $null
    })
}

# Smooth scroll eklemeye devam
$MainScroll.PreviewMouseWheel.Add({
    param($s,$e)
    $MainScroll.ScrollToVerticalOffset($MainScroll.VerticalOffset - $e.Delta/4)
    $e.Handled = $true
})

# Full GUI göster
$Window.ShowDialog() | Out-Null

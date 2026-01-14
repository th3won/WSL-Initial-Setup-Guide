; ====================================================================================================
; Roblox Fisch 자동 낚시 매크로 (개선 버전)
; 개선 사항: CPU 사용률 감소, 안정성 향상, 에러 처리 개선
; ====================================================================================================

#SingleInstance Force
#NoEnv
#MaxThreadsPerHotkey 1
SetKeyDelay, -1
SetMouseDelay, -1
SetBatchLines, -1
SetTitleMatchMode, 2
SetWinDelay, 0
SetControlDelay, -1

CoordMode, Tooltip, Relative
CoordMode, Pixel, Relative
CoordMode, Mouse, Relative

; ====================================================================================================
;     일반 설정 (GENERAL SETTINGS)
; ====================================================================================================

; 자동으로 그래픽을 1로 낮출지 여부
AutoLowerGraphics := true
AutoGraphicsDelay := 50

; 자동으로 카메라 줌인 여부
AutoZoomInCamera := true
AutoZoomDelay := 50

; 카메라 모드 자동 활성화 여부
AutoEnableCameraMode := true
AutoCameraDelay := 5

; 자동으로 카메라를 아래로 향하게 할지 여부
AutoLookDownCamera := true
AutoLookDelay := 200

; 자동 카메라 블러 활성화 여부
AutoBlurCamera := true
AutoBlurDelay := 50

; 낚시 후 재시작 대기 시간
RestartDelay := 1000

; 낚싯대 캐스팅 유지 시간
HoldRodCastDuration := 1000

; 찌가 물에 떨어질 때까지 대기 시간
WaitForBobberDelay := 1000

; 네비게이션 키 설정 (중요!)
NavigationKey := "#"

; 성능 최적화: 픽셀 검색 간격 (밀리초)
PixelSearchDelay := 10

; Roblox 창 활성화 체크 간격 (밀리초)
WindowCheckInterval := 500

; ====================================================================================================
;     흔들기 설정 (SHAKE SETTINGS)
; ====================================================================================================

; "Navigation" 또는 "Click" 중 선택
ShakeMode := "Click"

; 물고기 바 색상 허용 오차 (0-255, 높을수록 관대함)
FishBarColorTolerance := 3

; 클릭 흔들기 실패 제한 시간 (초)
ClickShakeFailsafe := 20
; "shake" 텍스트 색상 허용 오차
ClickShakeColorTolerance := 5
; 스캔 간격 (밀리초)
ClickScanDelay := 100
; 반복 무시 카운터
RepeatBypassCounter := 10

; 네비게이션 흔들기 실패 제한 시간 (초)
NavigationShakeFailsafe := 30
; "S+Enter" 스팸 간격 (밀리초)
NavigationSpamDelay := 10

; ====================================================================================================
;     미니게임 설정 (MINIGAME SETTINGS)
; ====================================================================================================

; 바 크기 자동 계산, 수동 값으로 오버라이드 가능
ManualBarSize := 0
; 계산 실패 제한 시간 (초)
BarCalculationFailsafe := 10
; 초기 흰색 바 색상 허용 오차
BarSizeCalculationColorTolerance := 20

; 미니게임 흰색 바 색상 허용 오차
WhiteBarColorTolerance := 10
; 미니게임 화살표 색상 허용 오차
ArrowColorTolerance := 3

; 액션 사이클당 클릭 횟수
StabilizerLoop := 10
; 바 측면 최대 유지 비율 (1 = 최대|0.5 = 절반)
SideBarRatio := 0.8
; 바운스 방지를 위한 측면 대기 시간 배율
SideBarWaitMultiplier := 4.5

; 안정 구역에서 오른쪽 이동 강도
StableRightMultiplier := 2
; 안정 구역 오른쪽 이동 후 카운터
StableRightDivision := 1.3
; 안정 구역에서 왼쪽 이동 강도
StableLeftMultiplier := 1.8
; 안정 구역 왼쪽 이동 후 카운터
StableLeftDivision := 1.3

; 불안정 구역에서 오른쪽 이동 강도
UnstableRightMultiplier := 2.4
; 불안정 구역 오른쪽 이동 후 카운터
UnstableRightDivision := 1.3
; 불안정 구역에서 왼쪽 이동 강도
UnstableLeftMultiplier := 2.4
; 불안정 구역 왼쪽 이동 후 카운터
UnstableLeftDivision := 1.3

; 중앙 이동 후 오른쪽 조정 강도
RightAnkleBreakMultiplier := 0.9
; 중앙 이동 후 왼쪽 조정 강도
LeftAnkleBreakMultiplier := 0.5

; ====================================================================================================
;     디버그 설정 (DEBUG SETTINGS)
; ====================================================================================================

; 디버그 로그 활성화 (true/false)
EnableDebugLog := false
; 로그 파일 경로
DebugLogFile := A_ScriptDir . "\FischMacro_Debug.log"

; ====================================================================================================
;     설정 검증
; ====================================================================================================

if (AutoLowerGraphics != true and AutoLowerGraphics != false)
{
    MsgBox, AutoLowerGraphics must be set to true or false! (check your spelling)
    ExitApp
}

if (AutoEnableCameraMode != true and AutoEnableCameraMode != false)
{
    MsgBox, AutoEnableCameraMode must be set to true or false! (check your spelling)
    ExitApp
}

if (AutoZoomInCamera != true and AutoZoomInCamera != false)
{
    MsgBox, AutoZoomInCamera must be set to true or false! (check your spelling)
    ExitApp
}

if (AutoLookDownCamera != true and AutoLookDownCamera != false)
{
    MsgBox, AutoLookDownCamera must be set to true or false! (check your spelling)
    ExitApp
}

if (AutoBlurCamera != true and AutoBlurCamera != false)
{
    MsgBox, AutoBlurCamera must be set to true or false! (check your spelling)
    ExitApp
}

if (ShakeMode != "Navigation" and ShakeMode != "Click")
{
    MsgBox, ShakeMode must be set to "Click" or "Navigation"! (check your spelling)
    ExitApp
}

; ====================================================================================================
;     Roblox 창 확인 및 활성화
; ====================================================================================================

WinActivate, Roblox
Sleep, 100
if WinActive("Roblox")
{
    WinMaximize, Roblox
    Sleep, 100
}
else
{
    MsgBox, Roblox 창을 찾을 수 없습니다!`n`nRoblox가 실행 중인지 확인하세요.
    ExitApp
}

; ====================================================================================================
;     초기화
; ====================================================================================================

Send {LButton Up}
Send {RButton Up}
Send {Shift Up}
Sleep, 50

; ====================================================================================================
;     좌표 및 변수 계산
; ====================================================================================================

Calculations:
WinGetActiveStats, Title, WindowWidth, WindowHeight, WindowLeft, WindowTop

CameraCheckLeft := WindowWidth/2.8444
CameraCheckRight := WindowWidth/1.5421
CameraCheckTop := WindowHeight/1.28
CameraCheckBottom := WindowHeight

ClickShakeLeft := WindowWidth/4.6545
ClickShakeRight := WindowWidth/1.2736
ClickShakeTop := WindowHeight/14.08
ClickShakeBottom := WindowHeight/1.3409

FishBarLeft := WindowWidth/3.3160
FishBarRight := WindowWidth/1.4317
FishBarTop := WindowHeight/1.1871
FishBarBottom := WindowHeight/1.1512

FishBarTooltipHeight := WindowHeight/1.0626

ResolutionScaling := 2560/WindowWidth

LookDownX := WindowWidth/2
LookDownY := WindowHeight/4

runtimeS := 0
runtimeM := 0
runtimeH := 0

TooltipX := WindowWidth/20
Tooltip1 := (WindowHeight/2)-(20*9)
Tooltip2 := (WindowHeight/2)-(20*8)
Tooltip3 := (WindowHeight/2)-(20*7)
Tooltip4 := (WindowHeight/2)-(20*6)
Tooltip5 := (WindowHeight/2)-(20*5)
Tooltip6 := (WindowHeight/2)-(20*4)
Tooltip7 := (WindowHeight/2)-(20*3)
Tooltip8 := (WindowHeight/2)-(20*2)
Tooltip9 := (WindowHeight/2)-(20*1)
Tooltip10 := (WindowHeight/2)
Tooltip11 := (WindowHeight/2)+(20*1)
Tooltip12 := (WindowHeight/2)+(20*2)
Tooltip13 := (WindowHeight/2)+(20*3)
Tooltip14 := (WindowHeight/2)+(20*4)
Tooltip15 := (WindowHeight/2)+(20*5)
Tooltip16 := (WindowHeight/2)+(20*6)
Tooltip17 := (WindowHeight/2)+(20*7)
Tooltip18 := (WindowHeight/2)+(20*8)
Tooltip19 := (WindowHeight/2)+(20*9)
Tooltip20 := (WindowHeight/2)+(20*10)

; 초기 툴팁 표시
Tooltip, Made By AsphaltCake (Improved), %TooltipX%, %Tooltip1%, 1
Tooltip, Runtime: 0h 0m 0s, %TooltipX%, %Tooltip2%, 2

Tooltip, Press "P" to Start, %TooltipX%, %Tooltip4%, 4
Tooltip, Press "O" to Reload, %TooltipX%, %Tooltip5%, 5
Tooltip, Press "M" to Exit, %TooltipX%, %Tooltip6%, 6

if (AutoLowerGraphics == true)
{
    Tooltip, AutoLowerGraphics: true, %TooltipX%, %Tooltip8%, 8
}
else
{
    Tooltip, AutoLowerGraphics: false, %TooltipX%, %Tooltip8%, 8
}

if (AutoEnableCameraMode == true)
{
    Tooltip, AutoEnableCameraMode: true, %TooltipX%, %Tooltip9%, 9
}
else
{
    Tooltip, AutoEnableCameraMode: false, %TooltipX%, %Tooltip9%, 9
}

if (AutoZoomInCamera == true)
{
    Tooltip, AutoZoomInCamera: true, %TooltipX%, %Tooltip10%, 10
}
else
{
    Tooltip, AutoZoomInCamera: false, %TooltipX%, %Tooltip10%, 10
}

if (AutoLookDownCamera == true)
{
    Tooltip, AutoLookDownCamera: true, %TooltipX%, %Tooltip11%, 11
}
else
{
    Tooltip, AutoLookDownCamera: false, %TooltipX%, %Tooltip11%, 11
}

if (AutoBlurCamera == true)
{
    Tooltip, AutoBlurCamera: true, %TooltipX%, %Tooltip12%, 12
}
else
{
    Tooltip, AutoBlurCamera: false, %TooltipX%, %Tooltip12%, 12
}

Tooltip, Navigation Key: "%NavigationKey%", %TooltipX%, %Tooltip14%, 14

if (ShakeMode == "Click")
{
    Tooltip, Shake Mode: "Click", %TooltipX%, %Tooltip16%, 16
}
else
{
    Tooltip, Shake Mode: "Navigation", %TooltipX%, %Tooltip16%, 16
}

Return

; ====================================================================================================
;     런타임 타이머
; ====================================================================================================

runtime:
runtimeS++
if (runtimeS >= 60)
{
    runtimeS := 0
    runtimeM++
}
if (runtimeM >= 60)
{
    runtimeM := 0
    runtimeH++
}

if !WinActive("Roblox")
{
    MsgBox, Roblox 창이 비활성화되어 매크로를 중지합니다.
    ExitApp
}
else
{
    Tooltip, Runtime: %runtimeH%h %runtimeM%m %runtimeS%s, %TooltipX%, %Tooltip2%, 2
}
Return

; ====================================================================================================
;     핫키 설정
; ====================================================================================================

$o:: Reload
$m:: ExitApp
$p::

; ====================================================================================================
;     메인 루프 시작
; ====================================================================================================

Gosub, Calculations
SetTimer, runtime, 1000

Tooltip, Press "O" to Reload, %TooltipX%, %Tooltip4%, 4
Tooltip, Press "M" to Exit, %TooltipX%, %Tooltip5%, 5

Tooltip, , , , 6
Tooltip, , , , 10
Tooltip, , , , 11
Tooltip, , , , 12
Tooltip, , , , 14
Tooltip, , , , 16

; ====================================================================================================
;     그래픽 설정 자동 조정
; ====================================================================================================

Tooltip, Current Task: AutoLowerGraphics, %TooltipX%, %Tooltip7%, 7
Tooltip, F10 Count: 0/20, %TooltipX%, %Tooltip9%, 9
f10counter := 0

if (AutoLowerGraphics == true)
{
    Send {Shift}
    Tooltip, Action: Press Shift, %TooltipX%, %Tooltip8%, 8
    Sleep %AutoGraphicsDelay%
    Send {Shift Down}
    Tooltip, Action: Hold Shift, %TooltipX%, %Tooltip8%, 8
    Sleep %AutoGraphicsDelay%

    Loop, 20
    {
        ; Roblox 창 활성화 체크
        if !WinActive("Roblox")
        {
            WinActivate, Roblox
            Sleep, 100
        }

        f10counter++
        Tooltip, F10 Count: %f10counter%/20, %TooltipX%, %Tooltip9%, 9
        Send {F10}
        Tooltip, Action: Press F10, %TooltipX%, %Tooltip8%, 8
        Sleep %AutoGraphicsDelay%
    }

    Send {Shift Up}
    Tooltip, Action: Release Shift, %TooltipX%, %Tooltip8%, 8
    Sleep %AutoGraphicsDelay%
}

; ====================================================================================================
;     카메라 줌 자동 조정
; ====================================================================================================

Tooltip, Current Task: AutoZoomInCamera, %TooltipX%, %Tooltip7%, 7
Tooltip, Scroll In: 0/20, %TooltipX%, %Tooltip9%, 9
Tooltip, Scroll Out: 0/1, %TooltipX%, %Tooltip10%, 10
scrollcounter := 0

if (AutoZoomInCamera == true)
{
    Sleep %AutoZoomDelay%

    Loop, 20
    {
        if !WinActive("Roblox")
        {
            WinActivate, Roblox
            Sleep, 100
        }

        scrollcounter++
        Tooltip, Scroll In: %scrollcounter%/20, %TooltipX%, %Tooltip9%, 9
        Send {WheelUp}
        Tooltip, Action: Scroll In, %TooltipX%, %Tooltip8%, 8
        Sleep %AutoZoomDelay%
    }

    Send {WheelDown}
    Tooltip, Scroll Out: 1/1, %TooltipX%, %Tooltip10%, 10
    Tooltip, Action: Scroll Out, %TooltipX%, %Tooltip8%, 8
    AutoZoomDelay := AutoZoomDelay*5
    Sleep %AutoZoomDelay%
}

Tooltip, , , , 10

; ====================================================================================================
;     카메라 모드 자동 활성화
; ====================================================================================================

Tooltip, Current Task: AutoEnableCameraMode, %TooltipX%, %Tooltip7%, 7
Tooltip, Right Count: 0/10, %TooltipX%, %Tooltip9%, 9
rightcounter := 0

if (AutoEnableCameraMode == true)
{
    PixelSearch, , , CameraCheckLeft, CameraCheckTop, CameraCheckRight, CameraCheckBottom, 0xFFFFFF, 0, Fast
    if (ErrorLevel == 0)
    {
        Sleep %AutoCameraDelay%
        Send {2}
        Tooltip, Action: Press 2, %TooltipX%, %Tooltip8%, 8
        Sleep %AutoCameraDelay%
        Send {1}
        Tooltip, Action: Press 1, %TooltipX%, %Tooltip8%, 8
        Sleep %AutoCameraDelay%
        Send {%NavigationKey%}
        Tooltip, Action: Press %NavigationKey%, %TooltipX%, %Tooltip8%, 8
        Sleep %AutoCameraDelay%

        Loop, 10
        {
            if !WinActive("Roblox")
            {
                WinActivate, Roblox
                Sleep, 100
            }

            rightcounter++
            Tooltip, Right Count: %rightcounter%/10, %TooltipX%, %Tooltip9%, 9
            Send {Right}
            Tooltip, Action: Press Right, %TooltipX%, %Tooltip8%, 8
            Sleep %AutoCameraDelay%
        }

        Send {Enter}
        Tooltip, Action: Press Enter, %TooltipX%, %Tooltip8%, 8
        Sleep %AutoCameraDelay%
    }
}

; ====================================================================================================
;     메인 낚시 루프
; ====================================================================================================

RestartMacro:

Tooltip, , , , 9

; 카메라를 아래로 향하게 설정
Tooltip, Current Task: AutoLookDownCamera, %TooltipX%, %Tooltip7%, 7

if (AutoLookDownCamera == true)
{
    Send {RButton Up}
    Sleep %AutoLookDelay%
    MouseMove, LookDownX, LookDownY
    Tooltip, Action: Position Mouse, %TooltipX%, %Tooltip8%, 8
    Sleep %AutoLookDelay%
    Send {RButton Down}
    Tooltip, Action: Hold Right Click, %TooltipX%, %Tooltip8%, 8
    Sleep %AutoLookDelay%
    DllCall("mouse_event", "UInt", 0x01, "UInt", 0, "UInt", 10000)
    Tooltip, Action: Move Mouse Down, %TooltipX%, %Tooltip8%, 8
    Sleep %AutoLookDelay%
    Send {RButton Up}
    Tooltip, Action: Release Right Click, %TooltipX%, %Tooltip8%, 8
    Sleep %AutoLookDelay%
    MouseMove, LookDownX, LookDownY
    Tooltip, Action: Position Mouse, %TooltipX%, %Tooltip8%, 8
    Sleep %AutoLookDelay%
}

; 카메라 블러 활성화
Tooltip, Current Task: AutoBlurCamera, %TooltipX%, %Tooltip7%, 7

if (AutoBlurCamera == true)
{
    Sleep %AutoBlurDelay%
    Send {m}
    Tooltip, Action: Press M, %TooltipX%, %Tooltip8%, 8
    Sleep %AutoBlurDelay%
}

; 낚싯대 캐스팅
Tooltip, Current Task: Casting Rod, %TooltipX%, %Tooltip7%, 7

if !WinActive("Roblox")
{
    WinActivate, Roblox
    Sleep, 100
}

Send {LButton Down}
Tooltip, Action: Casting For %HoldRodCastDuration%ms, %TooltipX%, %Tooltip8%, 8
Sleep %HoldRodCastDuration%
Send {LButton Up}
Tooltip, Action: Waiting For Bobber (%WaitForBobberDelay%ms), %TooltipX%, %Tooltip8%, 8
Sleep %WaitForBobberDelay%

; 흔들기 모드 선택
if (ShakeMode == "Click")
    Goto ClickShakeMode
else if (ShakeMode == "Navigation")
    Goto NavigationShakeMode

; ====================================================================================================
;     클릭 흔들기 모드
; ====================================================================================================

ClickShakeFailsafe:
ClickFailsafeCount++
Tooltip, Failsafe: %ClickFailsafeCount%/%ClickShakeFailsafe%, %TooltipX%, %Tooltip14%, 14
if (ClickFailsafeCount >= ClickShakeFailsafe)
{
    SetTimer, ClickShakeFailsafe, Off
    ForceReset := true
}
Return

ClickShakeMode:

Tooltip, Current Task: Shaking, %TooltipX%, %Tooltip7%, 7
Tooltip, Click X: None, %TooltipX%, %Tooltip8%, 8
Tooltip, Click Y: None, %TooltipX%, %Tooltip9%, 9
Tooltip, Click Count: 0, %TooltipX%, %Tooltip11%, 11
Tooltip, Bypass Count: 0/%RepeatBypassCounter%, %TooltipX%, %Tooltip12%, 12
Tooltip, Failsafe: 0/%ClickShakeFailsafe%, %TooltipX%, %Tooltip14%, 14

ClickFailsafeCount := 0
ClickCount := 0
ClickShakeRepeatBypassCounter := 0
MemoryX := 0
MemoryY := 0
ForceReset := false

SetTimer, ClickShakeFailsafe, 1000

ClickShakeModeRedo:
if (ForceReset == true)
{
    Tooltip, , , , 11
    Tooltip, , , , 12
    Tooltip, , , , 14
    Goto RestartMacro
}

; CPU 사용률 감소를 위한 딜레이
Sleep %ClickScanDelay%

; Roblox 창 활성화 체크
if !WinActive("Roblox")
{
    WinActivate, Roblox
    Sleep, 100
}

; 물고기 바 검색
PixelSearch, , , FishBarLeft, FishBarTop, FishBarRight, FishBarBottom, 0x5B4B43, %FishBarColorTolerance%, Fast
if (ErrorLevel == 0)
{
    SetTimer, ClickShakeFailsafe, Off
    Tooltip, , , , 9
    Tooltip, , , , 11
    Tooltip, , , , 12
    Tooltip, , , , 14
    Goto BarMinigame
}
else
{
    ; "shake" 텍스트 검색
    PixelSearch, ClickX, ClickY, ClickShakeLeft, ClickShakeTop, ClickShakeRight, ClickShakeBottom, 0xFFFFFF, %ClickShakeColorTolerance%, Fast
    if (ErrorLevel == 0)
    {
        Tooltip, Click X: %ClickX%, %TooltipX%, %Tooltip8%, 8
        Tooltip, Click Y: %ClickY%, %TooltipX%, %Tooltip9%, 9

        ; 이전 위치와 다른 경우에만 클릭
        if (ClickX != MemoryX and ClickY != MemoryY)
        {
            ClickShakeRepeatBypassCounter := 0
            Tooltip, Bypass Count: %ClickShakeRepeatBypassCounter%/%RepeatBypassCounter%, %TooltipX%, %Tooltip12%, 12
            ClickCount++
            Click, %ClickX%, %ClickY%
            Tooltip, Click Count: %ClickCount%, %TooltipX%, %Tooltip11%, 11
            MemoryX := ClickX
            MemoryY := ClickY
            Goto ClickShakeModeRedo
        }
        else
        {
            ; 반복 무시 카운터 증가
            ClickShakeRepeatBypassCounter++
            Tooltip, Bypass Count: %ClickShakeRepeatBypassCounter%/%RepeatBypassCounter%, %TooltipX%, %Tooltip12%, 12
            if (ClickShakeRepeatBypassCounter >= RepeatBypassCounter)
            {
                MemoryX := 0
                MemoryY := 0
            }
            Goto ClickShakeModeRedo
        }
    }
    else
    {
        Goto ClickShakeModeRedo
    }
}

; ====================================================================================================
;     네비게이션 흔들기 모드
; ====================================================================================================

NavigationShakeFailsafe:
NavigationFailsafeCount++
Tooltip, Failsafe: %NavigationFailsafeCount%/%NavigationShakeFailsafe%, %TooltipX%, %Tooltip10%, 10
if (NavigationFailsafeCount >= NavigationShakeFailsafe)
{
    SetTimer, NavigationShakeFailsafe, Off
    ForceReset := true
}
Return

NavigationShakeMode:

Tooltip, Current Task: Shaking, %TooltipX%, %Tooltip7%, 7
Tooltip, Attempt Count: 0, %TooltipX%, %Tooltip8%, 8
Tooltip, Failsafe: 0/%NavigationShakeFailsafe%, %TooltipX%, %Tooltip10%, 10

NavigationFailsafeCount := 0
NavigationCounter := 0
ForceReset := false

SetTimer, NavigationShakeFailsafe, 1000
Send {%NavigationKey%}

NavigationShakeModeRedo:
if (ForceReset == true)
{
    Tooltip, , , , 10
    Goto RestartMacro
}

; CPU 사용률 감소를 위한 딜레이
Sleep %NavigationSpamDelay%

; Roblox 창 활성화 체크
if !WinActive("Roblox")
{
    WinActivate, Roblox
    Sleep, 100
}

; 물고기 바 검색
PixelSearch, , , FishBarLeft, FishBarTop, FishBarRight, FishBarBottom, 0x5B4B43, %FishBarColorTolerance%, Fast
if (ErrorLevel == 0)
{
    SetTimer, NavigationShakeFailsafe, Off
    Goto BarMinigame
}
else
{
    NavigationCounter++
    Tooltip, Attempt Count: %NavigationCounter%, %TooltipX%, %Tooltip8%, 8
    Sleep 1
    Send {s}
    Sleep 1
    Send {Enter}
    Goto NavigationShakeModeRedo
}

; ====================================================================================================
;     바 크기 계산
; ====================================================================================================

BarCalculationFailsafe:
BarCalcFailsafeCounter++
Tooltip, Failsafe: %BarCalcFailsafeCounter%/%BarCalculationFailsafe%, %TooltipX%, %Tooltip10%, 10
if (BarCalcFailsafeCounter >= BarCalculationFailsafe)
{
    SetTimer, BarCalculationFailsafe, Off
    ForceReset := true
}
Return

BarMinigame:

Tooltip, Current Task: Calculating Bar Size, %TooltipX%, %Tooltip7%, 7
Tooltip, Bar Size: Not Found, %TooltipX%, %Tooltip8%, 8
Tooltip, Failsafe: 0/%BarCalculationFailsafe%, %TooltipX%, %Tooltip10%, 10

ForceReset := false
BarCalcFailsafeCounter := 0

SetTimer, BarCalculationFailsafe, 1000

BarMinigameRedo:
if (ForceReset == true)
{
    Tooltip, , , , 10
    Goto RestartMacro
}

; Roblox 창 활성화 체크
if !WinActive("Roblox")
{
    WinActivate, Roblox
    Sleep, 100
}

; 흰색 바 검색
PixelSearch, BarX, , FishBarLeft, FishBarTop, FishBarRight, FishBarBottom, 0xFFFFFF, %BarSizeCalculationColorTolerance%, Fast
if (ErrorLevel == 0)
{
    SetTimer, BarCalculationFailsafe, Off

    if (ManualBarSize != 0)
    {
        WhiteBarSize := ManualBarSize
        Goto BarMinigameSingle
    }

    WhiteBarSize := (FishBarRight-(BarX-FishBarLeft))-BarX
    Goto BarMinigameSingle
}

; CPU 사용률 감소
Sleep %PixelSearchDelay%
Goto BarMinigameRedo

; ====================================================================================================
;     바 미니게임 (개선된 안정성)
; ====================================================================================================

BarMinigameSingle:

Tooltip, Current Task: Playing Bar Minigame, %TooltipX%, %Tooltip7%, 7
Tooltip, Bar Size: %WhiteBarSize%, %TooltipX%, %Tooltip8%, 8
Tooltip, Direction: None, %TooltipX%, %Tooltip10%, 10
Tooltip, Forward Delay: None, %TooltipX%, %Tooltip11%, 11
Tooltip, Counter Delay: None, %TooltipX%, %Tooltip12%, 12
Tooltip, Ankle Delay: None, %TooltipX%, %Tooltip13%, 13
Tooltip, Side Delay: None, %TooltipX%, %Tooltip15%, 15

HalfBarSize := WhiteBarSize/2
SideDelay := 0
AnkleBreakDelay := 0
DirectionalToggle := "Disabled"
AtLeastFindWhiteBar := false

MaxLeftToggle := false
MaxRightToggle := false
MaxLeftBar := FishBarLeft+WhiteBarSize*SideBarRatio
MaxRightBar := FishBarRight-WhiteBarSize*SideBarRatio

Tooltip, |, %MaxLeftBar%, %FishBarTooltipHeight%, 18
Tooltip, |, %MaxRightBar%, %FishBarTooltipHeight%, 17

BarMinigame2:

; CPU 사용률 감소
Sleep 1

; Roblox 창 활성화 체크 (주기적으로)
if (Mod(A_TickCount, WindowCheckInterval) == 0)
{
    if !WinActive("Roblox")
    {
        WinActivate, Roblox
        Sleep, 50
    }
}

; 물고기 위치 검색
PixelSearch, FishX, , FishBarLeft, FishBarTop, FishBarRight, FishBarBottom, 0x5B4B43, %FishBarColorTolerance%, Fast
if (ErrorLevel == 0)
{
    Tooltip, ., %FishX%, %FishBarTooltipHeight%, 20

    ; 최대 왼쪽 체크
    if (FishX < MaxLeftBar)
    {
        if (MaxLeftToggle == false)
        {
            Tooltip, <, %MaxLeftBar%, %FishBarTooltipHeight%, 19
            Tooltip, Direction: Max Left, %TooltipX%, %Tooltip10%, 10
            Tooltip, Forward Delay: Infinite, %TooltipX%, %Tooltip11%, 11
            Tooltip, Counter Delay: None, %TooltipX%, %Tooltip12%, 12
            Tooltip, Ankle Delay: 0, %TooltipX%, %Tooltip13%, 13
            DirectionalToggle := "Right"
            MaxLeftToggle := true
            Send {LButton Up}
            Sleep 1
            Send {LButton Up}
            Sleep %SideDelay%
            AnkleBreakDelay := 0
            SideDelay := 0
            Tooltip, Side Delay: 0, %TooltipX%, %Tooltip15%, 15
        }
        Goto BarMinigame2
    }

    ; 최대 오른쪽 체크
    else if (FishX > MaxRightBar)
    {
        if (MaxRightToggle == false)
        {
            Tooltip, >, %MaxRightBar%, %FishBarTooltipHeight%, 19
            Tooltip, Direction: Max Right, %TooltipX%, %Tooltip10%, 10
            Tooltip, Forward Delay: Infinite, %TooltipX%, %Tooltip11%, 11
            Tooltip, Counter Delay: None, %TooltipX%, %Tooltip12%, 12
            Tooltip, Ankle Delay: 0, %TooltipX%, %Tooltip13%, 13
            DirectionalToggle := "Left"
            MaxRightToggle := true
            Send {LButton Down}
            Sleep 1
            Send {LButton Down}
            Sleep %SideDelay%
            AnkleBreakDelay := 0
            SideDelay := 0
            Tooltip, Side Delay: 0, %TooltipX%, %Tooltip15%, 15
        }
        Goto BarMinigame2
    }

    MaxLeftToggle := false
    MaxRightToggle := false

    ; 흰색 바 검색
    PixelSearch, BarX, , FishBarLeft, FishBarTop, FishBarRight, FishBarBottom, 0xFFFFFF, %WhiteBarColorTolerance%, Fast
    if (ErrorLevel == 0)
    {
        AtLeastFindWhiteBar := true
        BarX := BarX+(WhiteBarSize/2)

        ; 왼쪽으로 이동 필요
        if (BarX > FishX)
        {
            Tooltip, <, %BarX%, %FishBarTooltipHeight%, 19
            Tooltip, Direction: <, %TooltipX%, %Tooltip10%, 10
            Difference := (BarX-FishX)*ResolutionScaling*StableLeftMultiplier
            CounterDifference := Difference/StableLeftDivision
            Tooltip, Forward Delay: %Difference%, %TooltipX%, %Tooltip11%, 11
            Tooltip, Counter Delay: %CounterDifference%, %TooltipX%, %Tooltip12%, 12

            Send {LButton Up}

            if (DirectionalToggle == "Right")
            {
                Tooltip, Ankle Delay: 0, %TooltipX%, %Tooltip13%, 13
                Sleep %AnkleBreakDelay%
                AnkleBreakDelay := 0
            }
            else
            {
                AnkleBreakDelay := AnkleBreakDelay+(Difference-CounterDifference)*LeftAnkleBreakMultiplier
                SideDelay := AnkleBreakDelay/LeftAnkleBreakMultiplier*SideBarWaitMultiplier
                Tooltip, Ankle Delay: %AnkleBreakDelay%, %TooltipX%, %Tooltip13%, 13
                Tooltip, Side Delay: %SideDelay%, %TooltipX%, %Tooltip15%, 15
            }

            Sleep %Difference%

            ; 재검사
            PixelSearch, FishX, , FishBarLeft, FishBarTop, FishBarRight, FishBarBottom, 0x5B4B43, %FishBarColorTolerance%, Fast
            if (ErrorLevel == 0)
            {
                if (FishX < MaxLeftBar)
                    Goto BarMinigame2
            }

            Send {LButton Down}
            Sleep %CounterDifference%

            Loop, %StabilizerLoop%
            {
                Send {LButton Down}
                Send {LButton Up}
            }

            DirectionalToggle := "Left"
        }

        ; 오른쪽으로 이동 필요
        else
        {
            Tooltip, >, %BarX%, %FishBarTooltipHeight%, 19
            Tooltip, Direction: >, %TooltipX%, %Tooltip10%, 10
            Difference := (FishX-BarX)*ResolutionScaling*StableRightMultiplier
            CounterDifference := Difference/StableRightDivision
            Tooltip, Forward Delay: %Difference%, %TooltipX%, %Tooltip11%, 11
            Tooltip, Counter Delay: %CounterDifference%, %TooltipX%, %Tooltip12%, 12

            Send {LButton Down}

            if (DirectionalToggle == "Left")
            {
                Tooltip, Ankle Delay: 0, %TooltipX%, %Tooltip13%, 13
                Sleep %AnkleBreakDelay%
                AnkleBreakDelay := 0
            }
            else
            {
                AnkleBreakDelay := AnkleBreakDelay+(Difference-CounterDifference)*RightAnkleBreakMultiplier
                SideDelay := AnkleBreakDelay/RightAnkleBreakMultiplier*SideBarWaitMultiplier
                Tooltip, Ankle Delay: %AnkleBreakDelay%, %TooltipX%, %Tooltip13%, 13
                Tooltip, Side Delay: %SideDelay%, %TooltipX%, %Tooltip15%, 15
            }

            Sleep %Difference%

            ; 재검사
            PixelSearch, FishX, , FishBarLeft, FishBarTop, FishBarRight, FishBarBottom, 0x5B4B43, %FishBarColorTolerance%, Fast
            if (ErrorLevel == 0)
            {
                if (FishX > MaxRightBar)
                    Goto BarMinigame2
            }

            Send {LButton Up}
            Sleep %CounterDifference%

            Loop, %StabilizerLoop%
            {
                Send {LButton Down}
                Send {LButton Up}
            }

            DirectionalToggle := "Right"
        }
    }

    ; 흰색 바를 찾지 못한 경우 (화살표 모드)
    else
    {
        if (AtLeastFindWhiteBar == false)
        {
            Send {LButton Down}
            Send {LButton Up}
            Goto BarMinigame2
        }

        ; 화살표 검색
        PixelSearch, ArrowX, , FishBarLeft, FishBarTop, FishBarRight, FishBarBottom, 0x878584, %ArrowColorTolerance%, Fast

        ; 왼쪽으로 이동 (불안정)
        if (ArrowX > FishX)
        {
            Tooltip, <, %ArrowX%, %FishBarTooltipHeight%, 19
            Tooltip, Direction: <<<, %TooltipX%, %Tooltip10%, 10
            Difference := HalfBarSize*UnstableLeftMultiplier
            CounterDifference := Difference/UnstableLeftDivision
            Tooltip, Forward Delay: %Difference%, %TooltipX%, %Tooltip11%, 11
            Tooltip, Counter Delay: %CounterDifference%, %TooltipX%, %Tooltip12%, 12

            Send {LButton Up}

            if (DirectionalToggle == "Right")
            {
                Tooltip, Ankle Delay: 0, %TooltipX%, %Tooltip13%, 13
                Sleep %AnkleBreakDelay%
                AnkleBreakDelay := 0
            }
            else
            {
                AnkleBreakDelay := AnkleBreakDelay+(Difference-CounterDifference)*LeftAnkleBreakMultiplier
                SideDelay := AnkleBreakDelay/LeftAnkleBreakMultiplier*SideBarWaitMultiplier
                Tooltip, Ankle Delay: %AnkleBreakDelay%, %TooltipX%, %Tooltip13%, 13
                Tooltip, Side Delay: %SideDelay%, %TooltipX%, %Tooltip15%, 15
            }

            Sleep %Difference%

            ; 재검사
            PixelSearch, FishX, , FishBarLeft, FishBarTop, FishBarRight, FishBarBottom, 0x5B4B43, %FishBarColorTolerance%, Fast
            if (ErrorLevel == 0)
            {
                if (FishX < MaxLeftBar)
                    Goto BarMinigame2
            }

            Send {LButton Down}
            Sleep %CounterDifference%

            Loop, %StabilizerLoop%
            {
                Send {LButton Down}
                Send {LButton Up}
            }

            DirectionalToggle := "Left"
        }

        ; 오른쪽으로 이동 (불안정)
        else
        {
            Tooltip, >, %ArrowX%, %FishBarTooltipHeight%, 19
            Tooltip, Direction: >>>, %TooltipX%, %Tooltip10%, 10
            Difference := HalfBarSize*UnstableRightMultiplier
            CounterDifference := Difference/UnstableRightDivision
            Tooltip, Forward Delay: %Difference%, %TooltipX%, %Tooltip11%, 11
            Tooltip, Counter Delay: %CounterDifference%, %TooltipX%, %Tooltip12%, 12

            Send {LButton Down}

            if (DirectionalToggle == "Left")
            {
                Tooltip, Ankle Delay: 0, %TooltipX%, %Tooltip13%, 13
                Sleep %AnkleBreakDelay%
                AnkleBreakDelay := 0
            }
            else
            {
                AnkleBreakDelay := AnkleBreakDelay+(Difference-CounterDifference)*RightAnkleBreakMultiplier
                SideDelay := AnkleBreakDelay/RightAnkleBreakMultiplier*SideBarWaitMultiplier
                Tooltip, Ankle Delay: %AnkleBreakDelay%, %TooltipX%, %Tooltip13%, 13
                Tooltip, Side Delay: %SideDelay%, %TooltipX%, %Tooltip15%, 15
            }

            Sleep %Difference%

            ; 재검사
            PixelSearch, FishX, , FishBarLeft, FishBarTop, FishBarRight, FishBarBottom, 0x5B4B43, %FishBarColorTolerance%, Fast
            if (ErrorLevel == 0)
            {
                if (FishX > MaxRightBar)
                    Goto BarMinigame2
            }

            Send {LButton Up}
            Sleep %CounterDifference%

            Loop, %StabilizerLoop%
            {
                Send {LButton Down}
                Send {LButton Up}
            }

            DirectionalToggle := "Right"
        }
    }

    Goto BarMinigame2
}

; 미니게임 종료 (물고기를 잡았거나 놓쳤음)
else
{
    Tooltip, , , , 10
    Tooltip, , , , 11
    Tooltip, , , , 12
    Tooltip, , , , 13
    Tooltip, , , , 15
    Tooltip, , , , 17
    Tooltip, , , , 18
    Tooltip, , , , 19
    Tooltip, , , , 20

    Sleep %RestartDelay%
    Goto RestartMacro
}

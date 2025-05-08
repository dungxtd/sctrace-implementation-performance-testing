*** Settings ***
Library    AppiumLibrary
Library    BuiltIn
Library    OperatingSystem

*** Variables ***
${REMOTE_ADB}    Get Environment Variable    REMOTE_ADB    false
${REMOTE_ADB_HOST}    Set Variable If    '${REMOTE_ADB}' == true    host.docker.internal    ELSE    localhost

*** Keywords ***
Open Browser App
    Open Application    
    ...    remote_url=http://localhost:4723
    ...    platformName=Android
    ...    deviceName=emulator-5554
    ...    appPackage=com.android.browser
    ...    appActivity=com.android.browser.BrowserActivity
    ...    automationName=UiAutomator2
    ...    appium:remoteAdbHost=host.docker.internal

*** Test Cases ***
Open Browser App
    Open Browser App
    Sleep    5s
    Capture Page Screenshot
    Close Application

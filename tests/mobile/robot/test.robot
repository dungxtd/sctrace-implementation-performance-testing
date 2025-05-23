*** Settings ***
Library    AppiumLibrary
Library    BuiltIn
Library    OperatingSystem

*** Keywords ***
Open Browser App
    ${docker_adb}=    Get Environment Variable    DOCKER_ADB_HOST    default=False
    ${adb_host}=      Set Variable If    '${docker_adb}' == 'true'    host.docker.internal    localhost
    Open Application    
    ...    remote_url=http://localhost:4723
    ...    platformName=Android
    ...    deviceName=emulator-5554
    ...    appPackage=com.android.chrome
    ...    appActivity=com.google.android.apps.chrome.Main
    ...    automationName=UiAutomator2
    ...    appium:remoteAdbHost=${adb_host}

*** Test Cases ***
Open Browser App
    Open Browser App
    Sleep    5s
    Capture Page Screenshot
    Close Application

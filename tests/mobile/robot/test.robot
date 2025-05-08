*** Settings ***
Library    AppiumLibrary
Library    BuiltIn
Library    OperatingSystem

*** Variables ***
${REMOTE_ADB}=    Get Environment Variable    REMOTE_ADB    false
${REMOTE_ADB_HOST}=    Set Variable If    '${REMOTE_ADB}' == true    host.docker.internal    ELSE    localhost

*** Settings ***
Library    AppiumLibrary
Library    OperatingSystem

*** Keywords ***
Open Browser App
    ${remote_adb}=    Get Environment Variable    REMOTE_ADB    default=False
    ${adb_host}=      Set Variable If    '${remote_adb}' == 'true'    host.docker.internal    localhost
    Open Application    
    ...    remote_url=http://localhost:4723
    ...    platformName=Android
    ...    deviceName=emulator-5554
    ...    appPackage=com.android.browser
    ...    appActivity=com.android.browser.BrowserActivity
    ...    automationName=UiAutomator2
    ...    appium:remoteAdbHost=${adb_host}
    
*** Test Cases ***
Get Environment Variable
    Log    The value of REMOTE_ADB is: ${REMOTE_ADB}
    Log    The value of REMOTE_ADB_HOST is: ${REMOTE_ADB_HOST}
Open Browser App
    Open Browser App
    Sleep    5s
    Capture Page Screenshot
    Close Application

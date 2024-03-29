;*******************************************************************
;Description: ACS
;
;Purpose:
;

;Author: Ganesh
;Company: Brillio
;*********************************************************************

;********************************************
;Include Standard Library

;*******************************************
#include <Constants.au3>
#include <Excel.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <IE.au3>
#include <Clipboard.au3>
#include <Date.au3>
#include <GuiListView.au3>
#include <GUIConstantsEx.au3>
#include <GuiTreeView.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <GuiTreeView.au3>
#include <File.au3>
#include <Testinc.au3>
;******************************************

;***************************************************************
;Initialize AutoIT Key delay
;****************************************************************
AutoItSetOption ( "SendKeyDelay", 400)

;******************************************************************
;Reading test data from xls
;To do - move helper function
;******************************************************************
;Open xls
Local $sFilePath1 =  @ScriptDir & "\" & "TestData.xlsx";This file should already exist in the mentioned path
Local $oExcel = _ExcelBookOpen($sFilePath1,0,True)

;Dim $oExcel1 = _ExcelBookNew(0)

;Check for error
If @error = 1 Then
    MsgBox($MB_SYSTEMMODAL, "Error!", "Unable to Create the Excel Object")
    Exit
ElseIf @error = 2 Then
    MsgBox($MB_SYSTEMMODAL, "Error!", "File does not exist")
    Exit
 EndIf

 ; Reading xls data into variables
;to do - looping to get the data from desired row of xls
;to do - looping to get the data from desired row of xls
Local $testCaseIteration = _ExcelReadCell($oExcel, 15, 1)
Local $testCaseExecute = _ExcelReadCell($oExcel, 15, 2)
Local $testCaseName = _ExcelReadCell($oExcel, 15, 3)
Local $testCaseDescription = _ExcelReadCell($oExcel, 15, 4)
Local $JunoOrKep  = _ExcelReadCell($oExcel, 15, 5)
Local $testCaseEclipseExePath = _ExcelReadCell($oExcel, 15, 6)
;if $JunoOrKep = "Juno" Then
  ; Local $testCaseEclipseExePath = _ExcelReadCell($oExcel, 16, 6)
;Else
   ;Local $testCaseEclipseExePath = _ExcelReadCell($oExcel, 16, 7)
   ;EndIf
Local $testCaseWorkSpacePath = _ExcelReadCell($oExcel, 15, 8)
Local $testCaseProjectName = _ExcelReadCell($oExcel, 15, 9)
Local $testCaseJspName = _ExcelReadCell($oExcel, 15, 10)
Local $testCaseJspText = _ExcelReadCell($oExcel, 15, 11)
Local $testCaseAzureProjectName = _ExcelReadCell($oExcel, 15, 12)
Local $testCaseCheckJdk = _ExcelReadCell($oExcel, 15, 13)
Local $testCaseJdkPath = _ExcelReadCell($oExcel, 15, 14)
Local $testCaseCheckLocalServer = _ExcelReadCell($oExcel, 15, 15)
Local $testCaseServerPath = _ExcelReadCell($oExcel, 15, 16)
Local $testCaseServerNo = _ExcelReadCell($oExcel, 15, 17)
Local $testCaseUrl = _ExcelReadCell($oExcel, 15, 19)
Local $testCaseValidationText = _ExcelReadCell($oExcel, 15, 19)
Local $testCaseSubscription = _ExcelReadCell($oExcel, 15, 20)
Local $testCaseStorageAccount = _ExcelReadCell($oExcel, 15, 21)
Local $testCaseServiceName = _ExcelReadCell($oExcel, 15, 22)
Local $testCaseTargetOS = _ExcelReadCell($oExcel, 15, 23)
Local $testCaseTargetEnvironment = _ExcelReadCell($oExcel, 15, 24)
Local $testCaseCheckOverwrite = _ExcelReadCell($oExcel, 15, 25)
Local $testCaseJDKOnCloud = _ExcelReadCell($oExcel, 15, 28)
Local $testCaseUserName = _ExcelReadCell($oExcel, 15, 29)
Local $testCasePassword = _ExcelReadCell($oExcel, 15, 30)
Local $testcaseNewSessionJSPText = _ExcelReadCell($oExcel, 15, 31)
Local $testcaseExternalJarPath = _ExcelReadCell($oExcel, 15, 32)
Local $testcaseCertificatePath = _ExcelReadCell($oExcel, 15, 33)
Local $testcaseACSLoginUrlPath = _ExcelReadCell($oExcel, 15, 34)
Local $testcaseACSserverUrlPath = _ExcelReadCell($oExcel, 15, 35)
Local $testcaseACSCertiPath = _ExcelReadCell($oExcel, 15, 36)
Local $lcl = _ExcelReadCell($oExcel, 15, 38)
Local $tJDK = _ExcelReadCell($oExcel, 15, 39)
Local $PFXpath = _ExcelReadCell($oExcel, 15, 40)
Local $PFXpassword = _ExcelReadCell($oExcel, 15, 41)
_ExcelBookClose($oExcel,0)
Local $exlid = ProcessExists("excel.exe")
ProcessClose($exlid)
;*******************************************************************************


Start($testCaseName,$testCaseDescription);Calling Start function from Testinc.au3 script(Custom Script file, Contains common functions that are used in other scripts)

Local $pro = ProcessExists("eclipse.exe")
If $pro > 0 Then
  Delete()
Else
 OpenEclipse($testCaseEclipseExePath,$testCaseWorkSpacePath)
 Delete()
EndIf


;Creating Java Project
CreateJavaProject($testCaseProjectName)

;Configure
Configure()

Sleep(3000)
;Creating JSP File
CreateJSPFile($testCaseJspName, $testCaseProjectName, $testCaseJspText)

;Creating Azure Package
CreateAzurePackage($testCaseAzureProjectName, $testCaseCheckJdk, $testCaseJdkPath,$testCaseCheckLocalServer, $testCaseServerPath, $testCaseServerNo,$lcl,$tJDK)
Sleep(10000)

;Enable SSL Offloading
EnableSSLOffloading()
Local $wnd = WinGetHandle("Java EE - MyHelloWorld/WebContent/index.jsp - Eclipse")
 Local $wnd1 = ControlGetHandle($wnd, "", "[CLASS:SysTreeView32; INSTANCE:1]")
 ControlClick($wnd,"",$wnd1,"left")
 Send("^+{NUMPADDIV}")

;Publishing to Cloud
;PublishToCloud($testCaseSubscription, $testCaseStorageAccount, $testCaseServiceName, $testCaseTargetOS, $testCaseTargetEnvironment, $testCaseCheckOverwrite, $testCaseUserName, $testCasePassword)
PublishToCloud($testCaseSubscription, $testCaseStorageAccount, $testCaseServiceName, $testCaseTargetOS, $testCaseTargetEnvironment, $testCaseCheckOverwrite, $testCaseUserName, $testCasePassword,$PFXpath,$PFXpassword)
Sleep(30000)

Publish($testCaseProjectName,$testCaseValidationText)
;**************************************Configuring***************************************************
Func Configure()
   ;Configuring
Send("{APPSKEY}")
Send("B")
Send("{Right}")
Send("c!a!n")
Send("{Tab 6}")
Send("^a {Delete}")
AutoItSetOption ( "SendKeyDelay", 50)
Send($testcaseACSLoginUrlPath)
AutoItSetOption ( "SendKeyDelay", 400)
Send("{Tab}")
AutoItSetOption ( "SendKeyDelay", 50)
Send($testcaseACSserverUrlPath)
AutoItSetOption ( "SendKeyDelay", 400)
Send("{tab 2} {Enter}")
AutoItSetOption ( "SendKeyDelay", 50)
Send($testcaseACSCertiPath)
AutoItSetOption ( "SendKeyDelay", 400)
Send("{Enter}")
Send("{Tab 3}{Space}{Tab}{Space}{Enter}{Tab 2}{Enter}")
Sleep(2000)
Send("{Enter}")
Send("!{F4}")
;Send("{Enter}")
EndFunc

;****************************************************************
;Function to enable SSL Offloading
;***************************************************************
Func EnableSSLOffloading()
;MouseClick("primary",119, 490, 1)

 WinWaitActive("Java EE - MyHelloWorld/WebContent/index.jsp - Eclipse")
Sleep(3000)

Local $wnd = WinGetHandle("Java EE - MyHelloWorld/WebContent/index.jsp - Eclipse")
 Local $wnd1 = ControlGetHandle($wnd, "", "[CLASS:SysTreeView32; INSTANCE:1]")
 ControlClick($wnd,"",$wnd1,"left")
Sleep(2000)
AutoItSetOption ( "SendKeyDelay", 200)
Send("{Up 2}{Right}")
Sleep(2000)
Send("{down}{down}{down}{APPSKEY}")
Sleep(2000)
;if $JunoOrKep = "Juno" Then
;Send("g")
;Else
;Send("e")
;EndIf
Send("e")
if $JunoOrKep = "Juno" Then
Send("{Left}{UP}{Right}{s 2}{Enter}")
Else
Send("{s}{Left}{UP}{UP}{Right}{s 2}{Enter}")
EndIf
WinWaitActive("[Title:Properties for WorkerRole1]")
ControlCommand("Properties for WorkerRole1","","[CLASSNN:Button1]","Check", "")
WinWaitActive("[Title:SSL Offloading]")
Send("{Enter}")
Send("{Tab 4}")
;Dim $hWnd = WinGetHandle("[Title:Properties for WorkerRole1]")
;MsgBox("","",$hWnd)
;Local $hToolBar = ControlGetHandle($hWnd, "", "[Text:<a>Certificates...</a>]")
;MsgBox("","",$hToolBar)
;ControlClick($hWnd,"",6424586,"left",1)

Local $wnd = WinGetHandle("[Title:Properties for WorkerRole1]")
 Local $wnd1 = ControlGetHandle($wnd, "", "[CLASS:SysLink; INSTANCE:2]")
 ControlClick($wnd,"",$wnd1,"left")

 ;MouseClick("primary",1039, 133, 1)
WinWaitActive("[Title:Properties for MyAzureProject]")
Send("{Tab 2}")
Send("{Enter}")
WinWaitActive("[Title:Certificate]")
Send("{Tab 2}")
Send("{Enter}")
Sleep(2000)
Send($testcaseCertificatePath)
;ClipPut($testcaseCertificatePath)
Send("!O")
Send("{Tab 2}")
Send("{Enter}")
Send("{Tab}{Enter}")
Send("{Tab 3}")
Send("{Enter}")
EndFunc
;*********************************************************************






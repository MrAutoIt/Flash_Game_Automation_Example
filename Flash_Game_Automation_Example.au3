#include <IE.au3>

example()

Func example()
	$oIE = _IECreate("http://andkon.com/arcade/puzzle/greatmatemaster/")

	Local $oEmbedFlash = _IETagNameGetCollection($oIE, "embed", 0)
	Local $hWin = _IEPropertyGet($oIE, "hwnd")
	WinSetState($hWin, "", @SW_MAXIMIZE)

	;get the x/y position of the flash game
	Local $iX = _IEPropertyGet($oEmbedFlash, "screenx")
	Local $iY = _IEPropertyGet($oEmbedFlash, "screeny")

	;add click positions
	Local $aPlayChestBtn = [$iX + 240, $iY + 350]
	Local $a2b = [$iX + 120, $iY + 390]
	Local $a4b = [$iX + 120, $iY + 300]

	;click the play chest button
	Click($aPlayChestBtn, 2000)

	;move pawn to 4b with clicks
	Click($a2b, 1000)
	Click($a4b, 1000)

EndFunc   ;==>example

Func Click($aPos, $iWaitTime = 0)
	;waits for a set amount of time for nothing to change where you want to click
	If $iWaitTime <> 0 Then PixelChecksumWait($aPos, $iWaitTime)

	;clicks the area you want to click
	MouseClick("left", $aPos[0], $aPos[1], 1, 0)
EndFunc   ;==>Click

Func PixelChecksumWait($aPos, $iWaitTime = 5000)
	Local $iCheckSum

	;wait to make sure there is no change in the region
	While 1
		;get checksum
		$iCheckSum = PixelChecksum($aPos[1] - 5, $aPos[0] - 5, 10, 10)

		;sleep to make sure there is no change
		Sleep($iWaitTime)

		;exit loop if there was no change
		If $iCheckSum = PixelChecksum($aPos[1] - 5, $aPos[0] - 5, 10, 10) Then ExitLoop
	WEnd
EndFunc   ;==>PixelChecksumWait
